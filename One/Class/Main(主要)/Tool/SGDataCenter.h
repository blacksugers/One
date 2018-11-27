//
//  SGDataCenter.h
//  One
//
//  Created by 牛骨头 on 16/5/5.
//  Copyright © 2016年 Sugar. All rights reserved.
//  管理数据库

#import <Foundation/Foundation.h>

@interface SGDataCenter : NSObject

@property (nonatomic, strong) NSMutableArray * sentenceArray;
@property (nonatomic, strong) NSMutableArray * newsArray;
@property (nonatomic, strong) NSMutableArray * contentArray;
@property (nonatomic, strong) NSMutableArray * questionArray;
+ (SGDataCenter *)sharedDataChenter;
- (void)openDataBase;

+ (void)addSentence:(SGSentence *)sentence;
+ (void)addNewsWithTitle:(NSString *)title ImageUrl:(NSString *)imageUrl WebUrl:(NSString *)webUrl;
+ (void)addContentWithTitle:(NSString *)title WebUrl:(NSString *)webUrl;
+ (void)addQuestionWith:(SGQuestion *)question;

+ (NSMutableArray *)getSentence;
+ (NSMutableArray *)getNews;
+ (NSMutableArray *)getContent;
+ (NSMutableArray *)getQuestion;

+ (void)removeSentence:(SGSentence *)sentence;
+ (void)removeNewsWithTitle:(NSString *)title ;
+ (void)removeContentWithTitle:(NSString *)title ;
+ (void)removeQuestionWith:(SGQuestion *)question;

@end
