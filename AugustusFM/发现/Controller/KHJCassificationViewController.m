//
//  KHJCassificationViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJCassificationViewController.h"
#import "KHJNetTool.h"
#import <UIImageView+WebCache.h>
//分类Model
#import "KHJClassificationModel.h"
//分类cell
#import "KHJClassificationTableViewCell.h"
#import "KHJBigPayModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJCassificationViewController ()<UITableViewDelegate,UITableViewDataSource>
//创建tableView
@property (nonatomic, retain) UITableView *tableView;
//创建头视图图片
@property (nonatomic, retain) UIImageView *headerImageView;
//数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJCassificationViewController
- (void)dealloc{
    [_tableView release];
    [_headerImageView release];
    [_dataSource release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.dataSource = [NSMutableArray array];
    [self getData];
    [self createSubView];
}
- (void)createSubView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.headerImageView = [[UIImageView alloc] initWithFrame:headerView.frame];
    [headerView addSubview:_headerImageView];
    [_headerImageView release];
    [self.view addSubview:_tableView];
    
        
    //注册cell
    [self.tableView registerClass:[KHJClassificationTableViewCell class] forCellReuseIdentifier:@"classCell"];
    
    
    [_tableView jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        
    }];
    
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
    view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        
    }];

    
    
    }
#pragma mark -- 请求数据
- (void)getData{
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v1/categories?channel=and-f3&device=android&picVersion=13&scale=2";
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"scale" WithPath:@"scale.plist"];
        //头视图数据
        NSArray *array = [dic objectForKey:@"list"];
        NSDictionary *diction = [array objectAtIndex:0];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[diction objectForKey:@"coverPath"]]];
        //其他数据
        NSMutableArray *array1 = [NSMutableArray arrayWithArray:array];
        if (array1.count) {
            [array1 removeObjectAtIndex:0];

        }
                for (NSDictionary *dict in array1) {
            KHJBigPayModel *model = [[KHJBigPayModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
           
        }
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
        });
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"scale" WithPath:@"scale.plist"];
        //头视图数据
        NSArray *array = [dic objectForKey:@"list"];
        NSDictionary *diction = [array objectAtIndex:0];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[diction objectForKey:@"coverPath"]] placeholderImage:[UIImage imageNamed:@"no_network"]];
        //其他数据
        NSMutableArray *array1 = [NSMutableArray arrayWithArray:array];
        if (array1.count) {
            [array1 removeObjectAtIndex:0];
        }
        for (NSDictionary *dict in array1) {
            KHJBigPayModel *model = [[KHJBigPayModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
            
        }
        [self.tableView reloadData];
        
    }];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190 * lFitHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classCell"];
    void (^blod)(KHJNovelDetailViewController *) = ^(KHJNovelDetailViewController *vcController){
        [self.navigationController pushViewController:vcController animated:YES];
    };
    cell.block = blod;
    cell.array = self.dataSource ;
    cell.number = indexPath.row;
    return cell;
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
