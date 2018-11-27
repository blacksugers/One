//
//  SGSentence.h
//  OneDay
//
//  Created by tarena on 15/12/30.
//  Copyright © 2015年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGSentence : NSObject

@property (strong ,nonatomic) NSString * strThumbnailUrl; //图片地址
@property (strong ,nonatomic) NSString * strOriginalImgUrl; //图片地址
@property (strong ,nonatomic) NSString * strHpTitle; //标签
@property (strong ,nonatomic) NSString * strAuthor; //作者
@property (strong ,nonatomic) NSString * strContent; //内容
@property (strong ,nonatomic) NSString * strMarketTime; //时间
@property (nonatomic, strong) NSString * me;
@end
