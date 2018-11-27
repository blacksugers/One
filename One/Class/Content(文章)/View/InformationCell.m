//
//  InformationCell.m
//  米琪新闻
//
//  Created by tarena on 15/12/29.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "InformationCell.h"
#import "UIImageView+WebCache.h"

@implementation InformationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showDataWithModel:(InformationModel *)model andIndexPath:(NSIndexPath *)indexPath {

    [self.imageUrl1 sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1] placeholderImage:[UIImage imageNamed:@"news0.png"]];
    self.titleLable.text = model.itemTitle;
    self.fuZhuLable.text = model.brief;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
