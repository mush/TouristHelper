//
//  GoogleLocationVO.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <CoreLocation/CoreLocation.h>

/**
"location" : {
    "lat" : -33.871212,
    "lng" : 151.197984
}
**/

@interface GoogleLocationVO : JSONModel
@property(assign, nonatomic) CLLocationDegrees lat;
@property(assign, nonatomic) CLLocationDegrees lng;
@end
