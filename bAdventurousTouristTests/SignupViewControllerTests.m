//  SignupViewControllerTests.m

#import <XCTest/XCTest.h>
#import "SignupViewController.h"

@interface SignupViewControllerTests : XCTestCase

@property (nonatomic) SignupViewController *vcToTest;

@end

@interface SignupViewController (Test)

-(BOOL)validateEmail:(NSString *)email;

@end

@implementation SignupViewControllerTests

- (void)setUp {
    
    [super setUp];
    self.vcToTest = [[SignupViewController alloc] init];
}

- (void)tearDown {
    
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

@end
