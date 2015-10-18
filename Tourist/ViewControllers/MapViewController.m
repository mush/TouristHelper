#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

#import "GooglePlaceVO.h"
#import "MarkerInfoView.h"

@interface AsynGMSMarker : GMSMarker

@end

@interface MapViewController ()<GMSMapViewDelegate>

@end

@implementation MapViewController {
    GMSMapView *mapView_;
    MarkerInfoView *markerInfoView_;
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
#pragma mark -

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.viewModel = [[MapViewViewModel alloc]init];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:self.viewModel.rightNavButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(showPath:)];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.zoomGestures = YES;
    mapView_.delegate = self;
        
    [self.KVOController observe:mapView_ keyPath:@"myLocation" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        if (!self.viewModel.firstLocationUpdate) {
        
            CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
            
            [self.viewModel handleLocationUpdateForLocation:location.coordinate];
            
            mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];            
        }
    }];
    
    [self.view addSubview:mapView_];
    [mapView_ makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
    
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
    
    }];
    
    
    markerInfoView_ = [[MarkerInfoView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];

}

- (void)dealloc {
}

#pragma mark - actions
-(void)showPath:(id)sender{
    
    GMSPolyline *polyLine = [[GMSPolyline alloc] init];
    polyLine.path = self.viewModel.optimalPathModel.optimalPath;
    polyLine.strokeWidth = 2;
    polyLine.map = mapView_;
    polyLine.spans = [self gradientSpansForArrayCount:self.viewModel.optimalPathModel.optimalPath.count];

}
#pragma mark -

#pragma mark - GMSMapViewDelegate

#pragma mark -

@end
