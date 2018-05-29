//
//  KHJDownLoadListenViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDownLoadListenViewController.h"
#import "KHJAlbumViewController.h"
#import "KHJSoundViewController.h"
#import "KHJDownLoadingViewController.h"
#import "JXLDayAndNightMode.h"
#import "KHJNetTool.h"
#import "KHJDeTailRecommendTableViewCell.h"
#import "KHJspecialDetailViewController.h"
#import <MJRefresh.h>
#import "JXLDayAndNightMode.h"
@interface KHJDownLoadListenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger pNmuber;
@end

@implementation KHJDownLoadListenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden =  NO;
    self.navigationItem.title = @"推荐听";
//   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
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
    

    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.listArray = [NSMutableArray array];

    [self createTableView];
    [self createSegmentedControl];
    _pNmuber = 1;
    [self getData:@"hot" page:1];
}
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 , ScreenWidth, ScreenHeight - 64 - 49 - 40 ) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerClass:[KHJDeTailRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getOneData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
    
    
    
}
- (void)createSegmentedControl{
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"最火",@"最新",@"经典"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.segmentedControl.frame = CGRectMake(10 , 5 , ScreenWidth - 20 , 30);
    [self.segmentedControl addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [self.segmentedControl jxl_setDayMode:^(UIView *view) {
        self.segmentedControl.tintColor = [UIColor redColor];
    } nightMode:^(UIView *view) {
         self.segmentedControl.tintColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

}
#pragma mark -- 下拉刷新
- (void)getOneData{
    [self.listArray removeAllObjects];
    [self.tableView reloadData];
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self getData:@"hot" page:1];
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        [self getData:@"recent" page:1];
    }
    else{
        [self getData:@"classic" page:1];
    }
   
}

#pragma mark -- 上拉加载
- (void)getMoreData{
    _pNmuber++;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self getData:@"hot" page:_pNmuber];
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        [self getData:@"recent" page:_pNmuber];
    }
    else{
        [self getData:@"classic" page:_pNmuber];
    }

    
    
}
#pragma mark -- 请求数据
- (void)getData:(NSString *)str page:(NSInteger)pageNumber{
    if (pageNumber == 1) {
        self.listArray = [NSMutableArray array];

    }
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=%@&categoryId=0&device=android&pageId=%ld&pageSize=20&status=0&tagName=",str,pageNumber];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = [dic objectForKey:@"list"];
        for (NSDictionary *dict in array) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dict];
            [self.listArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDeTailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.listArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)action:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:
            [self getData:@"hot" page:1];
            break;
        case 1:
            [self getData:@"recent" page:1];
            break;
        case 2:
            [self getData:@"classic" page:1];
            break;
            
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJspecialDetailViewController *kdvc = [[KHJspecialDetailViewController alloc] init];
    kdvc.model = [self.listArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:kdvc animated:YES];
  
}






+ (UINavigationController *)defaultDownloadUINavigationController{
    static UINavigationController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        KHJDownLoadListenViewController *mySelfVc = [[KHJDownLoadListenViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:mySelfVc];
        [mySelfVc release];
        
    });
    return nav;
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
