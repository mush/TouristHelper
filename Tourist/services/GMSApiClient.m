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
    BFTaskCompletionSource *allTasks_;
    NSMutableArray *places_;
}

-(instancetype)init{
    if (self = [super init]) {
        baseURL_ = [NSURL URLWithString:@"https://maps.googleapis.com"];
        afHTTPManager_ = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL_];
        afHTTPManager_.requestSerializer = [AFJSONRequestSerializer serializer];
        afHTTPManager_.responseSerializer = [AFJSONResponseSerializer serializer];

        allTasks_ = [BFTaskCompletionSource taskCompletionSource];
        places_ = [NSMutableArray array];
    }
    return self;
}

-(void)requestTaskForParam:(NSDictionary*)params{
    //BFTaskCompletionSource *btc = [BFTaskCompletionSource taskCompletionSource];
    __weak GMSApiClient *weakSelf = self;
    [afHTTPManager_ GET:@"/maps/api/place/nearbysearch/json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        __strong GMSApiClient *strongSelf = weakSelf;
        NSMutableArray *places = [NSMutableArray array];
        NSError *error = nil;
        for (id place in responseObject[@"results"]) {
            GooglePlaceVO *placeVO = [[GooglePlaceVO alloc] initWithDictionary:place error:&error];
            if (!error) {
                [places addObject:placeVO];
            }else{
                error = nil;
                NSLog(@"%@", [error description]);
            }
        }
        
        [places_ addObjectsFromArray:places];
        
        if (responseObject[@"next_page_token"]) {
            //pagetoken = responseObject[@"next_page_token"];
            NSMutableDictionary *paramDict = [params mutableCopy];
            paramDict[@"pagetoken"] = responseObject[@"next_page_token"];
            [strongSelf requestTaskForParam:paramDict];
            NSLog(@"###### ");
        }else{
            NSLog(@"********** done");
            [allTasks_ setResult:places_];
        }
        //[btc setResult:@{@"places": places, @"pagetoken": pagetoken}];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //[btc setError:error];
        [allTasks_ setError:error];
    }];
    
    //return allTasks_.task;
}

-(BFTask *)taskForNearbySearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray *)types pageToken:(NSString *)token{
    //BFTaskCompletionSource *btc = [BFTaskCompletionSource taskCompletionSource];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                 @"radius" : @"25000",
                                 @"location": [NSString stringWithFormat:@"%lf,%lf", coordinate.latitude, coordinate.longitude],
                                 @"types": [types componentsJoinedByString:@"|"]
                                                                                      }];
    if (token && token.length > 0) {
        parameters[@"pagetoken"] = token;
    }
    
    //BFTask *task = [self requestTaskForParam:parameters];
    
    [self requestTaskForParam:parameters];
    
    return allTasks_.task;

}

-(BFTask*)taskForNearbySearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray*)types{

    //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=cruise&key=YOUR_API_KEY

    return [self taskForNearbySearchForCoordinate:coordinate types:types pageToken:nil];
    
}

-(BFTask *)taskForRadarSearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray *)types{
    
    //https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&key=AIzaSyD_1wjarbzsxkpAYz_RoKX0CIzS0Ba7USs
    
    BFTaskCompletionSource *bcs = [BFTaskCompletionSource taskCompletionSource];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                                                                      @"radius" : @"25000",
                                                                                      @"location": [NSString stringWithFormat:@"%lf,%lf", coordinate.latitude, coordinate.longitude],
                                                                                      @"types": [types componentsJoinedByString:@"|"]
                                                                                      }];
    
    [afHTTPManager_ GET:@"/maps/api/place/radarsearch/json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSMutableArray *places = [NSMutableArray array];
        NSError *error = nil;
        for (id place in responseObject[@"results"]) {
            GooglePlaceVO *placeVO = [[GooglePlaceVO alloc] initWithDictionary:place error:&error];
            if (!error) {
                [places addObject:placeVO];
            }else{
                error = nil;
                NSLog(@"%@", [error description]);
            }
        }
        
        [bcs setResult:places];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [bcs setError:error];
    }];

    return bcs.task;
}

-(BFTask*)taskForPlaceForPlaceId:(NSString*)placeId{
    BFTaskCompletionSource *bcs = [BFTaskCompletionSource taskCompletionSource];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"key": kApiKey,
                                                                                      @"placeid": placeId
                                                                                      }];
    
    
    [afHTTPManager_ GET:@"maps/api/place/details/json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError *error = nil;
        GooglePlaceVO *placeVO = [[GooglePlaceVO alloc] initWithDictionary:responseObject[@"result"] error:&error];
        
        [bcs setResult:placeVO];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [bcs setError:error];
    }];

    return bcs.task;
}

@end
