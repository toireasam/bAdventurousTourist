//  BeaconParseManager.m

#import "BeaconParseController.h"
#import <EstimoteSDK/EstimoteSDK.h>

@implementation BeaconParseController

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (NSString *)getBeaconCategory:(NSString *)minor
{
    if([minor isEqualToString:@"10261"])
    {
        return @"museumSwitchKey";
    }
    else if([minor isEqualToString:@"11891"])
    {
        return @"cityhallSwitchKey";
    }
    else
    {
        return @"unknown";
    }
}

- (NSString *)getBeaconTouristLocation:(NSString *)minor
{
    if([minor isEqualToString:@"10261"])
    {
        return @"Ulster Museum";
    }
    else if([minor isEqualToString:@"11891"])
    {
        return @"Belfast City Hall";
    }
    else
    {
        return @"unknown";
    }
}

@end
