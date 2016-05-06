//
//  bAdventurousTouristTests.m
//  bAdventurousTouristTests
//
//  Created by Toireasa Moley on 24/04/2016.
//  Copyright © 2016 Toireasa Moley. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SignupViewController.h"

@interface bAdventurousTouristTests : XCTestCase

@property (nonatomic) SignupViewController *vcToTest;

@end

@interface SignupViewController (Test)

-(BOOL)validateEmail:(NSString *)email;

@end

@implementation bAdventurousTouristTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vcToTest = [[SignupViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidateEmail {

    // Arrange
    NSString *validEmail = @"toireasa-moley@hotmail.co.uk";
    BOOL isValid = true;
    
    // Act
    BOOL result = [self.vcToTest validateEmail:validEmail];
    
    // Assert
    XCTAssertEqual(result, isValid, @"Expected true, got false");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
