//
//  GooglePlace.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GoogleGeometryVO.h"
#import "GooglePhotoVO.h"

/**
{
    "geometry" : {
        "location" : {
            "lat" : -33.871212,
            "lng" : 151.197984
        }
    },
    "icon" : "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png",
    "id" : "64725a86605e7682a694c5383338e95b8993b398",
    "name" : "ibis Sydney Darling Harbour",
    "photos" : [
                {
                    "height" : 768,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/117979886491291086792\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAANgdpKpWeMohmcjRzyYoqPKBkf77hngteVTOE8hqFAxRR9ZtYFD4pIlyjGraIBKS3WKXP5kr5cnLq4IoAh256O-67uu2TA4Saj3AyGa_ohTvvI8yRAq0_750de-Srdp9jEhB4rDtRuPGpEKpSig_x2ockGhQ2BqnHhMjItVc44AaLMb3tmEYzwQ",
                    "width" : 1024
                }
                ],
    "place_id" : "ChIJFfyzTTeuEmsRuMxvFyNRfbk",
    "rating" : 3.1,
    "reference" : "CnRvAAAAf9shzhUc887sw1c5PCKte4NS7uympygXhLnHYJARpBoA3tLV-Tm3D18lJB1DknuvyCkbl71YB5yUQ3STpmRX--MahB2vSL7RDpT0FkxaKHXroLfaGr1WPg9xXCL2qaRd6pFFBe5d0sdyBwaP-R5dIRIQjEpOAA5sWhknD-ccU4UkyhoUKQY24Z5LkKpOi45vg1hr9O3hnD0",
    "scope" : "GOOGLE",
    "types" : [ "restaurant", "lodging", "food", "point_of_interest", "establishment" ],
    "vicinity" : "70 Murray Street, Pyrmont"
}
**/
@interface GooglePlaceVO : JSONModel
@property(strong, nonatomic) GoogleGeometryVO *geometry;
@property(strong, nonatomic) NSString<Optional> *icon;
@property(strong, nonatomic) NSString *id_;
@property(strong, nonatomic) NSString<Optional> *name;
@property(strong, nonatomic) NSArray<GooglePhotoVO*><Optional> *photos;
@property(strong, nonatomic) NSString *placeId;
@property(strong, nonatomic) NSNumber<Optional> *rating;
@property(strong, nonatomic) NSString *reference;
@property(strong, nonatomic) NSString<Optional> *scope;
@property(strong, nonatomic) NSArray<NSString*><Optional> *types;
@property(strong, nonatomic) NSString<Optional> *vicinity;

@end
