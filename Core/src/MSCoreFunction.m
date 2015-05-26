//
//  EMCommonFunction.m
//  EMStock
//
//  Created by flora on 14-9-10.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSCoreFunction.h"

float MSOSVersion(void)
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}


BOOL MSIsPortrait()
{
    return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
}


BOOL MSIsLandscape()
{
    return !MSIsPortrait();
}


NSString *MSBundleIdenfiter()
{
    static NSString *idString = nil;
    
    if (idString == nil)
    {
        CFStringRef identifier = CFBundleGetIdentifier(CFBundleGetMainBundle());
        idString = (__bridge NSString *)identifier;
    }
    return idString;
}


NSString* MSAppDisplayName()
{
    CFStringRef displayName = CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), CFSTR("CFBundleDisplayName")) ?: CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), CFSTR("CFBundleName")) ?: CFSTR("Unknown");
    
    return (__bridge NSString *)displayName;
}


NSString* MSAppVersion()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *versionValue = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return versionValue ? (NSString *)versionValue :  @"1.0.0";
}




BOOL MSOSVersionLessThan(float version)
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] < version;
}



BOOL MSOSVersionEqual(float version)
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] == version;
}


BOOL MSOSVersionMoreThan(float version)
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] > version;
}


BOOL MSOSVersionEqualOrLessThan(float version)
{
    return MSOSVersionLessThan(version) || MSOSVersionEqual(version);
}


BOOL MSOSVersionEqualOrMoreThan(float version)
{
    return MSOSVersionMoreThan(version) || MSOSVersionEqual(version);
}
