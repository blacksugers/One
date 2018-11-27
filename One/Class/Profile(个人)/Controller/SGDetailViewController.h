//
//  SGDetailViewController.h
//  One
//
//  Created by 牛骨头 on 16/5/9.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGDetailViewController : UIViewController

@property (nonatomic, assign)  int  type;//1图片，2新闻，3文章，4问题
@property (nonatomic, strong) SGSentence * sentence;
@property (nonatomic, strong) NSDictionary * newsDic;
@property (nonatomic, strong) NSDictionary * contentDic;
@property (nonatomic, strong) SGQuestion * question; 
@end
