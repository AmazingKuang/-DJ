//
//  KHJFindViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJFindViewController.h"
#import "KHJRecommendViewController.h"
#import "KHJCassificationViewController.h"
#import "KHJBroadcastViewController.h"
#import "KHJListViewController.h"
#import "KHJAnchorViewController.h"
//搜索栏
#import "KHJSearchViewController.h"
#import "KHJFindTopSearchView.h"
#import "JXLDayAndNightMode.h"
@interface KHJFindViewController ()

@end

@implementation KHJFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    
    
    
}
+ (UINavigationController *)defaultFindUINavigationController{
    static UINavigationController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        KHJFindViewController *findvc = [[KHJFindViewController alloc] initWithViewControllerClasses:[self ViewControllerClasses] andTheirTitles:@[@"推荐",@"分类",@"广播",@"榜单",@"主播"]];
        //WMPageController的设置//带下划线
        findvc.menuViewStyle = WMMenuViewStyleLine;
        //设置item宽
        findvc.itemsWidths = @[@(ScreenWidth / 5),@(ScreenWidth / 5),@(ScreenWidth / 5),@(ScreenWidth / 5),@(ScreenWidth / 5)];
        //选中时标题的颜色
        
        findvc.titleColorSelected = [UIColor redColor];
        //未选中标题的颜色
        findvc.titleColorNormal = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1];
        //下划线进度条高度
        findvc.progressHeight = 3.5;
        //设置假导航栏颜色
        findvc.menuBGColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        //设置发现页面尺寸
        findvc.viewFrame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 49 - 64);
        findvc.startDragging = YES;
        nav = [[UINavigationController alloc] initWithRootViewController:findvc];
        [findvc release];
        
        
   [nav.navigationBar jxl_setDayMode:^(UIView *view) {
    nav.navigationBar.tintColor = [UIColor redColor];
} nightMode:^(UIView *view) {
    nav.navigationBar.tintColor = [UIColor blueColor];

}];
        
    });
    return nav;
}
+ (NSArray *)ViewControllerClasses{
    return @[[KHJRecommendViewController class],[KHJCassificationViewController class],[KHJBroadcastViewController class],[KHJListViewController class],[KHJAnchorViewController class]];
    
}
- (void)loadView{
    [super loadView];
    //发现顶部搜索栏
    KHJFindTopSearchView *searchView = [[KHJFindTopSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    searchView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    searchView.userInteractionEnabled = YES;
    searchView.turnToSearchPageBlock = ^(void)
    {
        KHJSearchViewController *sVC = [[KHJSearchViewController alloc] init];
        sVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sVC animated:YES];
        [sVC release];
    };
    [self.view addSubview:searchView];
    [KHJFindTopSearchView release];

    
    
    
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
