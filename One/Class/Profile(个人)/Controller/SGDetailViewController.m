//
//  SGDetailViewController.m
//  One
//
//  Created by 牛骨头 on 16/5/9.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGDetailViewController.h"

#define SGQuestionWidth self.view.width - SGQuestionMargin * 2

@interface SGDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation SGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    switch (self.type) {
        case 1:
        {
            self.title = @"图片详情";
            SGHomeView * home = [[SGHomeView alloc]initWithFrame:self.view.bounds];
            home.sentence = self.sentence;
            [self.view addSubview:home];
        }
            break;
        case 2:
        {
            self.title = @"新闻详情";
            UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
            [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.newsDic[@"webUrl"]]]];
            [self.view addSubview:webView];
           
        }
             break;
        case 3:
        {
            self.title = @"文章详情";
            UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height + 55)];
            self.automaticallyAdjustsScrollViewInsets = NO;
            webView.delegate = self;
            webView.backgroundColor = [UIColor whiteColor];
            webView.scrollView.bounces = NO;

            [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.contentDic[@"webUrl"]]]];
            [self.view addSubview:webView];
           
        }
             break;
        case 4:
        {
            self.title = @"问题详情";
            [self setupSubViewWithData:self.question];
        }
            break;

    }
    UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithTitle:@"取消收藏" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCollection)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setupSubViewWithData:(SGQuestion *)question{
    
    //      滑动视图
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SGWidth, self.view.height)];
    [self.view addSubview:scrollView];
    
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

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    headerView.backgroundColor = [UIColor whiteColor];
    [webView.scrollView addSubview:headerView];
    
    webView.scrollView.contentSize = CGSizeMake(0, webView.scrollView.contentSize.height - self.view.height * 0.35);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD showError:@"网络超时"];
    [MBProgressHUD hideHUDForView:self.view];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.absoluteString isEqualToString:self.contentDic[@"webUrl"]]) {
        return YES;
    }else{
        return NO;
    }
}

- (void)cancelCollection{
    switch (self.type) {
        case 1:
            [SGDataCenter removeSentence:self.sentence];
            break;
        case 2:
            [SGDataCenter removeNewsWithTitle:self.newsDic[@"title"]];
            break;
        case 3:
            [SGDataCenter removeContentWithTitle:self.contentDic[@"title"]];
            break;
        case 4:
            [SGDataCenter removeQuestionWith:self.question];
            break;

    }
    [MBProgressHUD showSuccess:@"成功取消"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
}

@end
