//
//  FAImageView+FontAutoLoad.m
//  Pods
//
//  Created by ryan on 06/12/2016.
//
//

#import "FAImageView+FontAutoLoad.h"
#import <CoreText/CoreText.h>
#import "NSBundle+Speed.h"

static NSString *const kFontAwesomeName = @"FontAwesome.ttf";

@implementation FAImageView (FontAutoLoad)

+ (void)load {
    [self loadAwesomeFont];
}

+ (void)loadAwesomeFont {
    NSString *fontPath = [[NSBundle speedBundle] pathForResource:kFontAwesomeName ofType:nil];
    NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
    
    CFErrorRef error;

    CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(providerRef);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        //如果注册失败，则不使用
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    } else {
        
    }
    
    CFRelease(font);
    CFRelease(providerRef);
}



@end
