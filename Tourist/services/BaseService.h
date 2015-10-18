//
//  BaseService.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface BaseService : NSObject

-(BFTask*)getTaskForPath:(NSString*)path withParams:(NSDictionary*)params;
-(NSURL*)baseURL;
-(AFHTTPRequestSerializer*)requestSerializer;
-(AFHTTPResponseSerializer*)responseSerializer;
@end
