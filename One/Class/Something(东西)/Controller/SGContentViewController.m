//
//  SGContentViewController.m
//  One
//
//  Created by tarena on 16/1/4.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGContentViewController.h"

@interface SGContentViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
//@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSString * urlStr;
@property (nonatomic, strong) NSMutableArray * contentArray;

@end

@implementation SGContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentArray = [NSMutableArray array];
}

- (void)getNetworkDate:(NSInteger)currentPage{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(currentPage * SGWidth, 0, self.view.width, self.view.height)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = NO;
    NSInteger hours = currentPage * 24 + 8;
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow: - (3600 * hours)];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [formatter stringFromDate:date];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    NSString * get = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/getOneContentInfo?strDate=%@",dateStr];
    
    [mgr POST:get parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //  获取字典
        NSDictionary * dic = responseObject[@"contentEntity"];
        NSString * urlStr = dic[@"sWebLk"];
        self.urlStr = urlStr;
        [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]]];
        [self.scrollView addSubview:webView];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"一句话请求发送失败%@", error.userInfo);
        [MBProgressHUD showError:@"网络超时"];
        [MBProgressHUD hideHUDForView:self.view];
    } ];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"title"] = [[webView stringByEvaluatingJavaScriptFromString:@"document.title"] componentsSeparatedByString:@"-"][0];
    dic[@"webUrl"] = webView.request.URL.absoluteString;
    [self.contentArray addObject:dic];
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
    if ([request.URL.absoluteString isEqualToString:self.urlStr]) {
        return YES;
    }else{
        return NO;
    }
}

- (void)initViewandDate{
    [super initViewandDate];
    [self.contentArray removeAllObjects];
    
}

- (void)clickCollectButton{
    [super clickCollectButton];
    NSMutableDictionary * mydic = self.contentArray[self.currentPage];
    for (NSMutableDictionary * dic in [SGDataCenter getContent]) {
        if ([dic[@"title"] isEqualToString:mydic[@"title"]]) {
            [MBProgressHUD showError:@"您已经收藏过"];
            return;
        }
    }
    [MBProgressHUD showSuccess:@"成功收藏"];
    [SGDataCenter addContentWithTitle:mydic[@"title"] WebUrl:mydic[@"webUrl"]];
}


@end
