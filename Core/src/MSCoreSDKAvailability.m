//
//  EMSDKAvailability.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSCoreSDKAvailability.h"
#import "MSCoreMetrics.h"


BOOL EMIsPad(void)
{
    static NSInteger isPad = -1;
    if (isPad < 0) {
        isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
    }
    return isPad > 0;
}


BOOL EMIsPhone(void)
{
    static NSInteger isPhone = -1;
    if (isPhone < 0) {
        isPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0;
    }
    return isPhone > 0;
}


BOOL EMIsRetina(void)
{
    return EMScreenScale() >= 2.f;
}


BOOL EMIsIphone5()
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO;
}


BOOL EMIsIphone5Above()
{
    return EMIsIphone5() || EMIsIphone6() || EMIsIphone6P();
}


BOOL EMIsIphone6()
{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return (MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height) < 2208) && (MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height)>1136);
    }
    
    return NO;
}


BOOL EMIsIphone6P()
{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return  MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height) >= 2208;
    }
    
    return NO;
}


BOOL EMIsPhoneCallSupported()
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}


BOOL EMMakePhoneCall(NSString *phoneNumber)
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        return [[UIApplication sharedApplication] openURL:url];
    }
    else{
        return NO;
    }
}


