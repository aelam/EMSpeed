//
//  MSCollectionCellModel.m
//  Pods
//
//  Created by ryan on 15/10/26.
//
//

#import "MSCollectionCellModel.h"

@implementation MSCollectionCellModel

@synthesize layoutSize;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;
@synthesize cellClass;

- (instancetype)init {
    if (self = [super init]) {
        self.layoutSize = CGSizeMake(100, 100);
        self.reuseIdentify = NSStringFromClass([self class]);
        self.cellClass = [UICollectionViewCell class];
        self.isRegisterByClass = YES;
    }
    
    return self;
}

- (Class)Class {
    return self.cellClass;
}

- (void)setClass:(Class)aClass {
    self.cellClass = aClass;
}

@end
