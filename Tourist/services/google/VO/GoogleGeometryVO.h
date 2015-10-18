//
//  GoogleGeometryVO.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GoogleLocationVO.h"

/**
"geometry" : {
    "location" : {
        "lat" : -33.871212,
        "lng" : 151.197984
    }
}
**/

@interface GoogleGeometryVO : JSONModel
@property(strong, nonatomic) GoogleLocationVO *location;
@end
