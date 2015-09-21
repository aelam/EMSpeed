//
//  EMUUID.m
//  ymStockHD
//
//  Created by flora on 13-10-18.
//
//

#import "MSUUID.h"
#import "SFHFKeychainUtils.h"
#import "MSCoreFunction.h"

NSString *kKeychainUUIDItemIdentifier  = @"UUID";
NSString *kKeyChainUUIDAccessGroup = nil;

@implementation MSUUID

+ (void)initialize
{
    [self initUUIDAccessGroup];
}

+ (void)initUUIDAccessGroup
{
    if (nil == kKeyChainUUIDAccessGroup)
    {
        //获取bundleid
        NSString *idString = MSBundleIdenfiter();
        //仅保留前两段
        idString = [[[idString componentsSeparatedByString:@"."] subarrayWithRange:NSMakeRange(0, 2)] componentsJoinedByString:@"."];
        kKeyChainUUIDAccessGroup =  [idString copy];
    }
}

+ (NSString *)getEMUUID
{
    NSString *uuid = [MSUUID getEMUUIDFromKeyChain];
    if (!uuid) {
        uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [MSUUID setEMUUIDToKeyChain:uuid];
    }
    return uuid;
}

#pragma mark -
#pragma mark Helper Method for make identityForVendor consistency

+ (NSString*)getEMUUIDFromKeyChain
{
    return [SFHFKeychainUtils getPasswordForUsername:kKeychainUUIDItemIdentifier andServiceName:kKeyChainUUIDAccessGroup error:nil];
}

+ (BOOL)setEMUUIDToKeyChain:(NSString*)udid
{
    return  [SFHFKeychainUtils storeUsername:kKeychainUUIDItemIdentifier
                                 andPassword:udid
                              forServiceName:kKeyChainUUIDAccessGroup
                              updateExisting:NO
                                       error:nil];
}

+ (BOOL)removeUDIDFromKeyChain
{
    return  [SFHFKeychainUtils deleteItemForUsername:kKeychainUUIDItemIdentifier andServiceName:kKeyChainUUIDAccessGroup error:nil];
}

@end
