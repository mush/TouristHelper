//
//  MathArc.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface MathArc : NSObject
+(double)distanceBetweenLoc1:(CLLocationCoordinate2D)loc1 andLoc2:(CLLocationCoordinate2D)loc2;
@end
