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
#import "MathArc.h"

@interface MapViewViewModel ()<GoogleServiceProtocol>
+(NSArray*)allowedTypes;
@property(strong, nonatomic) NSArray *places;
@property(assign, nonatomic) CLLocationCoordinate2D currentLocation;
@property(assign, nonatomic) BOOL firstLocationUpdate;
@property(strong, nonatomic) OptimalPathModel *optimalPathModel;
@property(strong, nonatomic) NSString* rightNavButtonTitle;
@property(strong, nonatomic) NSMutableArray *optimalPathData;
@property(strong, nonatomic) GMSPath *optimalPath;
@property(strong, nonatomic) NSString *tableHeaderText;

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
        
        self.tableHeaderText = @"Optimal Path";
        
        googleService_ = [[GoogleService alloc] init];
        googleService_.delegate = self;
        
        _currentLocation = CLLocationCoordinate2DMake(-37.8380298, 144.9911135);
        
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
    
    NSMutableArray *data = [NSMutableArray array];
    
    for (int i = 0; i < self.optimalPathModel.optimalPath.count - 1; i++) {
        CLLocationCoordinate2D point1 = [self.optimalPathModel.optimalPath coordinateAtIndex:i];
        CLLocationCoordinate2D point2 = [self.optimalPathModel.optimalPath coordinateAtIndex:i + 1];
        
        GMSMutablePath *path = [GMSMutablePath path];
        [path addCoordinate:point1];
        [path addCoordinate:point2];
        
        [data addObject:@{@"title":[NSString stringWithFormat:@"%lf", [MathArc distanceBetweenLoc1:point1 andLoc2:point2]*1000],
                          @"path": [[GMSPath alloc]initWithPath:path]
                          }
         ];
    }

    self.optimalPathData = data;
    self.optimalPath = self.optimalPathModel.optimalPath;
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

#pragma mark - GoogleServiceProtocol
-(NSInteger)maxNumPlacesDuringSearch{
    return 100;
}
-(NSInteger)maxRadiusInMeterDuringSearch{
    return 2000;
}
#pragma mark -

@end
