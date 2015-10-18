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
/*
{
    "address_components" : [
                            {
                                "long_name" : "Sydney",
                                "short_name" : "Sydney",
                                "types" : [ "locality", "political" ]
                            },
                            {
                                "long_name" : "New South Wales",
                                "short_name" : "NSW",
                                "types" : [ "administrative_area_level_1", "political" ]
                            },
                            {
                                "long_name" : "Australia",
                                "short_name" : "AU",
                                "types" : [ "country", "political" ]
                            },
                            {
                                "long_name" : "2000",
                                "short_name" : "2000",
                                "types" : [ "postal_code" ]
                            }
                            ],
    "adr_address" : "32 The Promenade, \u003cspan class=\"street-address\"\u003eKing Street Wharf 5\u003c/span\u003e, \u003cspan class=\"locality\"\u003eSydney\u003c/span\u003e \u003cspan class=\"region\"\u003eNSW\u003c/span\u003e \u003cspan class=\"postal-code\"\u003e2000\u003c/span\u003e, \u003cspan class=\"country-name\"\u003eAustralia\u003c/span\u003e",
    "formatted_address" : "32 The Promenade, King Street Wharf 5, Sydney NSW 2000, Australia",
    "formatted_phone_number" : "(02) 8296 7296",
    "geometry" : {
        "location" : {
            "lat" : -33.867591,
            "lng" : 151.201196
        }
    },
    "icon" : "https://maps.gstatic.com/mapfiles/place_api/icons/travel_agent-71.png",
    "id" : "a97f9fb468bcd26b68a23072a55af82d4b325e0d",
    "international_phone_number" : "+61 2 8296 7296",
    "name" : "Australian Cruise Group",
    "opening_hours" : {
        "open_now" : false,
        "periods" : [
                     {
                         "close" : {
                             "day" : 0,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 0,
                             "time" : "0900"
                         }
                     },
                     {
                         "close" : {
                             "day" : 1,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 1,
                             "time" : "0900"
                         }
                     },
                     {
                         "close" : {
                             "day" : 2,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 2,
                             "time" : "0900"
                         }
                     },
                     {
                         "close" : {
                             "day" : 3,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 3,
                             "time" : "0900"
                         }
                     },
                     {
                         "close" : {
                             "day" : 4,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 4,
                             "time" : "0900"
                         }
                     },
                     {
                         "close" : {
                             "day" : 5,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 5,
                             "time" : "0900"
                         }
                     },
                     {
                         "close" : {
                             "day" : 6,
                             "time" : "2200"
                         },
                         "open" : {
                             "day" : 6,
                             "time" : "0900"
                         }
                     }
                     ],
        "weekday_text" : [
                          "Monday: 9:00 am – 10:00 pm",
                          "Tuesday: 9:00 am – 10:00 pm",
                          "Wednesday: 9:00 am – 10:00 pm",
                          "Thursday: 9:00 am – 10:00 pm",
                          "Friday: 9:00 am – 10:00 pm",
                          "Saturday: 9:00 am – 10:00 pm",
                          "Sunday: 9:00 am – 10:00 pm"
                          ]
    },
    "photos" : [
                {
                    "height" : 1331,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAACU04jbQP7apa47b4Mzye37QJDyofE-574SrqjDgfrv52MC7NOf6XY8LmC2nFAPh5i6OBPv_lC_ummJz1a_YJz31BhhTBlmdfFooFqu6DJGxbon5dIevVw3RMeOL6HPj8EhAJwa6f0p3vfyGRGh6-JPG4GhQ8tTQsxWCwyqSnOOUq0rXcpCzayw",
                    "width" : 2000
                },
                {
                    "height" : 1320,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAA3j96o6A753kZokr7yMkkg1mUjLbMSx8d1nRg0SvkmwhBuqrLDQ3qPx-kmJFEAFJJYlcjAHHfYxTTLY8OshbtkRsswLShy_U2JHO4IU5ybhA6rrvs4hbHfZiak7AJ4exIEhBy7rZbu3NYlPR4rlSbcIpLGhQcMKRS_agOQAzHBLC1lvIpwt9YMA",
                    "width" : 2048
                },
                {
                    "height" : 1331,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAATLr_vXLV6wZLXQ-dxw8nErBkYM0dQuQxkGJy4dEca4qp2SO5C0mfwX3of-p7tx5iw8XG0bHhlppilrXx9BYJwppvmA7BTsMDQwTEMi60ntSvdfaRAKJ6ClsgCQqZdGKiEhB8WmxOCY5aTv68txrYgmc0GhQNSkYDzMrldaJMfp3h6XMz-5h6tw",
                    "width" : 2000
                },
                {
                    "height" : 1607,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAAJBeqmal3u46fw_ijN8ZMee67Hk8cFhZ9TtHkAYrlm2R90-INdG7stZaFla9piBfG9yGg-lhoGSj35qdwIJqSxqAKbV9uIu_luSQWviwadRnIjwCJ6l_LCFL1DJsNG0CREhD6wMzL8hQ4G8AejpCAwhczGhQkFXmmJhDmuBYxP5jbiFefWA2N8Q",
                    "width" : 1969
                },
                {
                    "height" : 417,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAAkGwBC_6zKVmv4HEvCi00sQwBbp4HWENwMxV6kueZmGrKKsHV_moRqqPt80L58I_1sHbUfUeUbhsW96KsmmE09YVcB0sejD-0C4IghZHW5dIxp9ChPU_dXurfUHWsU1gXEhBDHQnKDV0SBTyjJqfd9QJ7GhQ786ZecpIBX5X-z3_gNZejIRRt_w",
                    "width" : 1334
                },
                {
                    "height" : 300,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAArZDwaqZX0V6m2PDBFkScZy8QtMyyniItdZiU5z1BNGHqmfKjAozfYqhy_ECIi3IDw7NU4l-hviOeK4A4qeCkTZnmPOQz-ce9GWCfuJfgmnnsDJus3E_CJC6ioOrtaT0PEhC39Ui1GAjH5mBzdFVW-avWGhQ_52zx_7pontJRah9RGQfa8p5Y1g",
                    "width" : 300
                },
                {
                    "height" : 1119,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAAiC88kMYY-MBsxZeX1yH-EbmaBuOoKn-VWYhO8tY45b5MWWsrVKdKuU7ZERIMmdIwXHGC2cnn_bo91DVoNJMj0jzURhIfeWtuM5IiT3djidg6kWuGz9RrVdFHmLovDZ8KEhDUvEK465G0z-4UDrqkch6KGhSz3_xFz9i1NwLnPVDoCGoNCtPY0Q",
                    "width" : 2000
                },
                {
                    "height" : 300,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAAjtrV5h0YdqEAvkOXy8GkmOHTobdFw6YpIoV6RpL9vYCj6-XAKq-vtotjRB-1IuON7LULu2cG8Fy_6UaSuHy76s7J9egdVjtU8vwHHnjioOQoypOYfe36-dAoKVEG25NGEhAIaglhIum15z3xrbHMV0TsGhRpY8ybBBIVpniwzg3IWZjaymAd8g",
                    "width" : 300
                },
                {
                    "height" : 426,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAAGDEIsSJniHqvFKi-xmO-Hj5FJ-oG9pW61U5IUAqVTYP1ln7JYEnL46nGciTbP6z8Mni1w2R7b1KxUg3G6DqA0Udq38nz_aPe4fa7i-Q3HeMEewOlfSTymZFuWelz8xFUEhC7VMUw5CP13bP2lYhVe2F2GhR9u4XDti7CzFEsL7W65NEEvGRcgQ",
                    "width" : 640
                },
                {
                    "height" : 250,
                    "html_attributions" : [
                                           "\u003ca href=\"https://maps.google.com/maps/contrib/110751364053842618118\"\u003eFrom a Google User\u003c/a\u003e"
                                           ],
                    "photo_reference" : "CmRdAAAA5zxS0xRhM3HUxsguJr2l_sMxGHlq8Qoq2sGU_2u0WhKQB7iJPHIVm3WEZuSUU6-vdq-4iBhiR230ofDyn6FgHEaDUy_r6zIeKMMX_fP0fkIqaM_MA2f8Guh9ZfvdKsoZEhBeA-OvxObA5wp0T3o3Q_FiGhQ1pt774nwVMbeFZuxzUYKlUsvztg",
                    "width" : 379
                }
                ],
    "place_id" : "ChIJrTLr-GyuEmsRBfy61i59si0",
    "reference" : "CnRqAAAAWVsdWQT6cc2QhOKHwNyYXyPn8lWIj1NM26jap7R7F05z97hktw8ogTVC1j6-h-_BwM-wvfn2yEKdk4w35LRoRzvWI81JcXDyXurwvURk4OZ4yeZBRmxEcCPqlfoJdJ1mVv9KKsZI3iW-bX3qRmRbNhIQyco6E1NTgBtANY-4OSS2YRoU6Wy8R5uRwgzQVvcsHDXP4AZXsz4",
    "reviews" : [
                 {
                     "aspects" : [
                                  {
                                      "rating" : 3,
                                      "type" : "overall"
                                  }
                                  ],
                     "author_name" : "Ben Anderson",
                     "author_url" : "https://plus.google.com/103501509378270717527",
                     "language" : "en",
                     "rating" : 5,
                     "text" : "My wife and I took the afternoon lunch cruise and we were thoroughly impressed. The service was top notch. The crew was very friendly but also maintained efficiency so no one I saw was waiting long. The food was surprisingly well prepared and tasted great. I wasn't expecting nearly as much variety or quality given that the food was served in such a short time, on a boat and to so many people. I would suggest that you get there early or you will wait in line for boarding. The crew seemed to be doing this for safety, which is appreciated, but no one likes waiting in lines. I didn't understand why there was a short leg (about 30 minutes) around the harbor to Circular Quay where the ship stopped. Not that big of a deal, just a little weird. The tour of the harbor was relaxing. We claimed some seats on the bow of the boat and enjoyed deserts, drinks, and the great weather. Outside was a little loud and hard to hear the speaker at times. This was mainly just due to chatter, wind and other outside noise. Maybe that could have been louder but that might have been unpleasant since it would have just added to the noise. When I paid attention I was able to hear some fun trivia about the Sydney. Not that it mattered for us, but I did notice many families so the cruise is family friendly. Overall the cruise was a pleasant experience and I would recommend it as an afternoon out for anyone visiting Sydney. \n",
                     "time" : 1442552409
                 }
                 ],
    "scope" : "GOOGLE",
    "types" : [
               "travel_agency",
               "restaurant",
               "food",
               "point_of_interest",
               "establishment"
               ],
    "url" : "https://plus.google.com/110751364053842618118/about?hl=en-US",
    "user_ratings_total" : 1,
    "utc_offset" : 660,
    "vicinity" : "32 The Promenade, King Street Wharf 5, Sydney",
    "website" : "http://www.australiancruisegroup.com.au/"
}*/
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
@property(strong, nonatomic) NSString<Optional> *formattedAddress;
@end
