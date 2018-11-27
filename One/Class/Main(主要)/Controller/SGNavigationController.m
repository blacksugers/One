//
//  SGNavigationController.m
//  One
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGNavigationController.h"
#import "UIBarButtonItem+SG.h"
@interface SGNavigationController ()



@property (nonatomic, assign) BOOL isShare;

@end

@implementation SGNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        UIImageView * logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
        logoImageView.frame = CGRectMake(0, 0, logoImageView.width *0.5, logoImageView.height * 0.5);
        UIView * logoView = [[UIView alloc]init];
        logoView.size = CGSizeMake(logoImageView.width, 30);
        [logoView addSubview:logoImageView];
        rootViewController.navigationItem.titleView = logoView;
//        if (![rootViewController.title isEqualToString:@"个人"]) {
//                //    添加左边按钮
//                UIImage * image = [UIImage imageNamed:@"shareBtn"];
//                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickShareButton:)];
//            
//                rootViewController.navigationItem.rightBarButtonItem = rightBarButtonItem;
//        }
        
    }
    return self;
}


//分享按钮
- (void)clickShareButton:(UIButton *)sender{
//    NSLog(@"clickShareButton----%@",self.topViewController);
//    SGShareView * view = [[SGShareView alloc]initWithFrame:CGRectMake(0, self.topViewController.view.height * 0.5, SGWidth, 670)];
//
//    [self.topViewController.view addSubview:view];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        UIBarButtonItem * leftButtonItem = [UIBarButtonItem itemWithimageName:@"navBackBtn"highImageName:@"navBackBtn_hl" target:self action:@selector(clickBack)];
        viewController.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)clickBack{
    [self popViewControllerAnimated:YES];
}

@end
