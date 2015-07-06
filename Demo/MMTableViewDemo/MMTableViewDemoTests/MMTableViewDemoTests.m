//
//  MMTableViewDemoTests.m
//  MMTableViewDemoTests
//
//  Created by Mac mini 2012 on 15-2-26.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MMInfoModel.h"
#import "MSHTTPResponse.h"

@interface MMTableViewDemoTests : XCTestCase {
    MMInfoModel *_model;
}

@end

@implementation MMTableViewDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    
    if (_model==nil) {
        _model = [[MMInfoModel alloc] init];
    }
    
    NSString *url = @"http://mt.emoney.cn/2pt/zx/GetBShareNews";
    
    [_model POST:url
           param:nil
           block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
               
               if (success) {
                   XCTAssert(YES, @"Pass");
                   
                   NSDictionary *dict = response.originData;
                   NSLog(@"dict = %@", dict);
                   
                   ///
               }
               else{
                   XCTAssert(NO, @"Failed %@", task.error);
               }
               
               CFRunLoopRef runLoopRef = CFRunLoopGetCurrent();
               CFRunLoopStop(runLoopRef);
           }];
    
    CFRunLoopRun();
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
