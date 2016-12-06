//
//  NSBundle+Speed.m
//  Pods
//
//  Created by ryan on 06/12/2016.
//
//

#import "NSBundle+Speed.h"

@interface EMSpeedBundleDummy : NSObject

@end

@implementation EMSpeedBundleDummy

@end


@implementation NSBundle (Speed)

+ (instancetype)speedBundle {
    return  [NSBundle bundleForClass:[EMSpeedBundleDummy class]];
}

@end
