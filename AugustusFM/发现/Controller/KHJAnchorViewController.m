//
//  KHJAnchorViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJAnchorViewController.h"
#import "KHJAnchorTableViewCell.h"
#import "KHJNetTool.h"
#import "KHJAnchorModel.h"
#import "KHJDetailAnchorViewController.h"
#import <MJRefresh.h>
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJAnchorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
//数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;
//分区标题数组

@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, assign) NSInteger pNumber;
@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJAnchorViewController
- (void)dealloc{
    [_tableView release];
    [_dataSource release];
    [_titleArray release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    self.pNumber = 1;
    self.dataSource = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    [self getdata:1];
    [self createSubView];
    [_tableView jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        
    }];

}
- (void)createSubView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[KHJAnchorTableViewCell class] forCellReuseIdentifier:@"cell"];
    //下拉刷新
    //设置回调(一旦进入刷新状态,就调用target的action.也就是调用self的getdata方法)
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOneData)];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%ld",i]];
        [array addObject:image];
    }
    NSMutableArray *finishArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 3; i++) {
        UIImage *finishImage = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%ld",i]];
        [finishArray addObject:finishImage];
    }
    //设置普通动画的图片
    [header setImages:array forState:MJRefreshStateIdle];
    //设置即将进入刷新状态的动画图片
    [header setImages:finishArray forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:finishArray forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //开始上拉加载
        [self getMoreData];
    }];
    

    
    
}
#pragma mark -- 下拉刷新
- (void)getOneData{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    [self getdata:1];
}
#pragma mark -- 上拉加载
- (void)getMoreData{
    _pNumber++;
    [self getdata:_pNumber];
}

#pragma mark -- 请求数据
- (void)getdata:(NSInteger)pageNumber{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_index?device=android&page=%ld",pageNumber];
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"explore" WithPath:@"explore.plist"];
        NSArray *array = [dic objectForKey:@"list"];
        //分区标题
        for (NSDictionary *dict in array) {
            KHJAnchorModel *model = [[KHJAnchorModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
        }
        [self.mbView hide:YES afterDelay:1];

        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"explore" WithPath:@"explore.plist"];
        NSArray *array = [dic objectForKey:@"list"];
        //分区标题
        for (NSDictionary *dict in array) {
            KHJAnchorModel *model = [[KHJAnchorModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.mbView hide:YES afterDelay:1];
    }];
}
//返回行数的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175 * lFitHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
//在分区下的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.dataSource.count != 0) {
        cell.model = [self.dataSource objectAtIndex:indexPath.section];
    }
    void (^blc)(KHJSecondAnchorDetailViewController *) = ^(KHJSecondAnchorDetailViewController *svc){
        [self.navigationController pushViewController:svc animated:YES];
    };
    
    cell.block = blc;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40 * lFitHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 * lFitHeight)];
    header.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10 * lFitHeight)];
    lineView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    [header addSubview:lineView];
    
    UIImageView *titleImageview = [[UIImageView alloc] initWithFrame:CGRectMake(5 * lFitWidth, 15 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight)];
    titleImageview.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [header addSubview:titleImageview];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17 * lFitWidth, 10 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight)];
    label.font = [UIFont systemFontOfSize:15 * lFitWidth];
    KHJAnchorModel *model = [self.dataSource objectAtIndex:section];
    label.text = model.title;
    [header addSubview:label];
    
    UIImageView *turnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(390 * lFitWidth, 18 * lFitHeight, 8 * lFitWidth, 10 * lFitHeight)];
    turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
    [header addSubview:turnImageView];
    
   
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, ScreenWidth, 40 * lFitHeight);
    button.alpha = 0.1;
    button.tag = 10000 + section;
    [button addTarget:self action:@selector(didTap:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:button];
    
    [tableView jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        tableView.backgroundColor = [UIColor whiteColor];
        //        // 设置日间模式状态
        lineView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        header.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
    } nightMode:^(UIView *view) {
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];

        // 设置夜间模式状态
        header.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        lineView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        label.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        label.textColor = [UIColor whiteColor];
    }];
    
    
    
    return header;
}
- (void)didTap:(UIButton *)button{
    NSInteger intt =  button.tag - 10000;
    KHJAnchorModel *model = [self.dataSource objectAtIndex:intt];
    KHJDetailAnchorViewController *vc = [[KHJDetailAnchorViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
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
