//
//  EMCommonFunction.m
//  EMStock
//
//  Created by flora on 14-9-10.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSCoreFunction.h"

float EMOSVersion(void)
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}


BOOL EMIsPortrait()
{
    return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
}


BOOL EMIsLandscape()
{
    return !EMIsPortrait();
}


NSString *EMBundleIdenfiter()
{
    static NSString *idString = nil;
    
    if (idString == nil)
    {
        CFStringRef identifier = CFBundleGetIdentifier(CFBundleGetMainBundle());
        idString = (__bridge NSString *)identifier;
    }
    return idString;
}


NSString* EMAppDisplayName()
{
    CFStringRef displayName = CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), CFSTR("CFBundleDisplayName")) ?: CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), CFSTR("CFBundleName")) ?: CFSTR("Unknown");
    
    return (__bridge NSString *)displayName;
}


NSString* EMAppVersion()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *versionValue = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return versionValue ? (NSString *)versionValue :  @"1.0.0";
}




BOOL EMOSVersionLessThan(float version)
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] < version;
}



BOOL EMOSVersionEqual(float version)
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] == version;
}


BOOL EMOSVersionMoreThan(float version)
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] > version;
}


BOOL EMOSVersionEqualOrLessThan(float version)
{
    return EMOSVersionLessThan(version) || EMOSVersionEqual(version);
}


BOOL EMOSVersionEqualOrMoreThan(float version)
{
    return EMOSVersionMoreThan(version) || EMOSVersionEqual(version);
}
