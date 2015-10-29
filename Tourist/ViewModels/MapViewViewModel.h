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
#import "OptimalPathModel.h"

/**
 *  the viewmodel that represents MapViewController view
 */
@interface MapViewViewModel : NSObject

/**
 *  an array of GooglePlaceVOs. this will be updated when the response from GMS comes.
 */
@property(readonly, nonatomic) NSArray *places;

/**
 *  current location of the user
 */
@property(readonly, nonatomic) CLLocationCoordinate2D currentLocation;

/**
 *  a flag that checks first time location update.
 */
@property(readonly, nonatomic) BOOL firstLocationUpdate;

/**
 *  title for the right nav title.
 */
@property(readonly, nonatomic) NSString* rightNavButtonTitle;

/**
 *  handles the current location update.
 *
 *  @param location <#location description#>
 */
-(void)handleLocationUpdateForLocation:(CLLocationCoordinate2D)location;

/**
 *  describing the table view rows. each item contains a @{title:<NSString>, @"path":<GMSPath>}
 */
@property(readonly, nonatomic) NSArray *optimalPathData;

/**
 *  the optimal path calculated.
 */
@property(readonly, nonatomic) GMSPath *optimalPath;


@property(readonly, nonatomic) NSString *tableHeaderText;

@end
