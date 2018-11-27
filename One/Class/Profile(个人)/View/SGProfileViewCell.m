//
//  SGProfileViewCell.m
//  One
//
//  Created by tarena on 16/1/4.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGProfileViewCell.h"

@implementation SGProfileViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(10, 10, self.height - 20, self.height - 20)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.textLabel.frame = CGRectMake(self.imageView.x + self.imageView.width + 10, 10, self.width - self.imageView.width - self.accessoryView.width, self.height - 20);
}
@end
