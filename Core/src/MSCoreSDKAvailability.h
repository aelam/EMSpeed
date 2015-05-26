//
//  EMSDKAvailability.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#if __cplusplus
extern "C" {
#endif
    
    
    /**
     *  是否是iPad设备
     *
     *  @return 是否是iPad设备
     */
    BOOL EMIsPad(void);
    
    
    /**
     *  是否是iPhone设备
     *
     *  @return 是否是iPhone设备
     */
    BOOL EMIsPhone(void);
    
    
    /**
     *  是否是retina屏
     *
     *  @return 是否是retina屏
     */
    BOOL EMIsRetina(void);
    
    
    /**
     *  是否是iPhone5
     *
     *  @return 是否是iPhone5
     */
    BOOL EMIsIphone5();
    
    
    /**
     *  是否是iPhone6
     *
     *  @return 是否是iPhone6
     */
    BOOL EMIsIphone6();
    
    
    /**
     *  是否是iPhone6P
     *
     *  @return 是否是iPhone6P
     */
    BOOL EMIsIphone6P();
    
    
    /**
     *  是否是iPhone5及以上设备
     *
     *  @return 是否是iphone5及以上设备
     */
    BOOL EMIsIphone5Above();
    
    
    /**
     *  是否支持打电话
     *
     *  @return 是否支持打电话
     */
    BOOL EMIsPhoneCallSupported();
    
    
    /**
     *  拨号
     *
     *  @param phoneNumber 电话号码
     *
     *  @return 是否成功
     */
    BOOL EMMakePhoneCall(NSString *phoneNumber);
    

#if __cplusplus
}
#endif
