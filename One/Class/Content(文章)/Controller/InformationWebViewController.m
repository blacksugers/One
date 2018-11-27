//
//  InformationWebViewController.m
//  米琪新闻
//
//  Created by 吴希广 on 16/1/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "InformationWebViewController.h"

#import "InformationModel.h"

#import "MBProgressHUD+MJ.h"



@interface InformationWebViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *CollectionButton;
@property (nonatomic, strong) InformationModel *model;


@end

@implementation InformationWebViewController

- (InformationModel *)model {

    if (!_model) {
        _model = [[InformationModel alloc] init];
    }

    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"新闻详情";
    [self addUI];
    
}

- (id)initWithModel:(InformationModel *)model{
    self.model = model;
    return self;
}


- (void)addUI{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.model.itemID?kScreenHeight - 64 - 50 :kScreenHeight - 64 )];
    
    [self.view addSubview:self.webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.model.detailUrl]];
    [self.webView loadRequest:request];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCollectButton{
    [super clickCollectButton];
    for (NSDictionary * dic in [SGDataCenter getNews]) {
        if ([dic[@"title"] isEqualToString:self.model.itemTitle]) {
            [MBProgressHUD showError:@"您已经收藏过"];
            return;
        }
    }
    [MBProgressHUD showSuccess:@"成功收藏"];
    [SGDataCenter addNewsWithTitle:self.model.itemTitle ImageUrl:self.model.imgUrl1 WebUrl:self.model.detailUrl];
}


@end
