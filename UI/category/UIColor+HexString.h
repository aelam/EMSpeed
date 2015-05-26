//
//  UIColor+Hex.h
//  PureTest
//
//  Created by Mac mini 2012 on 15-3-5.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (HexString)

/**
 *  根据16进制字符串, 获得UIColor
 *
 *  @param hexString 字符串
 *
 *  @return UIColor
 */
+ (UIColor *)ms_colorWithHexString: (NSString *) hexString;

@end