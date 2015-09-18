//
//  _GAGUITests.m
//  9GAGUITests
//
//  Created by Dmytro Skorokhod on 9/18/15.
//  Copyright © 2015 Dima Skorokhod. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface _GAGUITests : XCTestCase

@end

@implementation _GAGUITests

- (void)setUp {
    [super setUp];
	
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)testUserInterface {
	XCUIApplication *app = [XCUIApplication new];
	XCTAssertEqualObjects([[[app navigationBars] element] identifier], @"9GAG");
	
	[[[app tables] element] swipeLeft];
	XCTAssertEqualObjects([[[app navigationBars] element] identifier], @"9GAG");
}

@end
