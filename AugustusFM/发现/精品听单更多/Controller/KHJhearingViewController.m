//
//  KHJhearingViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJhearingViewController.h"
#import "KHJNetTool.h"
#import "KHJheaderView.h"
#import "KHJhearingTableViewCell.h"
#import "KHJhearingModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "KHJPlayerMusiciViewController.h"
@interface KHJhearingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
//头视图
@property (nonatomic, retain) KHJheaderView *headerView;
//头视图字典
@property (nonatomic, retain) NSDictionary *headDic;


//数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, retain) MBProgressHUD *mbView;
@end

@implementation KHJhearingViewController
- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"听单详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didclickBar)];
    self.dataSource  =[NSMutableArray array];
    //头视图字典
    self.headDic = [NSDictionary dictionary];
    
    [self getData];
    [self createHeaderView];
}
- (void)didclickBar{
    [self.navigationController popViewControllerAnimated:YES];
}

//创建头视图
- (void)createHeaderView{
    self.headerView = [[KHJheaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight)];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    
    self.tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[KHJhearingTableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (void)getData{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_detail?device=android&id=%ld&statPosition=1",[_model.specialId  integerValue]];
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
         [KHJArchiverTools archiverObject:dic ByKey:@"detail" WithPath:@"detail.plist"];
        self.headDic= [dic objectForKey:@"info"];
       self.headerView.ditionary = self.headDic;
        
        NSArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listarray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
        }
        //模拟移除
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.mbView hide:YES];
            });
        [self.tableView reloadData];
    } failure:^(NSError *error) {
     NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"detail" WithPath:@"detail.plist"];
        self.headDic= [dic objectForKey:@"info"];
        self.headerView.ditionary = self.headDic;
        
        NSArray *listarray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listarray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
        }
        
        [self.tableView reloadData];
        
    }];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJhearingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJPlayerMusiciViewController *kpvc = [KHJPlayerMusiciViewController shareDetailViewController];
    kpvc.musicArr = self.dataSource;
    kpvc.model = [self.dataSource objectAtIndex:indexPath.item];
    kpvc.index = indexPath.item;
    [self presentViewController:kpvc animated:YES completion:nil];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[self.dataSource objectAtIndex:indexPath.row] coverSmall]];
    
    //        userInfo[@"musicURL"] = [NSURL URLWithString:[[self.programArray objectAtIndex:indexPath.row] playUrl64]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    
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
