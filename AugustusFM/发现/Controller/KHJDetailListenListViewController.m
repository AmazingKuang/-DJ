//
//  KHJDetailListenListViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDetailListenListViewController.h"
#import "KHJNetTool.h"
#import "KHJDetailListenListCell.h"
#import "KHJDetailListenModel.h"
#import "KHJhearingViewController.h"
#import <MJRefresh.h>
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
#import "KHJParticularsModel.h"
@interface KHJDetailListenListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
//时间戳
@property (nonatomic, retain) NSDateFormatter *objDateformat;
//数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;
//时间戳数据数组
@property (nonatomic, retain) NSMutableArray *timeArray;


@property (nonatomic, retain) NSMutableDictionary *bigDic;

@property (nonatomic, assign) NSInteger pNumber;
@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJDetailListenListViewController

- (void)dealloc{
    [_tableView release];
    [_objDateformat release];
    [_dataSource release];
    [_timeArray release];
    [_bigDic release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pNumber = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title  = @"精品听单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didclickBar)];
    
    
    self.dataSource = [NSMutableArray array];
    self.bigDic= [NSMutableDictionary dictionary];

    //时间戳数组初始化吧
    self.timeArray = [NSMutableArray array];
    [self getData:1];
    [self createTableView];
}
- (void)didclickBar{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
//    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
//    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[KHJDetailListenListCell class] forCellReuseIdentifier:@"cell"];
    
//    下拉刷新
//    设置回调(一旦进入刷新状态,就调用target的action.也就是调用self的getdata方法)
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

    /**
     *  夜间模式
     */
    [_tableView jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        
    }];
    
    
}
#pragma mark -- 时间戳数据
- (NSString *)setString:(NSString *)str{
    NSString * timeStampString = str;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM/dd/yyyy"];
    NSString *key =[objDateformat stringFromDate: date];
    return key;
}
#pragma mark -- 下拉刷新
- (void)getOneData{
    //清空数组
    [self.dataSource removeAllObjects];
    [self.bigDic removeAllObjects];
    [self.tableView reloadData];
    [self getData:1];
}
- (void)getMoreData{
    _pNumber++;
    [self getData:_pNumber];
}
#pragma mark -- 解析数据
- (void)getData:(NSInteger)pageNumber{
//    [self.bigDic removeAllObjects];
//    [self.dataSource removeAllObjects];
      NSString *string =[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_list?device=android&page=%ld&per_page=10",pageNumber];
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"device" WithPath:@"device"];
        NSMutableArray *array = [dic objectForKey:@"list"];
        
//        NSMutableArray *array1 = [NSMutableArray array];
//        for (NSDictionary *diction in array) {
//           
//          NSString *key = [self setString:[diction objectForKey:@"releasedAt"]];
//             [self.dataSource addObject:key];
//            [self.bigDic setObject:array1 forKey:key];
//           
//        }
//        NSLog(@"*-------------%@", self.dataSource);
        for (NSDictionary *dicti in array) {
         NSString *key = [self setString:[dicti objectForKey:@"releasedAt"]];
            
            NSMutableArray *array2= [_bigDic objectForKey:key];
            
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:dicti];
            if (array2.count == 0) {
                array2 = [NSMutableArray array];
                [self.bigDic setObject:array2 forKey:key];
                [self.dataSource addObject:key];
            }
            [array2 addObject:model];

        }
            [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mbView hide:YES];
        });

        
    } failure:^(NSError *error) {
      NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"device" WithPath:@"device.plist"];
        NSMutableArray *array = [dic objectForKey:@"list"];
        for (NSDictionary *dicti in array) {
            NSString *key = [self setString:[dicti objectForKey:@"releasedAt"]];
            
            NSMutableArray *array2= [_bigDic objectForKey:key];
            
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:dicti];
            if (array2.count == 0) {
                array2 = [NSMutableArray array];
                [self.bigDic setObject:array2 forKey:key];
                [self.dataSource addObject:key];
            }
            [array2 addObject:model];
            
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
      }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95 * lFitHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       NSString *key = [self.dataSource objectAtIndex:section];
    NSArray *array = [self.bigDic objectForKey:key];

    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDetailListenListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = [self.dataSource objectAtIndex:indexPath.section];
//     NSString *key = [[self.bigDic allKeys] objectAtIndex:indexPath.section];
    NSArray *array = [self.bigDic objectForKey:key];
    cell.model = array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30 * lFitHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *key = [self.dataSource objectAtIndex:section];
//    NSString *key = [[self.bigDic allKeys] objectAtIndex:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30 * lFitHeight)];

    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10 * lFitHeight)];
    grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    [headerView addSubview:grayView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * lFitWidth, 13 * lFitHeight, 12  *lFitWidth, 12 * lFitHeight)];
    imageView.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [headerView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30 * lFitWidth, 10 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight)];
    label.text = key;
    [headerView addSubview:label];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJhearingViewController *khvc = [[KHJhearingViewController alloc] init];
    NSString *key = [self.dataSource objectAtIndex:indexPath.section];
    
    NSArray *array = [self.bigDic objectForKey:key];
    khvc.model = [array objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:khvc animated:YES];
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
