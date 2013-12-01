//
//  LLARateLimiterTests.m
//  LLARateLimiterTests
//
//  Created by Lukas Lipka on 11/11/13.
//  Copyright (c) 2013 Lukas Lipka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LLARateLimiter.h"

@interface LLARateLimiterTests : XCTestCase

@end

@implementation LLARateLimiterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExecution {
    __block BOOL isExecuted;
    NSString *const name = @"testExecution";
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:5];
    
    XCTAssertTrue(isExecuted, @"Did not execute without any limit set");
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:5];
    
    XCTAssertFalse(isExecuted, @"Did execute with limit set");
    
    sleep(7);
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:5];
    
    XCTAssertTrue(isExecuted, @"Did not execute after limit expired");
}

- (void)testResetLimitByName {
    __block BOOL isExecuted;
    NSString *const name = @"testResetLimitByName";

    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:60];
    
    XCTAssertTrue(isExecuted, @"Did not execute without any limit set");
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:60];
    
    XCTAssertFalse(isExecuted, @"Did execute with limit set");
    
    [LLARateLimiter resetLimitForName:name];
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:60];
    
    XCTAssertTrue(isExecuted, @"Did not execute without limit reset");
}

- (void)testResetAllLimit {
    __block BOOL isExecuted;
    NSString *const name = @"testResetAllLimit";
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:60];
    
    XCTAssertTrue(isExecuted, @"Did not execute without any limit set");
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:60];
    
    XCTAssertFalse(isExecuted, @"Did execute with limit set");
    
    [LLARateLimiter resetAllLimits];
    
    isExecuted = NO;
    [LLARateLimiter executeBlock:^{
        isExecuted = YES;
    } name:name limit:60];
    
    XCTAssertTrue(isExecuted, @"Did not execute without limit reset");
}

@end
