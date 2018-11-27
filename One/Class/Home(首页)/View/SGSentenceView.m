//
//  SGSentenceView.m
//  One
//
//  Created by tarena on 15/12/31.
//  Copyright © 2015年 Sugar. All rights reserved.
//

#import "SGSentenceView.h"
#define SGSentenceWidth [UIScreen mainScreen].bounds.size.width - SGHomeMargin * 6 - 70

@interface SGSentenceView ()
@property (nonatomic, strong) UIImageView * backgroundView;
@property (nonatomic, strong) UILabel * textLabel;
@end

@implementation SGSentenceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView = [[UIImageView alloc]init];
        UILabel * textLabel = [[UILabel alloc]init];
        self.textLabel = textLabel;
        [_backgroundView addSubview:textLabel];
        [self addSubview:_backgroundView];
        
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(SGSentenceWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.backgroundView.frame = CGRectMake(0, 0, frame.size.width + SGHomeMargin * 2, frame.size.height + SGHomeMargin * 2);
    self.backgroundView.image = [UIImage imageNamed:@"contBack"];
    _textLabel.frame = CGRectMake(SGHomeMargin, SGHomeMargin, frame.size.width, frame.size.height);
    _textLabel.text = text;
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.numberOfLines = 0;
    self.size = self.backgroundView.bounds.size;
    
}

@end
