//
//  SGHomeViewController.m
//  One
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGHomeViewController.h"

@interface SGHomeViewController ()

@property (nonatomic, strong) NSMutableArray * sentenceArray;
@end

@implementation SGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sentenceArray = [NSMutableArray array];
}



- (void)getNetworkDate:(NSInteger)currentPage{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:- (60 * 60 * 8)];
    parameters[@"strDate"] = date;
    parameters[@"strRow"] = @(currentPage + 1);
    [mgr GET:@"http://rest.wufazhuce.com/OneForWeb/one/getHp_N" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //  获取字典
        NSDictionary * dic = responseObject[@"hpEntity"];
        SGSentence * sentence = [[SGSentence alloc]init];
        [sentence setValuesForKeysWithDictionary:dic];
        [self.sentenceArray addObject:sentence];
        SGHomeView * home = [[SGHomeView alloc]initWithFrame:CGRectMake(currentPage * SGWidth, 0, self.view.width, self.view.height)];
        home.sentence = sentence;
        [self.scrollView addSubview:home];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"一句话请求发送失败%@", error.userInfo);
        [MBProgressHUD showError:@"网络超时"];
        [MBProgressHUD hideHUDForView:self.view];
    } ];
    
}

- (void)initViewandDate{
    [super initViewandDate];
    [self.sentenceArray removeAllObjects];
    
}

- (void)clickCollectButton{
    [super clickCollectButton];
    SGSentence * mysentence = self.sentenceArray[self.currentPage];
    NSLog(@"%@",mysentence.strHpTitle);
    
    for (SGSentence * sentence in [SGDataCenter getSentence]) {
        NSLog(@"%@",sentence.strHpTitle);
        if ([sentence.strHpTitle isEqualToString:mysentence.strHpTitle]) {
            [MBProgressHUD showError:@"您已经收藏过"];
            return;
        }
    }
    [MBProgressHUD showSuccess:@"成功收藏"];
    [SGDataCenter addSentence:mysentence];
}
@end
