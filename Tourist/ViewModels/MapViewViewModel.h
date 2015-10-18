//
//  MapViewViewModel.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>


@interface MapViewViewModel : NSObject
@property(strong, nonatomic) NSArray *places;
@property(assign, nonatomic) CLLocationCoordinate2D currentLocation;
@property(assign, readonly) BOOL firstLocationUpdate;
@property(strong, nonatomic, readonly)GMSMutablePath *travelingPath;

@property(strong, readonly) NSString* rightNavButtonTitle;

-(void)handleLocationUpdateForLocation:(CLLocationCoordinate2D)location;

@end
