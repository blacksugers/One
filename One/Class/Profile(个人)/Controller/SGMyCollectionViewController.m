//
//  SGMyCollectionViewController.m
//  One
//
//  Created by tarena on 16/1/5.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGMyCollectionViewController.h"
#import "UINavigationBar+SGBackgroundColor.h"
#import "SGHeaderView.h"
#import "InformationCell.h"
#import "InformationModel.h"
#import "InformationWebViewController.h"
#import "SGDetailViewController.h"

@interface SGMyCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,SGHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>
/**
 *  头部视图
 */
@property (nonatomic, strong) SGHeaderView * headerView;
/**
 *  集合视图
 */
@property (nonatomic, strong) UICollectionView * collectionView;
/**
 *  当前按钮tag
 */

//表视图
@property (nonatomic, strong) UITableView * tableView;


@property (nonatomic, assign) NSInteger currentButtonTag;

@end

@implementation SGMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentButtonTag = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.delegate = self;
    self.title = @"我的收藏";
    self.headerView = [[SGHeaderView alloc] initWithFrame:CGRectMake(0, 0, SGWidth, SGWidth * 0.5)];
    self.headerView.delegate = self;
    //[self setupNavigationBar];
    [self setupTableView];
    [self setupCollectionView];
    [self.view addSubview:self.headerView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"reloadData" object:nil];
    
}

- (void)reloadData{
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

/**
 *  设置导航栏
 */
#pragma mark - SetUp
- (void)setupNavigationBar{
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    for (UIView * subView in self.navigationController.navigationBar.subviews) {
        if ([subView.class isSubclassOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            [subView removeFromSuperview];
            
        }
    }
}
/**
 *  设置集合视图
 */
- (void)setupCollectionView{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}

- (void)setupTableView{

    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCellID"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"contentCell"];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - UICollectionViewDataSource 
//   有几组
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每组有几个
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [SGDataCenter getSentence].count;
    
}
//每个什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SGWidth - 2) * 0.5, (SGWidth - 2) * 0.5)];
    SGSentence * sentence = [SGDataCenter getSentence][indexPath.row];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:sentence.strThumbnailUrl] placeholderImage:nil];
    [cell.contentView addSubview: imageView];
    
    
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//每组的上下左右距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
//每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.currentButtonTag) {
        case 0:
            return CGSizeMake((SGWidth - 2) * 0.5, (SGWidth - 2) * 0.5);
            break;
        case 3:
            return CGSizeMake((SGWidth - 2) * 0.5, (SGWidth - 2) * 0.5 * 0.75);
            break;
        default:
            return CGSizeZero;
    }
    
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
//头部视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SGWidth, SGWidth * 0.5);
}
#pragma mark - UICollectionViewDelegateFlowLayout
//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SGSentence * sentence = [SGDataCenter getSentence][indexPath.row];
    SGDetailViewController * vc = [[SGDetailViewController alloc]init];
    vc.type = 1;
    vc.sentence = sentence;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollViewY = scrollView.contentOffset.y;
    CGFloat changeHeight = SGWidth * 0.5 - 64.0 - SGWidth / 8.0;
    CGFloat alpha = scrollViewY / changeHeight;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:alpha]];
    if (alpha <= 1) {
        self.headerView.frame = CGRectMake(0, -scrollViewY, self.headerView.frame.size.width, self.headerView.frame.size.height);
        
    }else{
        self.headerView.frame = CGRectMake(0, -changeHeight, self.headerView.frame.size.width, self.headerView.frame.size.height);
        
    }
    
}

#pragma mark - SGHeaderViewDelegate
- (void)headerViewdidClickButton:(UIButton *)sender{
    NSLog(@"headerViewdidClickButton_%ld",sender.tag);
    self.currentButtonTag = sender.tag;
    [self scrollViewDidScroll:self.scrollView];
    if (self.currentButtonTag == 0 ) {
        [self.collectionView setHidden:NO];
        [self.collectionView reloadData];
    }else{
        [self.collectionView setHidden:YES];
        [self.tableView reloadData];
    }
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.currentButtonTag) {
        case 1:
            return [SGDataCenter getNews].count;
            break;
        case 2:
            return [SGDataCenter getContent].count;
            break;
        case 3:
            return [SGDataCenter getQuestion].count;
            break;
        default:
            return 0;
            break;
            
    }

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.currentButtonTag) {
        case 1:
        {
            InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCellID" forIndexPath:indexPath];
            InformationModel *model = [InformationModel new];
            NSDictionary * dic = [SGDataCenter getNews][indexPath.row];
            model.itemTitle = dic[@"title"];
            model.imgUrl1 = dic[@"imgUrl"];
            model.detailUrl = dic[@"webUrl"];
            [cell showDataWithModel:model andIndexPath:indexPath];
            
            return cell;
        }
            break;
        case 2:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
            NSDictionary * dic =[SGDataCenter getContent][indexPath.row];
            cell.textLabel.text = dic[@"title"];
            return cell;
        }
            break;
        case 3:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
            SGQuestion * question =[SGDataCenter getQuestion][indexPath.row];
            cell.textLabel.text = question.strQuestionTitle;
            return cell;
        }
            break;

            
        default:
            return nil;
            break;

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:self.headerView.frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headerView.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.currentButtonTag) {
        case 1:
        return 100;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 40;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    switch (self.currentButtonTag) {
        case 1:
        {

            NSDictionary * dic = [SGDataCenter getNews][indexPath.row];

//            InformationWebViewController *vc = [[InformationWebViewController alloc] initWithModel:model];
            SGDetailViewController * vc = [[SGDetailViewController alloc]init];
            vc.type = 2;
            vc.newsDic = dic;
            [self.navigationController pushViewController:vc animated:YES];
            
        
        }
            break;
        case 2:
        {
            
            NSDictionary * dic =[SGDataCenter getContent][indexPath.row];
            SGDetailViewController * vc = [[SGDetailViewController alloc]init];
            vc.type = 3;
            vc.contentDic = dic;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
            break;
        case 3:
        {
            
            SGQuestion * question = [SGDataCenter getQuestion][indexPath.row];
            SGDetailViewController * vc = [[SGDetailViewController alloc]init];
            vc.type = 4;
            vc.question = question;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
            break;
    
    }

}
@end
