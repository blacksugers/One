//
//  SGTabBarController.h
//  OneDay
//
//  Created by tarena on 15/12/30.
//  Copyright © 2015年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGTabBarDelegate <NSObject>

@optional
- (void)didClickRightBarButtonItem;

@end

@interface SGTabBarController : UITabBarController
@property (nonatomic, weak) id tabBarDelegate;
@end
