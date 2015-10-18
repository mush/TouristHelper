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
    
    double lat1rad = loc1.latitude * M_PI/180;
    double lon1rad = loc1.longitude * M_PI/180;
    double lat2rad = loc2.latitude * M_PI/180;
    double lon2rad = loc2.longitude * M_PI/180;
    
    //deltas
    double dLat = lat2rad - lat1rad;
    double dLon = lon2rad - lon1rad;
    
    double a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1rad) * cos(lat2rad);
    double c = 2 * asin(sqrt(a));
    double R = 6372.8;
    return R * c;
}

@end
