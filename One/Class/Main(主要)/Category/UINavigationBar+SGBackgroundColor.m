//
//  UINavigationBar+SGBackgroundColor.m
//  One
//
//  Created by tarena on 16/1/5.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "UINavigationBar+SGBackgroundColor.h"
#import <objc/runtime.h>


@implementation UINavigationBar (SGBackgroundColor)

static char overlayKey;
#warning 重点理解

//关联 相当于给此类 加了一块内存空间
- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        
        // insert an overlay into the view hierarchy
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
       
        [self insertSubview:self.overlay atIndex:0];
    }

    self.overlay.backgroundColor = backgroundColor;
}
@end
