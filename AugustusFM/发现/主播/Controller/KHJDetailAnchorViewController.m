//
//  KHJDetailAnchorViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDetailAnchorViewController.h"
#import "KHJNetTool.h"
#import "KHJsmallAnchorModel.h"
#import "KHJHotTableViewCell.h"
#import "KHJSecondAnchorDetailViewController.h"
#import <MJRefresh.h>
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJDetailAnchorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, retain) UISegmentedControl *segmentControl;
@property (nonatomic, assign) NSInteger pNumber;
@property (nonatomic, retain) MBProgressHUD *mbView;
@end

@implementation KHJDetailAnchorViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
       [self.tabBarController.tabBar setHidden:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pNumber = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _model.title;
    [self createSegment];
    [self createTableView];
    [self getData:@"hot" page:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButton)];
}
#pragma mark -- 回到其那一页
- (void)didClickedBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 创建tableView
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight - 64 - 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[KHJHotTableViewCell class] forCellReuseIdentifier:@"cell"];
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
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self getData:@"hot" page:1];
    }else{
    [self getData:@"new" page:1];
    }
}
#pragma mark -- 上拉加载
- (void)getMoreData{
    _pNumber++;
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self getData:@"hot" page:_pNumber];
    }else{
        [self getData:@"new" page:_pNumber];
    }

}


#pragma mark -- tableView协议
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJSecondAnchorDetailViewController *ksavc = [[KHJSecondAnchorDetailViewController alloc] init];
    ksavc.model = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ksavc animated:YES];
    
}
#pragma mark -- 创建一个segment
- (void)createSegment{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"最火",@"最新"]];
    self.segmentControl.selectedSegmentIndex = 0;
//    _segmentControl.tintColor = [UIColor redColor];
    self.segmentControl.frame = CGRectMake(10 * lFitWidth, 5 * lFitHeight, ScreenWidth - 20 * lFitWidth, 30 * lFitHeight);
    [self.segmentControl jxl_setDayMode:^(UIView *view) {
        self.segmentControl.tintColor = [UIColor redColor];
    } nightMode:^(UIView *view) {
        self.segmentControl.tintColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

    [self.segmentControl addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentControl];
}
#pragma mark -- 请求数据
- (void)getData:(NSString *)str page:(NSInteger)pageNumber{
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    
    
    if (pageNumber == 1) {
        self.dataSource = [NSMutableArray array];
    }
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_list?category_name=%@&condition=%@&device=android&page=%ld&per_page=20",_model.name,str,pageNumber];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"user" WithPath:@"user.plist"];
        NSArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listarray) {
            KHJsmallAnchorModel *smallModel = [[KHJsmallAnchorModel alloc] initWithDic:dict];
            [self.dataSource addObject:smallModel];
//             NSLog(@"%@",dict);
        }
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mbView hide:YES];
        });

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"user" WithPath:@"user.plist"];
        NSArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listarray) {
            KHJsmallAnchorModel *smallModel = [[KHJsmallAnchorModel alloc] initWithDic:dict];
            [self.dataSource addObject:smallModel];
            //             NSLog(@"%@",dict);
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];        
    }];
}
- (void)action:(UISegmentedControl *)control{
    switch (control.selectedSegmentIndex) {
        case 0:
            [self getData:@"hot" page:1];
//            [self.tableView reloadData];
            break;
        case 1:
            [self getData:@"new" page:1];
//            [self.tableView reloadData];
            break;
        default:
            break;
    }
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
