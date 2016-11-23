//
//  PINCache+MS.h
//  Pods
//
//  Created by flora on 16/11/17.
//
//PINCache(Document) 用于存储文件到 document 目录下，持久化，不会因为空间不足缓存文件被销毁
//PINCache(Read) 统一处理app内消息的阅读状态，可统一管理，模块内也可以深层模块级的 pincache 单独处理
//PINCache(MS) 其他拓展方法

#import <PINCache/PINCache.h>

@interface PINCache(Document)

+ (instancetype)sharedDocument;

@end

@interface PINCache(ArrayCache)

/**
 *key 映射一个数组，添加object到这个数组中
 *param object  : 对象
 *param key  : 数组key
 */
- (void)addObject:(id <NSCoding>)object forArrayKey:(NSString *)key;

/**
 *key 映射一个数组，从数组中移除object
 *param object  : 对象
 *param key  : 数组key
 */
- (void)removeObject:(id <NSCoding>)object forArrayKey:(NSString *)key;

/**
 *key 映射一个数组，判断是否包含object
 *param object  : 对象
 *param key  : 数组key
 *包含返回YES  不包含返回NO
 */
- (BOOL)containsObject:(id <NSCoding>)object forArrayKey:(NSString *)key;

@end

@interface PINCache(MS)

/**
 *从pincache 读取缓存数据，当没有缓存时提供本地默认配置
 *param key  : 缓存数据的key
 *param defaultObject: 默认的数据对象
 */
- (id)objectForKey:(NSString *)key defaultObject:(id (^)())defaultObject;

@end
