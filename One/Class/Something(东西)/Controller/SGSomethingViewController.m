//
//  SGSomethingViewController.m
//  One
//
//  Created by tarena on 16/1/4.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGSomethingViewController.h"
#import "SGSomething.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface SGSomethingViewController ()
@end

@implementation SGSomethingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

#pragma mark - getNetworkDate 获取网络数据
- (void)getNetworkDate:(NSInteger)currentPage{
    
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];

    
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:- (3600 * 8)];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [formatter stringFromDate:date];
    
    parameters[@"strDate"] = dateStr;
    parameters[@"strRow"] = @(currentPage + 1);
    [mgr GET:@"http://rest.wufazhuce.com/OneForWeb/one/o_f" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * dic = responseObject[@"entTg"];
        SGSomething * something = [[SGSomething alloc]init];
        [something setValuesForKeysWithDictionary:dic];
        
        [self setupSubViewWithData:something];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"一句话请求发送失败%@", error.userInfo);
        [MBProgressHUD showError:@"网络超时"];
        [MBProgressHUD hideHUDForView:self.view];
    } ];
}

//设置 子视图
- (void)setupSubViewWithData:(SGSomething *)something{
    //      滑动视图
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SGWidth * (self.currentMaxPage), 0, SGWidth, self.view.height)];
    [self.scrollView addSubview:scrollView];
    
    UILabel * dateLabel = [[UILabel alloc]init];
    dateLabel.frame = CGRectMake(SGHomeMargin,SGHomeMargin + 64, 100, 22);
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.text = something.strTm;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SGHomeMargin, dateLabel.y + dateLabel.height + SGHomeMargin, SGWidth - SGHomeMargin * 2 , SGWidth - SGHomeMargin * 2)];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SGHomeMargin, imageView.y + imageView.height + SGHomeMargin, SGWidth - SGHomeMargin * 2, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = something.strTt;
    
    CGFloat contentLabelY = titleLabel.y + titleLabel.height + SGHomeMargin;
    UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(SGHomeMargin, contentLabelY, SGWidth - SGHomeMargin * 2, self.view.height - contentLabelY - 64 - 55)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.text = something.strTc;
//    设置滑动视图滚动范围
    scrollView.contentSize = CGSizeMake(0,  self.view.height + 1);
    CGFloat scrollViewHeight = contentLabel.y + contentLabel.height + SGHomeMargin;
    if(scrollViewHeight > (self.view.height + 1)){
        scrollView.contentSize = CGSizeMake(0, scrollViewHeight);
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:something.strBu] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [scrollView addSubview:dateLabel];
        [scrollView addSubview:imageView];
        [scrollView addSubview:titleLabel];
        [scrollView addSubview:contentLabel];
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
}

@end
