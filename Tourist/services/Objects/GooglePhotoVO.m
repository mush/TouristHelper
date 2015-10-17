//
//  GooglePhotoVO.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/17/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "GooglePhotoVO.h"
#import <JSONKeyMapper.h>
@implementation GooglePhotoVO
+(JSONKeyMapper *)keyMapper{

    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];

}
@end
