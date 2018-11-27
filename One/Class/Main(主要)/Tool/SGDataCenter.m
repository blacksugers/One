//
//  SGDataCenter.m
//  One
//
//  Created by 牛骨头 on 16/5/5.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGDataCenter.h"
#import "FMDB.h"

@interface SGDataCenter ()
@property (nonatomic, strong) FMDatabase * database; //
@property (nonatomic, strong) NSString * path; //
@end

@implementation SGDataCenter

static SGDataCenter * dataCenter = nil;
+ (SGDataCenter *)sharedDataChenter{
    if (!dataCenter) {
        dataCenter = [SGDataCenter new];
        dataCenter.sentenceArray = [NSMutableArray array];
        dataCenter.newsArray = [NSMutableArray array];
        dataCenter.contentArray = [NSMutableArray array];
        dataCenter.questionArray = [NSMutableArray array];
    }
    
    
    return dataCenter;
}

-(void)openDataBase{
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString * directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath=[directory stringByAppendingPathComponent:@"dataBase.db"];
    self.path = filePath;
    //创建FMDatabase对象
    self.database=[FMDatabase databaseWithPath:filePath];
    //打开数据
    if ([self.database open]) {
        NSLog(@"数据库打开成功!");
        if (![self isExistsWithTableName:@"sentence"]) {
            [self creatSentence];
        }
        if (![self isExistsWithTableName:@"news"]) {
            [self creatNews];
        }
        if (![self isExistsWithTableName:@"content"]) {
            [self creatContent];
        }
        if (![self isExistsWithTableName:@"question"]) {
            [self creatQuestion];
        }
    
    }else{
        NSLog(@"数据库打开失败!");
    }

}



