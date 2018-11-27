//
//  UIButton+SG.m
//  One
//
//  Created by tarena on 16/1/5.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "UIButton+SG.h"

@implementation UIButton (SG)
+ (UIButton *)myCollectionButtonWithTitle:(NSString *)title target:(nullable id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:SGBlue forState:UIControlStateSelected];
    [button setTitleColor:SGBlue forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
