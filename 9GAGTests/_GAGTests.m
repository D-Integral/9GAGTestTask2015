//
//  _GAGTests.m
//  9GAGTests
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DataManager.h"

@interface _GAGTests : XCTestCase

@end

@implementation _GAGTests

- (void)testDataManager {
	DataManager *dataManager = [DataManager sharedManager];
	XCTAssertNotNil(dataManager);
	XCTAssertNotNil(dataManager.dataCollections);
	XCTAssertEqual([dataManager.dataCollections count], 4);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
