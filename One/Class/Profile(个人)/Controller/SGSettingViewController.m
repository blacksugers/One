//
//  SGSettingViewController.m
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGSettingViewController.h"

@interface SGSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation SGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"浏览模式";
            break;
        case 1:
            return @"缓存设置";
            break;
        case 2:
            return @"更多";
            break;
        case 3:
            return nil;
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"夜间模式切换";
            break;
        case 1:
            cell.textLabel.text = @"清除缓存";
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"去评分";
                    break;
                case 1:
                    cell.textLabel.text = @"反馈";
                    break;
                case 2:
                    cell.textLabel.text = @"用户协议";
                    break;
                case 3:
                    cell.textLabel.text = @"版本号";
                    break;

            }
            break;
        case 3:
            cell.textLabel.text = @"退出当前账号";
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end
