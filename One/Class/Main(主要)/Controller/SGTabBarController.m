//
//  SGTabBarController.m
//  OneDay
//
//  Created by tarena on 15/12/30.
//  Copyright © 2015年 Sugar. All rights reserved.
//

#import "SGTabBarController.h"
#import "SGNavigationController.h"
#import "SGHomeViewController.h"
#import "SGQuestionViewController.h"
#import "InformationViewController.h"
#import "SGSomethingViewController.h"
#import "SGProfileViewController.h"
#import "SGMainViewController.h"
#import "WMPageController.h"
#import "SGContentViewController.h"
@interface SGTabBarController ()

@end

@implementation SGTabBarController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUpChildViewController];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = SGBlue;
}
/**
 *  设置子控制器
 */
- (void)setUpChildViewController {
    
    [self addChildViewController:[SGHomeViewController new]  title:@"首页" imageName:@"home" selectImageName:@"homeSelected"];

    //1, 资讯界面
    NSArray *informationTitlesArr = @[@"要闻",
                                      @"时政",
                                      @"军事",
                                      @"体育",
                                      @"财经",
                                      @"社会",
                                      
                                      ];
    
    NSArray *informationUrl = @[kInformationYaoWen,
                                kInformationShiZheng,
                                kInformationJunShi,
                                kInformationTiYu,
                                
                                kInformationCaiJing,
                                kInformationSheHui,
                                
                                ];
    // 用来存储每个标题对应的视图
    NSMutableArray *informationmArr = [NSMutableArray array];
    
    // 数据基本相同，界面相同，所以用同一个视图
    for (int i = 0; i < informationTitlesArr.count; i++) {
        
        InformationViewController *vc = [[InformationViewController alloc] init];
        vc.requestUrl = informationUrl[i];
        [informationmArr addObject:vc];
    }
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllers:informationmArr andTheirTitles:informationTitlesArr];

    
    
    [self addChildViewController:pageVC title:@"新闻" imageName:@"reading" selectImageName:@"readingSelected"];
    
    [self addChildViewController:[SGContentViewController new] title:@"文章" imageName:@"thing" selectImageName:@"thingSelected"];
    
    [self addChildViewController:[SGQuestionViewController new] title:@"问题" imageName:@"question" selectImageName:@"questionSelected"];
    
    [self addChildViewController:[SGProfileViewController new] title:@"个人" imageName:@"person" selectImageName:@"personSelected"];
}


/**
 *  添加子控制器
 *
 *  @param childController 子控制器
 *  @param title           标题
 *  @param image           图标名字
 *  @param selectImageName 选中图标名字
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
//    设置标题
    childController.title = title;
//    设置图标
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
//    设置选中图标
    UIImage * selectedImage = [UIImage imageNamed:selectImageName];
//    设置该图片不被渲染
#warning 加强记忆
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    
    SGNavigationController * nav = [[SGNavigationController alloc]initWithRootViewController:childController];
//    添加到TabBar中
    [self addChildViewController:nav];
}


@end
