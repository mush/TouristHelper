//
//  BaseService.h
//  Tourist
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
/**
 *  A base service class for webservice implementation.
 */
@interface BaseService : NSObject
/**
 *  gives a task that performs HTTP GET call and consumes the response.
 *
 *  @param path   the realtive path for a given endpoint
 *  @param params query params
 *
 *  @return a BFTask with the HTTP result
 */
-(BFTask*)getRequestTaskForPath:(NSString*)path withParams:(NSDictionary*)params;
/**
 *  the base url of the web service. must be overriden by the subclasses.
 *
 *  @return NSURL
 */
-(NSURL*)baseURL;
/**
 *  A request serializer of AFHTTPRequestSerializer. defaults to AFJSONRequestSerializer.
 *
 *  @return AFHTTPRequestSerializer
 */
-(AFHTTPRequestSerializer*)requestSerializer;
/**
 *  A response serializer of AFHTTPResponseSerializer. defaults to AFJSONResponseSerializer.
 *
 *  @return AFHTTPResponseSerializer
 */
-(AFHTTPResponseSerializer*)responseSerializer;
@end
