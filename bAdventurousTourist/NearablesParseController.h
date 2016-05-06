
//  NearablesParseManager.h

#import <Foundation/Foundation.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface NearablesParseController : NSObject

- (NSString *)getArtefactName:(NSString *)identifier;
- (NSString *)getArtefactCategory:(NSString *)identifier;

@end
