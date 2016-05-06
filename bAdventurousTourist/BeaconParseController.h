//  BeaconParseManager.h

#import <Foundation/Foundation.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface BeaconParseController : NSObject <ESTBeaconManagerDelegate>

- (NSString *)getBeaconTouristLocation:(NSString *)minor;
- (NSString *)getBeaconCategory:(NSString *)minor;

@end
