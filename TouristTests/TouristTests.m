//
//  TouristTests.m
//  TouristTests
//
//  Created by Ashiqur Rahman on 10/18/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GMSApiClient.h"
#import "GooglePlaceVO.h"

#define EXP_START(desc) XCTestExpectation *expt = [self expectationWithDescription:desc]
#define EXP_FULFILL() [expt fulfill]
#define EXP_END() [self waitForExpectationsWithTimeout:20.0 handler:^(NSError * _Nullable error) {\
XCTAssertNil(error, "error");\
}]


@interface TouristTests : XCTestCase

@end

@implementation TouristTests{
    GMSApiClient *api;
}

- (void)setUp {
    [super setUp];
    api = [[GMSApiClient alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testTaskForRadarSearchForCoordinate{

    EXP_START(@"testTaskForRadarSearchForCoordinate");
    
    CLLocationCoordinate2D loc;
    loc.latitude = 51.503186;
    loc.longitude = -0.126446;
    
    [[api taskForRadarSearchForCoordinate:loc types:@[@"food", @"bar"]] continueWithSuccessBlock:^id(BFTask *task) {
        XCTAssertEqual([task.result count], 200);
        EXP_FULFILL();
        return nil;
    }];
    
    EXP_END();
}

-(void)testTaskForPlaceForPlaceId{
    
    EXP_START(@"testTaskForPlaceForPlaceId");
    
    CLLocationCoordinate2D loc;
    loc.latitude = 51.503186;
    loc.longitude = -0.126446;
    
    [[[api taskForRadarSearchForCoordinate:loc types:@[@"food", @"bar"]] continueWithSuccessBlock:^id(BFTask *task) {
        
        GooglePlaceVO *placeVO = task.result[0];
        
        return [api taskForPlaceForPlaceId:placeVO.placeId];
        
    }] continueWithSuccessBlock:^id(BFTask *task) {
        NSLog(@"%@", task.result);
        EXP_FULFILL();
        return  nil;
    }];
    
    EXP_END();
}


@end
