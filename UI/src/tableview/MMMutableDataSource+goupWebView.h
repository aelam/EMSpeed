//
//  ymMutableDataSource+goupWebView.h
//  ymStock
//
//  Created by flora on 14-8-1.
//
//

#import "MMMutableDataSource.h"

@interface MMMutableDataSource (goupWebView)

/**
 *根据某一个indexpath，返回对应section的数据组
 */
- (NSArray *)toGroupWebViewArray:(NSIndexPath *)indexPath;

@end
