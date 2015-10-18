//
//  OptimalPathModel.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "OptimalPathModel.h"
#import "MathArc.h"
#import "GooglePlaceVO.h"

@implementation OptimalPathModel{
    NSArray *places_;
}

#pragma mark - private
-(NSDictionary*)optimalTravellingPathForPath:(GMSPath*)path withOrigin:(CLLocationCoordinate2D)origin{
    
    NSInteger locNum = path.count;
    bool *visited = (bool*)calloc(path.count, sizeof(bool));
    
    GMSMutablePath *optimalPath = [GMSMutablePath path];
    double tDistance = 0;
    [optimalPath addCoordinate:origin];
    
    CLLocationCoordinate2D now = origin;
    
    while(locNum > 0){
        NSInteger nextMinLocIndex = -1;
        double currentMin = DBL_MAX;
        for(int i = 0; i < path.count; i++){
            if (visited[i]) {
                continue;
            }
            
            double min = [MathArc distanceBetweenLoc1:now andLoc2:[path coordinateAtIndex:i]];
            if (min < currentMin) {
                currentMin = min;
                nextMinLocIndex = i;
            }
        }
        now = [path coordinateAtIndex:nextMinLocIndex];
        tDistance += currentMin;
        [optimalPath addCoordinate:now];
        visited[nextMinLocIndex] = true;
        locNum--;
    }
    //[optimalPath removeLastCoordinate];
    delete [] visited;
    
    [optimalPath addCoordinate:origin];
    return [NSDictionary dictionaryWithObjectsAndKeys:optimalPath,@"optimal_path", [NSNumber numberWithDouble:tDistance], @"total_distance", nil];
}
#pragma mark -


-(instancetype)initWithGMSPath:(GMSPath*)path forOrigin:(CLLocationCoordinate2D)origin{

    if (self = [super init]) {
        NSDictionary *optimalResult = [self optimalTravellingPathForPath:path withOrigin:origin];
        _optimalPath = optimalResult[@"optimal_path"];
        _totalDistance = [optimalResult[@"total_distance"] doubleValue];
    }
    
    return self;
}
-(instancetype)initWithPlaces:(NSArray*)places forOrigin:(CLLocationCoordinate2D)origin{
    places_ = places;
    GMSMutablePath *path = [GMSMutablePath path];
    
    for (GooglePlaceVO *vo in places_) {
        [path addLatitude:vo.geometry.location.lat longitude:vo.geometry.location.lng];
    }
    return [self initWithGMSPath:path forOrigin:origin];
}
@end
