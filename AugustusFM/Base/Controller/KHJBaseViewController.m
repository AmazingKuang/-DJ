//
//  KHJBaseViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseViewController.h"
#import "KHJNetTool.h"
#import "JXLDayAndNightMode.h"


@interface KHJBaseViewController ()

@end

@implementation KHJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  夜间模式
     */
    
//    [self.view jxl_setDayMode:^(UIView *view) {
//        // 设置日间模式状态
//        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
//    } nightMode:^(UIView *view) {
//        // 设置夜间模式状态
//        view.backgroundColor = [UIColor blackColor]; // view为当前设置的视图
//
//    }];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 * lFitWidth]}];
    
    [self.navigationController.navigationBar jxl_setDayMode:^(UIView *view) {
        UINavigationBar *bar = (UINavigationBar *)view;
        // 改变状态栏前景色为黑色
        bar.barStyle = UIBarStyleDefault;
        bar.barTintColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    } nightMode:^(UIView *view) {
        
        UINavigationBar *bar = (UINavigationBar *)view;
        // 改变状态栏前景色为白色
        bar.barStyle = UIBarStyleBlack;
        bar.barTintColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

    
    [self.tabBarController.tabBar jxl_setDayMode:^(UIView *view) {
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];

    }];
//    [self.navigationController.navigationBar jxl_setDayMode:^(UIView *view) {
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    } nightMode:^(UIView *view) {
//        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];

//    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
