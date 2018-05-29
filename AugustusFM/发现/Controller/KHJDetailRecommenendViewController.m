//
//  KHJDetailRecommenendViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDetailRecommenendViewController.h"
#import "KHJDeTailRecommendTableViewCell.h"
#import "KHJNetTool.h"
#import "KHJDetailRecommend.h"
#import "KHJspecialDetailViewController.h"
#import <MJRefresh.h>
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
@interface KHJDetailRecommenendViewController ()<UITableViewDelegate,UITableViewDataSource>
//tableView视图
@property (nonatomic, retain) UITableView *tableView;
//数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;
//页码
@property (nonatomic, assign) NSInteger pNumber;

@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJDetailRecommenendViewController
- (void)dealloc{
    [_tableView release];
    [_dataSource release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pNumber = 1;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButton:)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"小编推荐";
    self.dataSource = [NSMutableArray array];
    [self getData:1];
    [self createtableView];
}
- (void)didClickedBarButton:(UIBarButtonItem *)barButtonItem{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createtableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView release];
    //下拉刷新
    //设置回调(一旦进入刷新状态,就调用target的action.也就是调用self的getdata方法)
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%ld",(long)i]];
        [array addObject:image];
    }
    NSMutableArray *finishArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 3; i++) {
        UIImage *finishImage = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%ld",(long)i]];
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
    //注册cell
    [self.tableView registerClass:[KHJDeTailRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
//下拉刷新
- (void)getData{
    //清空数组
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    //请求数据
    [self getData:1];
}
#pragma mark -- 上拉加载
- (void)getMoreData{
    _pNumber++;//页码加1
    //请求数据
    [self getData:_pNumber];

}




#pragma mark -- 请求数据
- (void)getData:(NSInteger)pageNumber{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/recommend/editor?device=android&pageId=%ld&pageSize=20",pageNumber];
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"page" WithPath:@"page.plist"];
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dict];
            [self.dataSource addObject:model];
            [model release];
        }
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mbView hide:YES];
        });

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"page" WithPath:@"page.plist"];
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dict];
            [self.dataSource addObject:model];
            [model release];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDeTailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KHJspecialDetailViewController *kdvc = [[KHJspecialDetailViewController alloc] init];
    kdvc.model = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:kdvc animated:YES];
    [kdvc release];
    
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSArray *array = [self.tableView visibleCells];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj cellOffset];
//    }];
//}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
