//
//  GMSApiClient.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "GMSApiClient.h"
#import <AFNetworking.h>
#import "GMSApiKey.h"
#import "GooglePlaceVO.h"

@implementation GMSApiClient{
    NSURL *baseURL_;
    AFHTTPRequestOperationManager *afHTTPManager_;
}
#pragma mark - private
-(BFTask*)getTaskForPath:(NSString*)path withParams:(NSDictionary*)params{
    
    BFTaskCompletionSource *bcs = [BFTaskCompletionSource taskCompletionSource];
    
    [afHTTPManager_ GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [bcs setResult:responseObject];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [bcs setError:error];
    }];
    
    
    return bcs.task;
}
#pragma mark -
-(instancetype)init{
    if (self = [super init]) {
        baseURL_ = [NSURL URLWithString:@"https://maps.googleapis.com"];
        afHTTPManager_ = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL_];
        afHTTPManager_.requestSerializer = [AFJSONRequestSerializer serializer];
        afHTTPManager_.responseSerializer = [AFJSONResponseSerializer serializer];

    }
    return self;
}

-(BFTask *)taskForRadarSearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray *)types{
    
    //https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&key=AIzaSyD_1wjarbzsxkpAYz_RoKX0CIzS0Ba7USs
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                                                                      @"radius" : @"200",
                                                                                      @"location": [NSString stringWithFormat:@"%lf,%lf", coordinate.latitude, coordinate.longitude],
                                                                                      @"types": [types componentsJoinedByString:@"|"]
                                                                                      }];
    
    
    return [[self getTaskForPath:@"/maps/api/place/radarsearch/json" withParams:parameters] continueWithSuccessBlock:^id(BFTask *task) {
        NSMutableArray *places = [NSMutableArray array];
        NSError *error = nil;
        for (id place in task.result[@"results"]) {
            GooglePlaceVO *placeVO = [[GooglePlaceVO alloc] initWithDictionary:place error:&error];
            if (!error) {
                [places addObject:placeVO];
            }else{
                error = nil;
                NSLog(@"%@", [error description]);
            }
        }
        return places;
    }];
    
}

-(BFTask*)taskForPlaceForPlaceId:(NSString*)placeId{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                                                                      @"placeid": placeId
                                                                                      }];
    
    
    return [[self getTaskForPath:@"maps/api/place/details/json" withParams:parameters] continueWithSuccessBlock:^id(BFTask *task) {
        NSError *error = nil;
        GooglePlaceVO *placeVO = [[GooglePlaceVO alloc] initWithDictionary:task.result[@"result"] error:&error];
        return placeVO;
    }];
    
}

@end
