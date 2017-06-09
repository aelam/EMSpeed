//
//  PINCache+MS.m
//  Pods
//
//  Created by flora on 16/11/17.
//
//

#import "PINCache+MS.h"

@implementation PINCache(Document)

static NSString * const MSPINDocumentSharedName = @"PINDocumentShared";

+ (instancetype)sharedDocument
{
    static id document;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        document = [[PINCache alloc] initWithName: MSPINDocumentSharedName rootPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    });
    return document;
}
@end


@implementation PINCache(ArrayCache)

static NSInteger const MSPINCacheArrayMaxCount = 1000;

- (void)addObject:(id <NSCoding>)object forArrayKey:(NSString *)key
{
    if (object)
    {
        NSMutableArray *objects = [self objectForKey:key];
        if(objects == nil)
        {
            objects = [NSMutableArray array];
        }
        [objects addObject:object];
        //删历史数据，保持数组最大不超过指定个数 MSPINCacheReadHistoryMaxCount
        if ([objects count] > MSPINCacheArrayMaxCount)
        {
            [objects removeObjectsInRange:NSMakeRange(0, .5 * MSPINCacheArrayMaxCount)];
        }
        [self setObject:objects forKey:key];
    }
}

- (void)removeObject:(id <NSCoding>)object forArrayKey:(NSString *)key
{
    if (object)
    {
        NSMutableArray *objects = [self objectForKey:key];
        if(objects)
        {
            [objects removeObject:object];
        }
    }
}

- (BOOL)containsObject:(id <NSCoding>)object forArrayKey:(NSString *)key
{
    BOOL read = NO;

    if (object)
    {
        NSMutableArray *objects = [self objectForKey:key];
        if(objects)
        {
            read = [objects containsObject:object];
        }
    }
    return read;
}

@end

@implementation PINCache(MS)

- (id)objectForKey:(NSString *)key defaultObject:(id (^)())defaultObject
{
    id obj =  [self objectForKey:key];
    if (obj == nil && defaultObject)
    {
        obj = defaultObject();
    }
    return obj;
}


@end
