//
//  SGHeaderView.m
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGHeaderView.h"

@interface SGHeaderView ()
@property (nonatomic, strong) NSMutableArray * buttonArray;
@end

@implementation SGHeaderView

- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupHeaderView];
        [self setupButton];
    }
    return self;
}

- (void)setupHeaderView{
    self.image = [UIImage imageNamed:@"collectionHeadBg"];
    
    UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SGWidth / 9, SGWidth / 9)];
    iconImageView.image = [UIImage imageNamed:@"phone_default_006"];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    iconImageView.center = self.center;
    [self addSubview:iconImageView];
    
    UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, SGWidth * 0.5 - SGWidth / 8.0, SGWidth, 1)];
    topLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    [self addSubview:topLine];
 
}

- (void)setupButton{
    NSArray * buttontitleArray = @[@"图片", @"新闻", @"文章", @"问题"];
    
    for (int i = 0; i < buttontitleArray.count; i ++) {
        UIButton * button = [UIButton myCollectionButtonWithTitle:buttontitleArray[i] target:self action:@selector(clickButton:)];
        button.frame = CGRectMake(i * SGWidth / 4.0, self.height - SGWidth / 8.0, SGWidth / 4.0, SGWidth / 8.0);
        if (i > 0 ) {
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(button.x, button.y + button.height * 0.1, 1, button.height * 0.8)];
            line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
            [self addSubview:line];
        }
        if (i == 0) {
            button.selected = YES;
        }
        button.tag = i;
        [self.buttonArray addObject:button];
        [self addSubview:button];
    }
}

- (void)clickButton:(UIButton *)sender{
    NSLog(@"clickButton___");
    if (!sender.selected) {
        sender.selected = YES;
        NSLog(@"%ld", (long)sender.tag);
        for (int i = 0; i < 4; i++) {
            if (i != sender.tag) {
                UIButton * button = self.buttonArray[i];
                button.selected = NO;
            }
        }
    }
    
    [self.delegate headerViewdidClickButton:sender];
}

@end
