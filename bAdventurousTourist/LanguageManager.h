//  LanguageManager.h

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

-(NSString *)presentCurrentLanguage;
@property (weak,nonatomic) NSString *currentLanguage;

@end
