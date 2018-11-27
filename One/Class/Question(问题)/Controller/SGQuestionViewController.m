//
//  SGQuestionViewController.m
//  One
//
//  Created by tarena on 15/12/31.
//  Copyright © 2015年 Sugar. All rights reserved.
//

#import "SGQuestionViewController.h"
#import "SGSentence.h"
#import "SGSentenceView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "SGQuestion.h"

#define SGQuestionWidth self.view.width - SGQuestionMargin * 2

@interface SGQuestionViewController ()
@property (nonatomic, strong) NSMutableArray * questionArray;
@end

@implementation SGQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getNetworkDate 获取网络数据
- (void)getNetworkDate:(NSInteger)currentPage{
    
     [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    NSInteger hours = self.currentPage * 24 + 32;
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow: - (3600 * hours)];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [formatter stringFromDate:date];
    parameters[@"strDate"] = dateStr;
    [mgr GET:@"http://rest.wufazhuce.com/OneForWeb/one/getOneQuestionInfo" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * dic = responseObject[@"questionAdEntity"];
        SGQuestion * question = [[SGQuestion alloc]init];
        [question setValuesForKeysWithDictionary:dic];
        [self.questionArray addObject:question];
        [self setupSubViewWithData:question];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"发送失败%@", error.userInfo);
        [MBProgressHUD showError:@"网络超时"];
        [MBProgressHUD hideHUDForView:self.view];
    } ];
}

#pragma mark - setupSubViewWithData 根据数据更新界面
- (void)setupSubViewWithData:(SGQuestion *)question{
    [MBProgressHUD hideHUDForView:self.view];
    
//      滑动视图
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SGWidth * (self.currentMaxPage), 0, SGWidth, self.view.height)];
    [self.scrollView addSubview:scrollView];
    
//  日期Label
    UILabel * dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SGQuestionMargin, 64 + SGQuestionMargin, SGQuestionWidth, 20)];
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.text = question.strQuestionMarketTime;
    [scrollView addSubview:dateLabel];
    
//    问题模块
    CGPoint questionEndPoint = [self addcontentViewOnView:scrollView origin:CGPointMake(SGQuestionMargin, dateLabel.y + dateLabel.height + SGQuestionMargin) withTitle:question.strQuestionTitle imageName:@"que_img" content:question.strQuestionContent];
//    分割线
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(questionEndPoint.x, questionEndPoint.y + SGQuestionMargin, SGQuestionWidth, 1)];
    lineImageView.image = [UIImage imageNamed:@"colLine"];
    [scrollView addSubview:lineImageView];

//    回答模块
    NSString * answerContent = [question.strAnswerContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    CGPoint answerEndPoint = [self addcontentViewOnView:scrollView origin:CGPointMake(SGQuestionMargin, lineImageView.y + SGQuestionMargin) withTitle:question.strAnswerTitle imageName:@"ans_img" content:answerContent];
    
    UILabel * editorLabel = [[UILabel alloc]initWithFrame:CGRectMake(answerEndPoint.x, answerEndPoint.y + SGQuestionMargin, SGQuestionWidth, 30)];
    editorLabel.font = [UIFont systemFontOfSize:15];
    editorLabel.text = question.sEditor;
    [scrollView addSubview:editorLabel];
    scrollView.contentSize = CGSizeMake(0 , editorLabel.y + editorLabel.height + 64);
    
    
}

/**
 *  封装 问题和回答模块
 *
 *  @param view      添加到的视图
 *  @param origin    起始点
 *  @param title     标题
 *  @param imageName 图片名字
 *  @param content   内容
 *
 *  @return 最后视图的左下角坐标
 */
- (CGPoint)addcontentViewOnView:(UIView *)view origin:(CGPoint)origin withTitle:(NSString *)title imageName:(NSString *)imageName content:(NSString *)content{
    //    图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 36, 36)];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    //    标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.x + imageView.width + 20, imageView.y, SGQuestionWidth - imageView.width - SGQuestionMargin, imageView.height)];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [view addSubview:titleLabel];
    //    内容
    UILabel * contentLabel = [[UILabel alloc]init];
    CGRect contentFrame = [content boundingRectWithSize:CGSizeMake(SGQuestionWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    contentLabel.frame = CGRectMake(SGQuestionMargin, imageView.y + imageView.height + SGQuestionMargin, contentFrame.size.width, contentFrame.size.height);
    contentLabel.text = content;
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:contentLabel];
    return CGPointMake(contentLabel.x, contentLabel.y + contentLabel.height);
}

- (void)clickCollectButton{
    [super clickCollectButton];
    SGQuestion  * myQustion = self.questionArray[self.currentPage];
    
    for (SGQuestion * question in [SGDataCenter getQuestion]) {
        if ([myQustion.strAnswerTitle isEqualToString: question.strAnswerTitle]) {
            [MBProgressHUD showError:@"您已经收藏过"];
            return;
        }
    }
    [MBProgressHUD showSuccess:@"成功收藏"];
    [SGDataCenter addQuestionWith:myQustion];
}

- (void)initViewandDate{
    [super initViewandDate];
    [self.questionArray removeAllObjects];
}

@end
