//
//  EMCoreFunction.h
//  EMStock
//
//  Created by flora on 14-9-10.
//  Copyright (c) 2014年 flora. All rights reserved.
//


#ifdef __cplusplus
extern "C" {
#endif
    
    /**
     * 获取包的唯一标示
     *
     *  @return bundle信息
     */
    NSString *EMBundleIdenfiter();
    
    
    /**
     *  应用名称
     *
     *  @return 应用显示的名称
     */
    NSString* EMAppDisplayName();
    
    
    /**
     *  获取版本表示，一般格式为3.3.1
     *
     *  @return 版本号
     */
    NSString* EMAppVersion();
    
    
    
    /**
     *  当前iOS版本号
     *
     *  @return 当前iOS版本号
     */
    float EMOSVersion(void);
    
    
    
    /**
     *  当前是否是竖屏
     *
     *  @return 当前是否是竖屏
     */
    BOOL EMIsPortrait();
    
    
    /**
     *  当前是否是横屏
     *
     *  @return 当前是否是横屏
     */
    BOOL EMIsLandscape();
    
    
    
    /**
     *  当前iOS版本号, 是否小于输入版本号
     *
     *  @param version 输入版本号
     *
     *  @return 当前iOS版本号, 是否小于输入版本号
     */
    BOOL EMOSVersionLessThan(float version);
    
    
    /**
     *  当前iOS版本号, 是否等于输入版本号
     *
     *  @param version 输入版本号
     *
     *  @return 当前iOS版本号, 是否等于输入版本号
     */
    BOOL EMOSVersionEqual(float version);
    
    
    /**
     *  当前iOS版本号, 是否大于输入版本号
     *
     *  @param version 输入版本号
     *
     *  @return 当前iOS版本号, 是否大于输入版本号
     */
    BOOL EMOSVersionMoreThan(float version);
    
    
    /**
     *  当前iOS版本号, 是否小于等于输入版本号
     *
     *  @param version 输入版本号
     *
     *  @return 当前iOS版本号, 是否小于等于输入版本号
     */
    BOOL EMOSVersionEqualOrLessThan(float version);
    
    
    /**
     *  当前iOS版本号, 是否大于等于输入版本号
     *
     *  @param version 输入版本号
     *
     *  @return 当前iOS版本号, 是否大于等于输入版本号
     */
    BOOL EMOSVersionEqualOrMoreThan(float version);
    
    
#ifdef __cplusplus
}
#endif

