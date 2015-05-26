//
//  EMImageCollectionViewCell.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMImageCollectionViewCell.h"
#import "EMImageCollectionItem.h"
#import "UIImageView+emDownloadIcon.h"


@implementation EMImageCollectionViewCell

- (void)update:(id<MMCollectionCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[EMImageCollectionItem class]]) {
        
    }
}
- (void)update:(id<MMCollectionCellModel>)cellModel indexPath:(NSIndexPath *)indexPath
{
    if ([cellModel isKindOfClass:[EMImageCollectionItem class]]) {
        EMImageCollectionItem *item = cellModel;
        
        UIImage *image = [UIImage imageNamed:item.imageURL];
        if (!image) {
            [self.imageView ms_setImageWithURL:[NSURL URLWithString:item.imageURL] localCache:YES];
        }
        else{
            self.imageView.image = image;
        }
        self.titleLabel.text = item.title;
    }
}

+ (UIImage *)placeholderImage
{
    return nil;
}

- (void)awakeFromNib {
    // Initialization code
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
