//  LanguageManager.m

#import "LanguageManager.h"

@implementation LanguageManager
@synthesize currentLanguage;
NSString *swedish = @"sv-GB";
NSString *japanese = @"ja-GB";


-(NSString *)presentCurrentLanguage
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
