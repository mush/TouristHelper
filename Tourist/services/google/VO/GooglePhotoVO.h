//
//  GooglePhotoVO.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
{
    "height" : 768,
    "html_attributions" : [
                           "\u003ca href=\"https://maps.google.com/maps/contrib/117979886491291086792\"\u003eFrom a Google User\u003c/a\u003e"
                           ],
    "photo_reference" : "CmRdAAAANgdpKpWeMohmcjRzyYoqPKBkf77hngteVTOE8hqFAxRR9ZtYFD4pIlyjGraIBKS3WKXP5kr5cnLq4IoAh256O-67uu2TA4Saj3AyGa_ohTvvI8yRAq0_750de-Srdp9jEhB4rDtRuPGpEKpSig_x2ockGhQ2BqnHhMjItVc44AaLMb3tmEYzwQ",
    "width" : 1024
}
**/

@interface GooglePhotoVO : JSONModel
@property(assign, nonatomic) NSNumber *height;
@property(strong, nonatomic) NSArray<NSString*> *htmlAttributions;
@property(assign, nonatomic) NSString *photoReference;
@property(assign, nonatomic) NSNumber *width;
@end
