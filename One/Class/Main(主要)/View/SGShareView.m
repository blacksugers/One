//
//  SGShareView.m
//  One
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGShareView.h"

@implementation SGShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView{
    UILabel * shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SGWidth, self.height / 6)];
    shareLabel.text = @"分享到";
    [self addSubview:shareLabel];
    UIScrollView * shareView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, shareLabel.y + shareLabel.height, SGWidth, self.height / 3)];
    shareLabel.backgroundColor = SGRandomColor;
    [self addSubview:shareView];

    CGRect frame  = CGRectMake(0, shareView.y, self.height / 3 - 20, self.height / 3);
    SGButton * button = [SGButton buttonWithImageName:@"share_col" title:@"加入收藏" frame:frame target:self action:@selector(buttonClick)];
    [self addSubview:button];
    
  }


@end
