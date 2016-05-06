//  LanguageManager.h

#import <Foundation/Foundation.h>

@interface LanguageController : NSObject

-(NSString *)getCurrentLanguage;
@property (weak,nonatomic) NSString *currentLanguage;

@end
