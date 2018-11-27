//
//  SGHomeView.m
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGHomeView.h"

#import "SGSentenceView.h"

@interface SGHomeView ()

@property (nonatomic, strong) UILabel * volLabel;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * authorLabel;
@property (nonatomic, strong) UILabel * dayLabel;
@property (nonatomic, strong) UILabel * yearAndMonthLabel;
@property (nonatomic, strong) SGSentenceView * sentenceView;

@end

@implementation SGHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView{
    self.showsVerticalScrollIndicator = NO;
    //    搭建界面
    _volLabel = [[UILabel alloc]init];
    _volLabel.frame = CGRectMake(SGHomeMargin,SGHomeMargin + 64, 100, 22);
    _volLabel.font = [UIFont systemFontOfSize:15];
    
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(SGHomeMargin, _volLabel.y + _volLabel.height + SGHomeMargin, self.width - SGHomeMargin * 2, (self.width - SGHomeMargin * 2) * 0.75);
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(SGHomeMargin, _imageView.y + _imageView.height + SGHomeMargin, SGWidth - SGHomeMargin * 2, 20);
    _nameLabel.numberOfLines = 0;
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    
    _authorLabel = [[UILabel alloc]init];
    _authorLabel.frame = CGRectMake(SGHomeMargin, _nameLabel.y + _nameLabel.height , SGWidth - SGHomeMargin * 2, 20);
    _authorLabel.numberOfLines = 0;
    _authorLabel.font = [UIFont systemFontOfSize:15];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    
    _dayLabel = [[UILabel alloc]init];
    _dayLabel.frame = CGRectMake(SGHomeMargin * 2, _authorLabel.y + _authorLabel.height + 20, 70, 50);
    _dayLabel.textColor = SGBlue;
    _dayLabel.font = [UIFont systemFontOfSize:50];
    
    _yearAndMonthLabel = [[UILabel alloc]init];
    _yearAndMonthLabel.frame = CGRectMake(SGHomeMargin * 2, _dayLabel.y + _dayLabel.height, 70, 15);
    _yearAndMonthLabel.textColor = [UIColor lightGrayColor];
    _yearAndMonthLabel.font = [UIFont systemFontOfSize:15];

    _sentenceView = [[SGSentenceView alloc]init];
    _sentenceView.frame = CGRectMake(SGHomeMargin * 3 + 70, _dayLabel.y, 0, 0);
    
    [self addSubview:_volLabel];
    [self addSubview:_imageView];
    [self addSubview:_nameLabel];
    [self addSubview:_authorLabel];
    [self addSubview:_dayLabel];
    [self addSubview:_yearAndMonthLabel];
    [self addSubview:_sentenceView];
}

//获得数据 更新视图
- (void)setSentence:(SGSentence *)sentence{
    _sentence = sentence;
    //  更新数据
    _volLabel.text = sentence.strHpTitle;
    _sentenceView.text = sentence.strContent;
    
    NSArray * nameAndAuthorArray = [sentence.strAuthor componentsSeparatedByString:@"&"];
    _nameLabel.text = nameAndAuthorArray[0];
//    _authorLabel.text = nameAndAuthorArray[1];
    
    NSArray * dateArray = [sentence.strMarketTime componentsSeparatedByString:@"-"];
    _dayLabel.text = dateArray[2];
    _yearAndMonthLabel.text = [NSString stringWithFormat:@"%@ ,%@", dateArray[1], dateArray[0]];
    
    self.contentSize = CGSizeMake(0, self.height + 1);
    
    CGFloat scrollViewHeight = _sentenceView.y + _sentenceView.height + SGHomeMargin;
    if(scrollViewHeight > (self.height + 1)){
        self.contentSize = CGSizeMake(0, scrollViewHeight);
    }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:sentence.strOriginalImgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}


@end
