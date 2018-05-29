//
//  KHJCapitalBroadcastViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJCapitalBroadcastViewController.h"
#import "KHJDalianTableViewCell.h"
#import "KHJNetTool.h"
#import "KHJDalianModel.h"
#import <MJRefresh.h>
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJCapitalBroadcastViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger pNumber;
@property (nonatomic, retain) MBProgressHUD *mbView;
@property (nonatomic, assign) NSInteger selectItem;
@end

@implementation KHJCapitalBroadcastViewController
- (void)dealloc{
    [_tableView release];
    [_dataSource release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pNumber = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButton)];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.navigationItem.title = @"本地台";
    self.dataSource = [NSMutableArray array];
    [self createTableView];
    [self getData:1];
    
    /**
     夜间模式
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
   
        _tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
     }];

}
#pragma mark -- 回到其那一页
- (void)didClickedBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView release];
    //注册cell
    [self.tableView registerClass:[KHJDalianTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //       //开始下拉刷新
    //        [self getData];
    //    }];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //开始上拉加载
        [self getMOreData];
    }];

    
    
    
    
}
#pragma mark -- 下拉刷新
- (void)getOneData{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    [self getData:1];
}
#pragma mark -- 上拉加载
- (void)getMOreData{
    _pNumber++;
    [self getData:_pNumber];
}
- (void)getData:(NSInteger)pageNumber{
    NSString *string = [NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v2/radio/province?pageNum=%ld&pageSize=20&provinceCode=210000",pageNumber];
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"province" WithPath:@"province.plist"];
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSArray *dataArray = [dict objectForKey:@"data"];
        for (NSDictionary *diction in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:diction];
            [self.dataSource addObject:model];
        }
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
        });
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"province" WithPath:@"province.plist"];
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSArray *dataArray = [dict objectForKey:@"data"];
        for (NSDictionary *diction in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:diction];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDalianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [self.dataSource objectAtIndex:indexPath.item];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
              //显示当前播放行:
        if (_selectItem != indexPath.row) {
            [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectItem inSection:0]] soundImageView] setImage:[UIImage imageNamed:@"sound_playbtn"]];
        }
       [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] soundImageView] setImage:[UIImage imageNamed:@"cell_sound_pause_n"]];
    
    //通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[self.dataSource objectAtIndex:indexPath.row] coverSmall]];
    userInfo[@"musicURL"] = [NSURL URLWithString:[[self.dataSource objectAtIndex:indexPath.row] ts24]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    NSString *state = @"";
    if (_selectItem == indexPath.item) {
        state = @"play";
    } else {
        state = @"pause";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"good" object:state];
  _selectItem = indexPath.row;
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
