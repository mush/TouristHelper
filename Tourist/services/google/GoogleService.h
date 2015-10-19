//
//  GMSApiClient.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseService.h"

@protocol GoogleServiceProtocol <NSObject>

@optional
/**
 *  max num of places when the places are returned by the service.
 *
 *  @return
 */
-(NSInteger)maxNumPlacesDuringSearch;
/**
 *  max radius for the search being taken place.
 *
 *  @return
 */
-(NSInteger)maxRadiusInMeterDuringSearch;

@end

@interface GoogleService : BaseService

@property(weak) id<GoogleServiceProtocol> delegate;

/**
 *  calls and cosumes the GMS endpoint /maps/api/place/radarsearch/
 *
 *  @param coordinate center location
 *  @param types      types of places. e.g. food, bar, museum, park etc.
 *
 *  @return returns a BFTask that has result of array of GooglePlaceVO
 */
-(BFTask*)taskForRadarSearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray*)types;
/**
 *  gives details of a place by calling and consuming GMS endpoint maps/api/place/details/
 *
 *  @param placeId place id as NSString
 *
 *  @return returns a BFTask that has result of GooglePlaceVO type.
 */
-(BFTask*)taskForPlaceForPlaceId:(NSString*)placeId;
@end
