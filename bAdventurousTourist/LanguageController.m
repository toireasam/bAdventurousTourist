//  LanguageManager.m

#import "LanguageController.h"

@implementation LanguageController
@synthesize currentLanguage;
NSString *swedish = @"sv-GB";
NSString *japanese = @"ja-GB";

-(NSString *)getCurrentLanguage
{
    currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([currentLanguage isEqualToString:swedish])
    {
        return @"TouristLocationsSwedish";
    }
    else if([currentLanguage isEqualToString:japanese])
    {
        return @"TouristLocationsJapanese";
    }
    else
    {
        return @"TouristLocations";
    }
}

@end
