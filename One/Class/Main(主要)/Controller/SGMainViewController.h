//
//  SGMainViewController.h
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGBaseViewController.h"

@interface SGMainViewController : SGBaseViewController

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger currentMaxPage;
@property (nonatomic, strong) UILabel * refreshLabel;

- (void)getNetworkDate:(NSInteger)currentPage;
- (void)initViewandDate;
@end

