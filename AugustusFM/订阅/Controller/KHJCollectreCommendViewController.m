//
//  KHJCollectreCommendViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJCollectreCommendViewController.h"
#import "KHJDetailRecommend.h"
#import "KHJDeTailRecommendTableViewCell.h"
#import "KHJNetTool.h"
#import "KHJspecialDetailViewController.h"
#import  <MJRefresh.h>
@interface KHJCollectreCommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger pNumber;
@end

@implementation KHJCollectreCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    [self createTableView];
    [self getData:1];
    self.pNumber = 1;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[KHJDeTailRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getOneData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didClickBUttonBarItem)];
    
}
- (void)didClickBUttonBarItem{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -- 下拉刷新
- (void)getOneData{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    [self getData:1];
    
}
#pragma mark -- 上拉加载
- (void)getMoreData{
    _pNumber++;
    [self getData:_pNumber];
}
- (void)getData:(NSInteger)page{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/feed/v1/recommend/classic/unlogin?device=android&pageId=%ld&pageSize=20",page];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSArray *listArray = [dataDic objectForKey:@"list"];
        for (NSDictionary *dict in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dict];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90 * lFitHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDeTailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJspecialDetailViewController *kvc = [[KHJspecialDetailViewController alloc] init];
    kvc.model = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:kvc animated:YES];
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
