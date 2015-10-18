#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

#import "GooglePlaceVO.h"
#import "MarkerInfoView.h"
#import "MathArc.h"

@interface MapViewController ()<GMSMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation MapViewController {
    GMSMapView *mapView_;
    MarkerInfoView *markerInfoView_;
    UITableView *tableView_;
    GMSPolyline *polyLine_;
}

#pragma mark - private
- (NSArray *)gradientSpansForArrayCount:(NSInteger)count {
    NSMutableArray *colorSpans = [NSMutableArray array];
    UIColor *prevColor;
    for (NSUInteger i = 0; i < count; i++) {

        
        UIColor *toColor = [UIColor colorWithHue:(float)i/count
                                      saturation:1.f
                                      brightness:.9f
                                           alpha:1.f];
        
        if (prevColor == nil) {
            prevColor = toColor;
        }
        
        GMSStrokeStyle *style = [GMSStrokeStyle gradientFromColor:prevColor toColor:toColor];
        [colorSpans addObject:[GMSStyleSpan spanWithStyle:style]];
        
        prevColor = toColor;
    }
    return colorSpans;
}
- (void)setupMapView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.zoomGestures = YES;
    mapView_.delegate = self;
    
    [self.view addSubview:mapView_];
    
    [mapView_ makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
}
- (void)setupKVO {
    
    [self.KVOController observe:mapView_ keyPath:@"myLocation" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        if (!self.viewModel.firstLocationUpdate) {
            
            CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
            
            [self.viewModel handleLocationUpdateForLocation:location.coordinate];
            
            mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                             zoom:14];
        }
    }];
    
    [self.KVOController observe:self.viewModel keyPath:@"places" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        for (GooglePlaceVO *vo in change[NSKeyValueChangeNewKey]) {
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.userData = vo;
            marker.snippet = vo.formattedAddress;
            marker.title = vo.name;
            marker.position = CLLocationCoordinate2DMake(vo.geometry.location.lat, vo.geometry.location.lng);
            marker.map = mapView_;
        }
        
    }];
    
    [self.KVOController observe:self.viewModel keyPath:@"optimalPathModel" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

-(void)setupTableView{
    tableView_ = [[UITableView alloc]init];
    [self.view addSubview:tableView_];
 
    tableView_.delegate = self;
    tableView_.dataSource = self;
    
    [tableView_ registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pathcell"];
    
    [tableView_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.width.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.3);
    }];
    
}

#pragma mark -

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.viewModel = [[MapViewViewModel alloc]init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:self.viewModel.rightNavButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(showPath:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self setupMapView];
    
    [self setupTableView];
    
    [self setupKVO];
    
}

- (void)dealloc {
}
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lbl = [UILabel new];
    lbl.text = @"Optimal Path";
    lbl.textAlignment = NSTextAlignmentCenter;
    return lbl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.optimalPathModel.optimalPath.count - 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:@"pathcell"];
    CLLocationCoordinate2D point1 = [self.viewModel.optimalPathModel.optimalPath coordinateAtIndex:indexPath.row];
    CLLocationCoordinate2D point2 = [self.viewModel.optimalPathModel.optimalPath coordinateAtIndex:indexPath.row + 1];
    cell.textLabel.text = [NSString stringWithFormat:@"%lf", [MathArc distanceBetweenLoc1:point1 andLoc2:point2]*1000];
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    polyLine_.map = nil;
    polyLine_ = [[GMSPolyline alloc] init];
    polyLine_.strokeWidth = 2;
    polyLine_.map = mapView_;
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:[self.viewModel.optimalPathModel.optimalPath coordinateAtIndex:indexPath.row]];
    [path addCoordinate:[self.viewModel.optimalPathModel.optimalPath coordinateAtIndex:indexPath.row+1]];
    polyLine_.path = [[GMSPath alloc]initWithPath:path];
}
#pragma mark -
#pragma mark - actions
-(void)showPath:(id)sender{
    polyLine_.map = nil;
    polyLine_ = [[GMSPolyline alloc] init];
    polyLine_.path = self.viewModel.optimalPathModel.optimalPath;
    polyLine_.strokeWidth = 2;
    polyLine_.map = mapView_;
    //polyLine.spans = [self gradientSpansForArrayCount:self.viewModel.optimalPathModel.optimalPath.count];
    [tableView_ reloadData];

}
#pragma mark -

#pragma mark - GMSMapViewDelegate

#pragma mark -

@end
