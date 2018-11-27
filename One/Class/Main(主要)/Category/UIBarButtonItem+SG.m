//
//  UIBarButtonItem+SG.m
//  
//
//  Created by 许思磊 on 15/11/21.
//
//

#import "UIBarButtonItem+SG.h"

@implementation UIBarButtonItem (SG)
+ (UIBarButtonItem *)itemWithimageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    
    UIButton * button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
