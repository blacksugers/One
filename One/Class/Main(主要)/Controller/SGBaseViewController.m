//
//  SGBaseViewController.m
//  One
//
//  Created by 牛骨头 on 16/5/5.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "SGBaseViewController.h"
#import "UINavigationBar+SGBackgroundColor.h"

@interface SGBaseViewController ()

@end

@implementation SGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(clickCollectButton)];
    [rightBarButtonItem setTintColor:SGBlue];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCollectButton{
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
