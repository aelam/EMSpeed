//
//  ymMutableDataSource+goupWebView.m
//  ymStock
//
//  Created by flora on 14-8-1.
//
//

#import "MMMutableDataSource+goupWebView.h"

@implementation MMMutableDataSource (goupWebView)

- (NSArray *)toGroupWebViewArray:(NSIndexPath *)indexPath
{
    NSArray *array = [self.items objectAtIndex:indexPath.section];
    NSUInteger size = [array count];
//    if (self.hasNextPage && indexPath.section == self.sections.count - 1)
//    {
//        size -= 1;
//    }
    return [array subarrayWithRange:NSMakeRange(0, size)];
}

@end
