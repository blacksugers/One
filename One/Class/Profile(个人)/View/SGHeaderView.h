//
//  SGHeaderView.h
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGHeaderViewDelegate <NSObject>

- (void)headerViewdidClickButton:(UIButton *)sender;

@end

@interface SGHeaderView : UIImageView
@property (nonatomic, weak) id delegate;
@end
