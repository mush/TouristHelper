//
//  BaseService.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService{
    AFHTTPRequestOperationManager *afHTTPManager_;
}

-(instancetype)init{

    if (self = [super init]) {
        afHTTPManager_ = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[self baseURL]];
        afHTTPManager_.requestSerializer = [self requestSerializer];
        afHTTPManager_.responseSerializer = [self responseSerializer];
    }
    
    return self;
}

-(BFTask*)getTaskForPath:(NSString*)path withParams:(NSDictionary*)params{
    
    BFTaskCompletionSource *bcs = [BFTaskCompletionSource taskCompletionSource];
    
    [afHTTPManager_ GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [bcs setResult:responseObject];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [bcs setError:error];
    }];
    
    
    return bcs.task;
}

-(NSURL*)baseURL{
    return nil;
}

-(AFHTTPRequestSerializer*)requestSerializer{
    return [AFJSONRequestSerializer serializer];
}

-(AFHTTPResponseSerializer*)responseSerializer{
    return [AFJSONResponseSerializer serializer];
}
@end
