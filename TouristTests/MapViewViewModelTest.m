//
//  MapViewViewModelTest.m
//  Tourist
//
//  Created by Ashiqur Rahman on 10/19/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MapViewViewModel.h"
@interface MapViewViewModelTest : XCTestCase

@end

@implementation MapViewViewModelTest{
    MapViewViewModel *vm;
}

- (void)setUp {
    [super setUp];
    
    vm = [[MapViewViewModel alloc]init];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testPlaces{
    
    EXP_START(@"testPlaces");
    [vm handleLocationUpdateForLocation:CLLocationCoordinate2DMake(-37.8380298, 144.9911135)];
    __block id places = nil;
    [self.KVOController observe:vm keyPath:@"places" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        places = change[NSKeyValueChangeNewKey];
        
        XCTAssertNotNil(places, @"places came nil");
        
        EXP_FULFILL();
    }];
    EXP_END();
}



@end
