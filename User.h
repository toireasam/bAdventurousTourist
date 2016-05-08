//  User.h

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (weak,nonatomic) NSString *username;
@property (weak,nonatomic) NSString *email;
@property (weak,nonatomic) NSString *userType;
@property (assign) BOOL isLoggedIn;

@end