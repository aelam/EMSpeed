 //
//  EMCommonMetrics.m
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSCoreMetrics.h"


CGFloat EMScreenHeight(void) {
    return [[UIScreen mainScreen] bounds].size.height;
}


CGFloat EMScreenWidth(void) {
    return [[UIScreen mainScreen] bounds].size.width;
}


CGFloat EMContentHeight(void) {
    return [[UIScreen mainScreen] applicationFrame].size.height;
}


CGFloat EMContentWidth(void) {
    return [[UIScreen mainScreen] applicationFrame].size.width;
}



CGFloat EMNavigationBarHeight(void)
{
    return 44.0f;
}


CGFloat EMTabBarHeight(void)
{
    return 49.0f;
}


CGFloat EMStatusBarHeight(void)
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}


CGFloat EMScreenScale(void)
{
    return [[UIScreen mainScreen] scale];
}

CGFloat EMAdaptiveCofficient()
{
    static CGFloat coffient = 0;
    if (coffient == 0)
    {
        coffient = EMScreenWidth()/320.0;
        coffient = [[NSString stringWithFormat:@"%.2f",coffient] floatValue];
    }
    return coffient;
}


CGFloat EMAdjustedWH(CGFloat wh)
{
    return  wh * EMAdaptiveCofficient();
}

CGFloat EMDefaultValueWidth(UIFont *font)
{
    NSString *string = @"888.88";
    
    if ([string respondsToSelector:@selector(sizeWithAttributes:)]) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        return [string sizeWithAttributes:attributes].width;
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [string sizeWithFont:font].width;
#pragma clang diagnostic pop
    }
}

