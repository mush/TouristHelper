//
//  MapViewViewModel.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "MapViewViewModel.h"
#import "GMSApiClient.h"

@implementation MapViewViewModel{
    GMSApiClient *apiClient_;
}

-(instancetype)init{

    if (self = [super init]) {
        apiClient_ = [[GMSApiClient alloc] init];
    }
    
    return self;
}

@end
