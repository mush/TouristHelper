//
//  GMSApiClient.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "GoogleService.h"
#import <AFNetworking.h>
#import "GMSApiKey.h"
#import "GooglePlaceVO.h"

@implementation GoogleService{

}
#pragma mark - private
-(NSInteger)getMaxNumberOfPlaces{

    if ([self.delegate respondsToSelector:@selector(maxNumPlacesDuringSearch)]) {
        return [self.delegate maxNumPlacesDuringSearch];
    }
    return 200;

}
-(NSString*)getMaxRadiusOfPlacesInMeter{
    if ([self.delegate respondsToSelector:@selector(maxRadiusInMeterDuringSearch)]) {
        return [NSString stringWithFormat:@"%ld", [self.delegate maxRadiusInMeterDuringSearch]];
    }
    return @"2000";
}
#pragma mark -
#pragma mark - BaseService
-(NSURL *)baseURL{
    return [NSURL URLWithString:@"https://maps.googleapis.com"];
}
#pragma mark -
-(BFTask *)taskForRadarSearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray *)types{
    
    //https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&key=AIzaSyD_1wjarbzsxkpAYz_RoKX0CIzS0Ba7USs
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                                                                      @"radius" : [self getMaxRadiusOfPlacesInMeter],
                                                                                      @"location": [NSString stringWithFormat:@"%lf,%lf", coordinate.latitude, coordinate.longitude],
                                                                                      @"types": [types componentsJoinedByString:@"|"]
                                                                                      }];
    
    
    return [[self getRequestTaskForPath:@"/maps/api/place/radarsearch/json" withParams:parameters] continueWithSuccessBlock:^id(BFTask *task) {

        NSMutableArray *placeDetailsTasks = [NSMutableArray array];

        NSArray *slicedResult;
        if ([task.result[@"results"] count] < [self getMaxNumberOfPlaces]) {
            slicedResult = task.result[@"results"];
        }else{
            slicedResult = [task.result[@"results"] subarrayWithRange:NSMakeRange(0, [self getMaxNumberOfPlaces])];
        }
        
        for (id place in slicedResult) {
            [placeDetailsTasks addObject:[self taskForPlaceForPlaceId:place[@"place_id"]]];
        }
        
        return [BFTask taskForCompletionOfAllTasksWithResults:placeDetailsTasks];
        
    }];
    
}

-(BFTask*)taskForPlaceForPlaceId:(NSString*)placeId{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                                                                      @"placeid": placeId
                                                                                      }];
    
    
    return [[self getRequestTaskForPath:@"maps/api/place/details/json" withParams:parameters] continueWithSuccessBlock:^id(BFTask *task) {
        NSError *error = nil;
        GooglePlaceVO *placeVO = [[GooglePlaceVO alloc] initWithDictionary:task.result[@"result"] error:&error];
        return placeVO;
    }];
    
}

@end
