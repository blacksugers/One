//
//  SGButton.m
//  One
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGButton.h"

@implementation SGButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview{
    UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    self.iconImageView = iconImageView;
    iconImageView.backgroundColor = SGRandomColor;
    [self addSubview:iconImageView];
    UILabel * titleSG = [[UILabel alloc]initWithFrame:CGRectMake(self.width, 0, self.width, self.height - self.width)];
    titleSG.font = [UIFont systemFontOfSize:12];
    self.titleSG = titleSG;
    [self addSubview:titleSG];
}

+ (SGButton *) buttonWithImageName:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action{
    SGButton * button = [[SGButton alloc]initWithFrame:frame];
    button.iconImageView.image = [UIImage imageNamed:imageName];
    button.titleSG.text = title;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
