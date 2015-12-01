//
//  EMCommonFunction.m
//  EMStock
//
//  Created by flora on 14-9-10.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSUIKitCoreFunction.h"

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
    return [[NSBundle mainBundle] bundleIdentifier];
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