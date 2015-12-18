//
//  UIApplication+NotificationTypes.m
//  Pods
//
//  Created by ryan on 15/12/18.
//
//

#import "UIApplication+NotificationTypes.h"

@implementation UIApplication (NotificationSettings)

- (NSUInteger)EMNotificationSettingTypes
{
    NSUInteger types;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]) {
        types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
    }
    else {
        types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    return types;
}

@end
