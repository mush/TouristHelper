//
//  OptimalPathModel.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
/**
 *  This model provides the optimal path for a given set of locations (given as paht).
 */
@interface OptimalPathModel : NSObject

@property(readonly, nonatomic) double totalDistance;
@property(readonly, nonatomic) GMSPath *optimalPath;

-(instancetype)initWithGMSPath:(GMSPath*)path forOrigin:(CLLocationCoordinate2D)origin;
-(instancetype)initWithPlaces:(NSArray*)places forOrigin:(CLLocationCoordinate2D)origin;
@end
