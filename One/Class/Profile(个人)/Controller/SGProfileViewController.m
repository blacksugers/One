//
//  SGProfileViewController.m
//  One
//
//  Created by tarena on 16/1/4.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGProfileViewController.h"
#import "SGProfileViewCell.h"
#import "SGMyCollectionViewController.h"
#import "SGSettingViewController.h"
#import "SGAboutViewController.h"

@interface SGProfileViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArray;
@end

@implementation SGProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"我的收藏",@"设置",@"关于"];
    }
    return _titleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SGProfileViewCell * cell = [[SGProfileViewCell alloc]init];
    switch (indexPath.row) {
        case 0:
            [self setupCell:cell withTitle:self.titleArray[0] imageName:@"phone_default_006"];
            break;
        case 1:
            [self setupCell:cell withTitle:self.titleArray[1] imageName:@"setting"];
            break;
        case 2:
            [self setupCell:cell withTitle:self.titleArray[2] imageName:@"copyright"];
            break;
        default:
            break;
    }
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell withTitle:(NSString *)title imageName:(NSString *)imageName {
    cell.textLabel.text = title;
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p_arrow"]];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            SGMyCollectionViewController * myCollection = [SGMyCollectionViewController new];
            myCollection.title = self.titleArray[0];
            myCollection.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myCollection animated:YES];
        }
            break;
        case 1:
        {
            SGSettingViewController * setting = [SGSettingViewController new];
            setting.title = self.titleArray[1];
            setting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setting animated:YES];
        }
            break;
        case 2:
        {
            SGAboutViewController * about = [SGAboutViewController new];
            about.title = self.titleArray[2];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
    
    }
}

@end

