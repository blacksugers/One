//
//  SGMainViewController.m
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGMainViewController.h"
#import "SGHomeView.h"
@interface SGMainViewController ()<UIScrollViewDelegate>


@end

@implementation SGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self initViewandDate];
    
    
}
//设置滑动视图
- (void)setupScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SGWidth * 2, 0);
    self.scrollView.pagingEnabled = YES;

    [self.view addSubview:self.scrollView];

}
//初始化界面和数据
- (void)initViewandDate{
    self.refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(- SGWidth * 0.25, self.view.height * 0.5, SGWidth * 0.25, 12)];
    self.refreshLabel.font = [UIFont systemFontOfSize:12];
    self.refreshLabel.textAlignment = NSTextAlignmentRight;
    self.currentMaxPage = 0;
    [self.scrollView addSubview:self.refreshLabel];
    [self getNetworkDate:0];

}


- (void)getNetworkDate:(NSInteger)currentPage{
// 子类重写此方法 获取不同的数据
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger endPage = scrollView.contentOffset.x / self.view.width;
    if (endPage > self.currentPage) {
        self.currentPage = endPage;
        if (self.currentPage > self.currentMaxPage) {
            self.currentMaxPage = self.currentPage;
            [self getNetworkDate:self.currentPage];
            
            if (self.currentPage < 9) {
                self.scrollView.contentSize = CGSizeMake(SGWidth * (self.currentPage + 2), 0);
            }else{
                UILabel * endLabel = [[UILabel alloc]initWithFrame:CGRectMake(SGWidth * 10, 0, SGWidth * 0.25, self.view.height - 64)];
                endLabel.font = [UIFont systemFontOfSize:12];
                endLabel.textAlignment = NSTextAlignmentLeft;
                endLabel.text = @"已无更多内容";
                [self.scrollView addSubview:endLabel];
            }
        }
        
    }
    if (self.currentPage == 0) {
        if (self.scrollView.contentOffset.x < - (SGWidth * 0.2)){
            self.refreshLabel.text = @"松开刷新数据...";
        }else{
            self.refreshLabel.text = @"右拉刷新...";
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.currentPage = scrollView.contentOffset.x / self.view.width;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView.contentOffset.x <= - (SGWidth * 0.2)) {
        scrollView.contentSize = CGSizeMake(SGWidth * 2, 0);
        for(UIView *view in [scrollView subviews])
        {
            [view removeFromSuperview];
        }
        
        [self initViewandDate];
    }
}


@end
