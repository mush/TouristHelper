//
//  GooglePlace.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "GooglePlaceVO.h"

@implementation GooglePlaceVO
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"id_",
                                                       @"place_id" : @"placeId"
                                                       }];
}
@end
