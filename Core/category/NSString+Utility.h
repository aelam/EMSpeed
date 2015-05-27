//
//  NSString+utility.h
//  EMStock
//
//  Created by deng flora on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString(Utility)


/**
*  去掉前后空白处
*
*  @return 处理后的字符串
*/
- (NSString *)ms_trim;


/**
 *  根据字体和尺寸, 计算字符串尺寸
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 尺寸
 */
- (CGSize)ms_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


/**
 *  根据字体和尺寸, 计算字符串高度
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 字符串高度
 */
- (CGFloat)ms_heightWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


/**
 *  根据字体和尺寸, 计算字符串宽度
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 字符串宽度
 */
- (CGFloat)ms_widthWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


/**
 *  首字母大写
 *
 *  @return 处理后的字符串
 */
- (NSString *)ms_firstLetterCapitalized;


/**
 *  字符串中是否有字母
 *
 *  @return BOOL
 */
- (BOOL)ms_hasLetter;


/**
 *  是否是email格式
 *
 *  @return 正确或错误
 */
- (BOOL)ms_isEmail;


/**
 *  纯数字
 *
 *  @return 正确或错误
 */
- (BOOL)ms_isPureNumandCharacters;


/**
 *  是否11位纯数字手机号
 *
 *  @return 正确或失败
 */
- (BOOL)ms_isPhoneNumber;


/**
 *  将流量字符串转化, 流量值(byte), 转化为带K,M,G,T的字符串, 例如1204 -> 1KB
 *
 *  @param flowLen 流量值(byte)
 *
 *  @return 转换后的字符串
 */
+ (NSString *)ms_stringWithFlowLength:(int)length;


/**
 *  纯数字电话号码, 转换为带-号的电话号码格式
 *
 *  @return 电话号码格式字符串
 */
- (NSString *)ms_phoneFormatterString;


/**
 *  获取时间戳
 *
 *  @return 时间戳字符串
 */
+ (NSString *)ms_generateTimestamp;


/**
 *  生成一个UUID
 *
 *  @return UUID字符串
 */
+ (NSString *)ms_generateUUID;



/**
 *  url根据&和=号, 解成字典
 *
 *  @return 字典
 */
- (NSDictionary *)ms_toResponseDictionary;



@end

