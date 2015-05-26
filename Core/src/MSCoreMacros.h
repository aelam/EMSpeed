//
//  EMCoreMacors.h
//  CoreDemo
//
//  Created by Mac mini 2012 on 15-3-4.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#ifndef CoreDemo_EMCoreMacors_h
#define CoreDemo_EMCoreMacors_h


/**
 *  根据rgb值获取颜色的封装函数
 */
#if !defined(RGBA)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define RGB(r,g,b)     RGBA(r,g,b,1)
#endif


/**
 *  角度与弧度转换
 */
#if !defined(DegreesToRadian)
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
#endif


/**
 *  获取数组长度
 */
#if !defined(ArrayLength)
#define ArrayLength(x)	(sizeof(x) / sizeof((x)[0]))
#endif


/**
 *  自增
 */
#if !defined(LoopIncrease)
#define LoopIncrease(val,len) (val = ((val)+1 > (len-1)) ? 0 : (val)+1)
#endif


/**
 *  自减
 */
#if !defined(LoopDecrease)
#define LoopDecrease(val,len)  (val = ((val)-1 < 0) ? (len-1) : (val)-1)
#endif


/**
 *  判断是否是偶数
 */
#if !defined(Even)
#define Even(n)  (n%2 == 0) ? 1 : 0
#endif


#define __(x) (x == nil || [x isKindOfClass:[NSNull class]])?nil:[NSString stringWithFormat:@"%@",x]


#endif
