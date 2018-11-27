//
//  SGButton.h
//  One
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGButton : UIButton
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleSG;

+ (SGButton *) buttonWithImageName:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action;
@end
