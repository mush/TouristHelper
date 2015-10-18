#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

#import "GooglePlaceVO.h"

@interface MapViewController ()

@end

@implementation MapViewController {
    GMSMapView *mapView_;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.viewModel = [[MapViewViewModel alloc]init];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:self.viewModel.rightNavButtonTitle style:UIBarButtonSystemItemAction target:self action:@selector(showPath:)];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.zoomGestures = YES;
        
    [self.KVOController observe:mapView_ keyPath:@"myLocation" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        if (!self.viewModel.firstLocationUpdate) {
        
            CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
            
            [self.viewModel handleLocationUpdateForLocation:location.coordinate];
            
            mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];            
        }
    }];
    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
    
    [self.KVOController observe:self.viewModel keyPath:@"places" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        for (GooglePlaceVO *vo in change[NSKeyValueChangeNewKey]) {
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(vo.geometry.location.lat, vo.geometry.location.lng);
            marker.map = mapView_;
        }
        
    }];
    
    [self.KVOController observe:self.viewModel keyPath:@"travelingPath" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        GMSPolyline *polyLine = [[GMSPolyline alloc] init];
        polyLine.path = change[NSKeyValueChangeNewKey];
        polyLine.strokeWidth = 2;
        polyLine.map = mapView_;
    }];
    
    
}

- (void)dealloc {
}

@end
