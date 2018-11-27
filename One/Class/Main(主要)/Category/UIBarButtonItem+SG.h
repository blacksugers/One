//
//  UIBarButtonItem+SG.h
//  
//
//  Created by 许思磊 on 15/11/21.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SG)
+ (UIBarButtonItem *)itemWithimageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
