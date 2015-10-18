//
//  MapViewViewModel.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "MapViewViewModel.h"
#import "GoogleService.h"
#import "GooglePlaceVO.h"

@interface MapViewViewModel ()
+(NSArray*)allowedTypes;
@property(strong) GMSMutablePath *travelingPath;
@end

@implementation MapViewViewModel{
    GoogleService *googleService_;
}
+(NSArray*)allowedTypes{
    return @[@"food", @"bar", @"museum"];
}
-(instancetype)init{

    if (self = [super init]) {
        _firstLocationUpdate = NO;
        googleService_ = [[GoogleService alloc] init];
        
        _currentLocation = CLLocationCoordinate2DMake(-37.8380298, 144.9911135);
        
        _travelingPath = [GMSMutablePath path];
        
        _rightNavButtonTitle = @"Connect the Dot";
    }
    
    return self;
}

-(void)setPlaces:(NSArray *)places{

    if (_places == places) {
        return;
    }
    _places = places;
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    [path addLatitude:_currentLocation.latitude longitude:_currentLocation.longitude];
    
    for (GooglePlaceVO *vo in _places) {
        [path addLatitude:vo.geometry.location.lat longitude:vo.geometry.location.lng];
    }
    [path addLatitude:_currentLocation.latitude longitude:_currentLocation.longitude];
    self.travelingPath = path;

}

-(void)handleLocationUpdateForLocation:(CLLocationCoordinate2D)location{
    _currentLocation = location;
    
    if (!_firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        _firstLocationUpdate = YES;
        
        __weak MapViewViewModel *weakSelf = self;
        
        [[googleService_ taskForRadarSearchForCoordinate:_currentLocation types:[MapViewViewModel allowedTypes]] continueWithBlock:^id(BFTask *task) {
            __strong MapViewViewModel *strongSelf = weakSelf;
            
            if ([task.result count] > 100) {
                strongSelf.places = [task.result subarrayWithRange:NSMakeRange(0, 5)];
            }else{
                strongSelf.places = task.result;
            }
            
            
            return nil;
        }];
        
    }
}

@end
