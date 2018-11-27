//
//  InformationViewController.m
//  米琪新闻
//
//  Created by tarena on 15/12/29.
//  Copyright © 2015年 tarena. All rights reserved.
//



#import "InformationViewController.h"

#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MMProgressHUD.h"
#import "MJRefresh.h"

#import "InformationModel.h"
#import "InformationCell.h"
#import "InformationWebViewController.h"

@interface InformationViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic) BOOL isRefreshing;
@property (nonatomic) BOOL isLoadMore;


@end

@implementation InformationViewController

- (NSMutableArray *)dataArr {

    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
    [self firstDownload];
    [self addRefresh];

}

- (void)addUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationTopCell" bundle:nil] forCellReuseIdentifier:@"InformationTopCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCellID"];
    
}

- (void)addRefresh {
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.isRefreshing) {
            return;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.page = 1;
        NSString *url = [NSString stringWithFormat:self.requestUrl,self.page];
        [self addDownloadTaskWithUrl:url isRefreshing:YES];
        // 结束刷新
        [self endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.isLoadMore) {
            return;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.page ++;
        NSString *url = [NSString stringWithFormat:self.requestUrl,self.page];
        [self addDownloadTaskWithUrl:url isRefreshing:YES];
        // 结束刷新
        [self endRefreshing];
    }];
}

- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView.mj_header endRefreshing];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)firstDownload {
    
    NSString *url = self.requestUrl;
    NSString *newUrl = [NSString stringWithFormat:url,self.page];
    [self addDownloadTaskWithUrl:newUrl isRefreshing:YES];

}

- (void)addDownloadTaskWithUrl:(NSString *)url isRefreshing:(BOOL)isRefreshing {
    NSArray *arr = [url componentsSeparatedByString:@"?"];
    NSString *baseUrl = [arr firstObject];
    NSLog(@"baseUrl = %@",baseUrl);
    NSString *para = [arr lastObject];
    NSLog(@"para = %@",para);
    NSArray *paras = [para componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < paras.count; i++) {
        NSString *abc = paras[i];
        NSArray *abd = [abc componentsSeparatedByString:@"="];
        dic[abd[0]] = abd[1];
    }
    NSLog(@"dic = %@",dic);
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:baseUrl parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        NSLog(@"responseObject:%@",responseObject);
        NSArray *Array = responseObject[@"data"][@"itemList"];
        NSLog(@"Array:%@",Array);
        for (NSDictionary *dict in Array) {
            InformationModel *model = [[InformationModel alloc] init];
            model.itemTitle = dict[@"itemTitle"];
            model.brief = dict[@"brief"];
            model.detailUrl = dict[@"detailUrl"];
            model.itemID = dict[@"itemID"];
            NSDictionary *dic = dict[@"itemImage"];
            model.imgUrl1 = dic[@"imgUrl1"];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        // 提示用户下载数据失败
        [MBProgressHUD showError:@"加载失败" toView:self.view];
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InformationCell *cell = (indexPath.row == 0 ? [tableView dequeueReusableCellWithIdentifier:@"InformationTopCellID" forIndexPath:indexPath] : [tableView dequeueReusableCellWithIdentifier:@"InformationCellID" forIndexPath:indexPath]);
    InformationModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model andIndexPath:indexPath];

    return cell;
}

#pragma mark -- table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return (indexPath.row == 0 ? kScreenHeight *1/3 : 100);

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    InformationModel *model = self.dataArr[indexPath.row];
    InformationWebViewController *vc = [[InformationWebViewController alloc] initWithModel:model];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
