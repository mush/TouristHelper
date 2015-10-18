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
-(NSInteger)maxNumPlacesDuringSearch;
-(NSInteger)maxRadiusInMeterDuringSearch;

@end

@interface GoogleService : BaseService

@property(weak) id<GoogleServiceProtocol> delegate;

-(BFTask*)taskForRadarSearchForCoordinate:(CLLocationCoordinate2D)coordinate types:(NSArray*)types;
-(BFTask*)taskForPlaceForPlaceId:(NSString*)placeId;
@end
