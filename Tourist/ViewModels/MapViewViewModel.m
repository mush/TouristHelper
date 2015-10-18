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

@interface MapViewViewModel ()<GoogleServiceProtocol>
+(NSArray*)allowedTypes;
@property(strong) OptimalPathModel *optimalPathModel;
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
        googleService_.delegate = self;
        
        _currentLocation = CLLocationCoordinate2DMake(-37.8380298, 144.9911135);
        
        //_travelingPath = [GMSMutablePath path];
        
        _rightNavButtonTitle = @"Connect the Dots";
    }
    
    return self;
}
-(void)setPlaces:(NSArray *)places{

    if (_places == places) {
        return;
    }
    _places = places;
    
    self.optimalPathModel = [[OptimalPathModel alloc] initWithPlaces:_places forOrigin:_currentLocation];

}

-(void)handleLocationUpdateForLocation:(CLLocationCoordinate2D)location{
    _currentLocation = location;
    
    if (!_firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        _firstLocationUpdate = YES;
        
        [[googleService_ taskForRadarSearchForCoordinate:_currentLocation types:[MapViewViewModel allowedTypes]] continueWithBlock:^id(BFTask *task) {
            
            self.places = task.result;

            return nil;
        }];
        
    }
}

-(BFTask*)taskForInfoWindowLoadForPlaceId:(NSString*)placeId{

    return [[googleService_ taskForPlaceForPlaceId:placeId] continueWithSuccessBlock:^id(BFTask *task) {
        GooglePlaceVO *vo = task.result;
        return [NSDictionary dictionaryWithObjectsAndKeys:vo.name, @"title", [vo.rating stringValue], @"rating", nil];
    }];

}

#pragma mark - GoogleServiceProtocol
-(NSInteger)maxNumPlacesDuringSearch{
    return 5;
}
-(NSInteger)maxRadiusInMeterDuringSearch{
    return 200;
}
#pragma mark -

@end
