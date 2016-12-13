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
@synthesize Class = _Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;
@synthesize cellClass;

- (instancetype)init {
    if (self = [super init]) {
        self.layoutSize = CGSizeMake(100, 100);
        self.reuseIdentify = NSStringFromClass([self class]);
        self.Class = [UICollectionViewCell class];
        self.isRegisterByClass = YES;
    }
    
    return self;
}

- (void)setClass:(Class)Class {
    _Class = Class;
    self.cellClass = Class;
}


@end
