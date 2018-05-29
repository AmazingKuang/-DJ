//
//  KHJTabBarViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTabBarViewController.h"
#import "KHJFindViewController.h"
#import "KHJMySelfViewController.h"
#import "KHJDownLoadListenViewController.h"
#import "KHJSubscibeViewController.h"
#import "JXLDayAndNightMode.h"
@interface KHJTabBarViewController ()

@end

@implementation KHJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbarController的控制器
//发现页面
    UINavigationController *findvc = [KHJFindViewController defaultFindUINavigationController];
    [self setChildController:findvc imageName: @"tabbar_find_n" selectImage:@"tabbar_find_h"];
    //订阅界面
    UINavigationController *sbvc = [KHJSubscibeViewController defaultSubscibeViewUINavigationController];
    [self setChildController:sbvc imageName:@"tabbar_sound_n" selectImage:@"tabbar_sound_h"];
    //中间占位
    UIViewController *vc = [[UIViewController alloc] init];
    [self setChildController:vc imageName:nil selectImage:nil];
    //下载听
    UINavigationController *dsvc = [KHJDownLoadListenViewController defaultDownloadUINavigationController];
    [self setChildController:dsvc imageName:@"tuijian" selectImage:@"tuijianselected"];
    //我的界面
    UINavigationController *mySelf =[KHJMySelfViewController defaultMySelfNavigationController];
    [self setChildController:mySelf imageName:@"tabbar_me_n" selectImage: @"tabbar_me_h"];
    
   
    
}
#pragma mark -- 设置item对应页面的主控制器并设置tabBar属性
- (void)setChildController:(UIViewController *)vc imageName:(NSString *)imageName selectImage:(NSString *)selectedImage{
    //创建tabBarItem并设置图片不被渲染
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置图片间距
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [self addChildViewController:vc];
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
