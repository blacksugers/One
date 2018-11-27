//
//  SGQuestion.h
//  One
//
//  Created by tarena on 16/1/4.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGQuestion : NSObject
@property (nonatomic, strong) NSString * strQuestionTitle ;//": "三十岁还是个loser怎么办？",
@property (nonatomic, strong) NSString * strQuestionContent; //": "爱斯基摩仁问：我三十岁了，基本还是个一事无成的屌丝，这辈子是不是就完蛋了，还能有梦想和机会吗？",
@property (nonatomic, strong) NSString * strAnswerTitle;//": "@小川叔 答爱斯基摩仁：",
@property (nonatomic, strong) NSString * strAnswerContent;//": “问题答案”,
@property (nonatomic, strong) NSString * strQuestionMarketTime;//": "2015-12-31",
@property (nonatomic, strong) NSString * sEditor;//": "（责任编辑：郭佳杰）"
@end
