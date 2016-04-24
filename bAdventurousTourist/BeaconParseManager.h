//  BeaconParseManager.h

#import <Foundation/Foundation.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface BeaconParseManager : NSObject <ESTBeaconManagerDelegate>

- (NSString *)identifyBeacon:(NSString *)minor;
- (NSString *)getBeaconCategory:(NSString *)minor;

@end
