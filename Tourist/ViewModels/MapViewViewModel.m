//
//  MapViewViewModel.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "MapViewViewModel.h"
#import "GMSApiClient.h"

@interface MapViewViewModel ()
+(NSArray*)allowedTypes;
@end

@implementation MapViewViewModel{
    GMSApiClient *apiClient_;
}
+(NSArray*)allowedTypes{
    return @[@"food", @"bar", @"museum"];
}
-(instancetype)init{

    if (self = [super init]) {
        _firstLocationUpdate = NO;
        apiClient_ = [[GMSApiClient alloc] init];
        
        _currentLocation = CLLocationCoordinate2DMake(-37.8380298, 144.9911135);
        
        
    }
    
    return self;
}

-(void)handleLocationUpdateForLocation:(CLLocationCoordinate2D)location{
    _currentLocation = location;
    
    if (!_firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        _firstLocationUpdate = YES;
        
        __weak MapViewViewModel *weakSelf = self;
        
        [[apiClient_ taskForRadarSearchForCoordinate:_currentLocation types:[MapViewViewModel allowedTypes]] continueWithBlock:^id(BFTask *task) {
            __strong MapViewViewModel *strongSelf = weakSelf;
            strongSelf.places = [task.result subarrayWithRange:NSMakeRange(0, 100)];
            return nil;
        }];
        
    }
}

@end
