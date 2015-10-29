//
//  MathArc.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "MathArc.h"

@implementation MathArc
+(double)distanceBetweenLoc1:(CLLocationCoordinate2D)loc1 andLoc2:(CLLocationCoordinate2D)loc2{
    
    CLLocation *l1 = [[CLLocation alloc] initWithLatitude:loc1.latitude longitude:loc1.longitude];
    
    CLLocation *l2 = [[CLLocation alloc] initWithLatitude: loc2.latitude longitude:loc2.longitude];
    
    return [l1 distanceFromLocation: l2];
}

@end