//判断表是否存在
- (BOOL) isExistsWithTableName:(NSString *)tableName
{
    
    FMResultSet *rs = [self.database executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return NO;
}

//@property (strong ,nonatomic) NSString * strThumbnailUrl; //图片地址
//@property (strong ,nonatomic) NSString * strOriginalImgUrl; //图片地址
//@property (strong ,nonatomic) NSString * strHpTitle; //标签
//@property (strong ,nonatomic) NSString * strAuthor; //作者
//@property (strong ,nonatomic) NSString * strContent; //内容
//@property (strong ,nonatomic) NSString * strMarketTime; //时间
//@property (nonatomic, strong) NSString * me;

- (void)creatSentence{
    [self.database executeUpdate:@"CREATE TABLE [sentence] ([strHpTitle] VARCHAR(2048) PRIMARY KEY,[strAuthor] VARCHAR(2048) ,[strContent] VARCHAR(2048) ,[strMarketTime] VARCHAR(2048),[strOriginalImgUrl] VARCHAR(2048) ,[strThumbnailUrl] VARCHAR(2048));"];
}

- (void)creatNews{
    [self.database executeUpdate:@"CREATE TABLE [news] ([title] VARCHAR(256) NOT NULL,[imgUrl] VARCHAR(2048) NOT NULL,[webUrl] VARCHAR(2048) NOT NULL);"];
}

- (void)creatContent{
    [self.database executeUpdate:@"CREATE TABLE [content] ([title] VARCHAR(256) NOT NULL,[webUrl] VARCHAR(2048) NOT NULL);"];
}

//@property (nonatomic, strong) NSString * strQuestionTitle ;//": "三十岁还是个loser怎么办？",
//@property (nonatomic, strong) NSString * strQuestionContent; //": "爱斯基摩仁问：我三十岁了，基本还是个一事无成的屌丝，这辈子是不是就完蛋了，还能有梦想和机会吗？",
//@property (nonatomic, strong) NSString * strAnswerTitle;//": "@小川叔 答爱斯基摩仁：",
//@property (nonatomic, strong) NSString * strAnswerContent;//": “问题答案”,
//@property (nonatomic, strong) NSString * strQuestionMarketTime;//": "2015-12-31",
//@property (nonatomic, strong) NSString * sEditor;//": "（责任编辑：郭佳杰）"
- (void)creatQuestion{
    [self.database executeUpdate:@"CREATE TABLE [question] ([strQuestionTitle] VARCHAR(256) NOT NULL,[strQuestionContent] VARCHAR(2048) NOT NULL,[strAnswerTitle] VARCHAR(256) NOT NULL,[strAnswerContent] VARCHAR(2048),[strQuestionMarketTime] VARCHAR(256) NOT NULL,[sEditor] VARCHAR(256));"];
}

+ (void)addSentence:(SGSentence *)sentence{
    [[self sharedDataChenter].database executeUpdateWithFormat:@"INSERT INTO  sentence (strHpTitle, strAuthor, strContent, strMarketTime, strOriginalImgUrl, strThumbnailUrl) VALUES (%@, %@, %@, %@ ,%@ ,%@)",sentence.strHpTitle, sentence.strAuthor, sentence.strContent, sentence.strMarketTime, sentence.strOriginalImgUrl, sentence.strThumbnailUrl];
   
    
}
+ (void)addNewsWithTitle:(NSString *)title ImageUrl:(NSString *)imageUrl WebUrl:(NSString *)webUrl{
    [[self sharedDataChenter].database executeUpdateWithFormat:@"insert into news (title, imgUrl, webUrl) values(%@, %@, %@);",title,imageUrl, webUrl];
}
+ (void)addContentWithTitle:(NSString *)title WebUrl:(NSString *)webUrl{
    [[self sharedDataChenter].database executeUpdateWithFormat:@"insert into content (title, webUrl) values(%@, %@);",title, webUrl];
}


+ (void)addQuestionWith:(SGQuestion *)question{
    [[self sharedDataChenter].database executeUpdateWithFormat:@"INSERT INTO question (strQuestionTitle, strQuestionContent, strAnswerTitle, strAnswerContent, strQuestionMarketTime, sEditor) VALUES(%@, %@, %@, %@ ,%@ , %@)",question.strQuestionTitle, question.strQuestionContent, question.strAnswerTitle, question.strAnswerContent, question.strQuestionMarketTime, question.sEditor];
}

+ (void)removeSentence:(SGSentence *)sentence{
    [[self sharedDataChenter].database executeUpdateWithFormat:@"DELETE FROM sentence WHERE strHpTitle = %@", sentence.strHpTitle];
}
+ (void)removeNewsWithTitle:(NSString *)title {
    [[self sharedDataChenter].database executeUpdateWithFormat:@"DELETE FROM news WHERE title = %@", title];
}
+ (void)removeContentWithTitle:(NSString *)title {
     [[self sharedDataChenter].database executeUpdateWithFormat:@"DELETE FROM content WHERE title = %@", title];
}
+ (void)removeQuestionWith:(SGQuestion *)question{
     [[self sharedDataChenter].database executeUpdateWithFormat:@"DELETE FROM question WHERE strQuestionTitle = %@", question.strQuestionTitle];
}


+ (NSMutableArray *)getSentence{
    FMResultSet * rs = [[self sharedDataChenter].database executeQuery:@"SELECT * FROM sentence"];
    NSMutableArray * array = [NSMutableArray array];
    while ([rs next]) {
        SGSentence * sentence = [SGSentence new];
        sentence.strHpTitle = [rs stringForColumn:@"strHpTitle"];
        sentence.strContent = [rs stringForColumn:@"strContent"];
        sentence.strAuthor = [rs stringForColumn:@"strAuthor"];
        sentence.strMarketTime = [rs stringForColumn:@"strMarketTime"];
        sentence.strThumbnailUrl = [rs stringForColumn:@"strThumbnailUrl"];
        sentence.strOriginalImgUrl = [rs stringForColumn:@"strOriginalImgUrl"];
        [array addObject:sentence];
    }
    
    return array;
}
+ (NSMutableArray *)getNews{
    FMResultSet * rs = [[self sharedDataChenter].database executeQuery:@"SELECT * FROM news"];
    NSMutableArray * array = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"title"] = [rs stringForColumn:@"title"];
        dic[@"imgUrl"] = [rs stringForColumn:@"imgUrl"];
        dic[@"webUrl"] = [rs stringForColumn:@"webUrl"];
        [array addObject:dic];
    }

    return array;
}
+ (NSMutableArray *)getContent{
    FMResultSet * rs = [[self sharedDataChenter].database executeQuery:@"SELECT * FROM content"];
    NSMutableArray * array = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"title"] = [rs stringForColumn:@"title"];
        dic[@"webUrl"] = [rs stringForColumn:@"webUrl"];
        [array addObject:dic];
    }
    return array;
}
+ (NSMutableArray *)getQuestion{
    FMResultSet * rs = [[self sharedDataChenter].database executeQuery:@"SELECT * FROM question"];
    NSMutableArray * array = [NSMutableArray array];
    while ([rs next]) {
        SGQuestion * question = [SGQuestion new];
        question.strQuestionTitle = [rs stringForColumn:@"strQuestionTitle"];
        question.strQuestionContent = [rs stringForColumn:@"strQuestionContent"];
        question.strAnswerTitle = [rs stringForColumn:@"strAnswerTitle"];
        question.strAnswerContent = [rs stringForColumn:@"strAnswerContent"];
        question.strQuestionMarketTime = [rs stringForColumn:@"strQuestionMarketTime"];
        question.sEditor = [rs stringForColumn:@"sEditor"];
        [array addObject:question];
    }

    return array;
}

@end

