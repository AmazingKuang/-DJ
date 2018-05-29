//
//  KHJListViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJListViewController.h"
#import "KHJNetTool.h"
#import <UIImageView+WebCache.h>
#import "KHJListViewTableViewCell.h"
#import "KHJListViewModel.h"
//主播榜单
#import "KHJAnchorListViewController.h"
//节目榜单
#import "KHJProgramListViewController.h"
#import "KHJDetailRecommend.h"
#import "KHJArchiverTools.h"
#import "KHJ360ViewController.h"
@interface KHJListViewController ()<UITableViewDelegate,UITableViewDataSource>
//定义tableView视图
@property (nonatomic, retain) UITableView *tableView;
//定义头视图图片
@property (nonatomic, retain) UIImageView *headerImageView;
//节目榜单数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;
//主播榜单数据数组
@property (nonatomic, retain) NSMutableArray *rankArray;


@end

@implementation KHJListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    //节目榜单数据源数组
    self.dataSource = [NSMutableArray array];
    //主播榜单数据数组
    self.rankArray = [NSMutableArray array];
    [self getData];
    [self getHeaderData];
    [self createSubView];
}

- (void)createSubView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight)];
    self.headerImageView = [[UIImageView alloc] initWithFrame:headerView.frame];
    _headerImageView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:_headerImageView];
    _headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedTap:)];
    [_headerImageView addGestureRecognizer:tap];
    
    
    
    [_headerImageView release];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[KHJListViewTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
}
#pragma mark -- 头视图点击方法
- (void)didClickedTap:(UITapGestureRecognizer *)tap{
    KHJ360ViewController *vc = [[KHJ360ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 头视图数据
- (void)getHeaderData{
    NSString *string = @"http://baobab.wandoujia.com/api/v3/discovery?udid=de4404bbd7aa4065ae2bc5730c00a359701aadec&vc=126&vn=2.4.1&deviceModel=x600&first_channel=eyepetizer_360_market&last_channel=eyepetizer_360_market&system_version_code=21";
    
      [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON
      success:^(id result) {
          NSDictionary *dic = (NSDictionary *)result;
          NSArray *listArray = [dic objectForKey:@"itemList"];
          NSDictionary *dict = [listArray objectAtIndex:3];
          NSDictionary *dataDic = [dict objectForKey:@"data"];
          [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"image"]]];
          [self.tableView reloadData];
      
      } failure:^(NSError *error) {
     
       }];
    
    
}




#pragma mark -- 请求数据
- (void)getData{
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=and-a1&device=android&includeActivity=true&includeSpecial=true&scale=2&version=5.4.9";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        //头视图数据
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"group" WithPath:@"group.plist"];
//        NSDictionary *diction = [dic objectForKey:@"focusImages"];
//        NSArray *array = [diction objectForKey:@"list"];
//        NSDictionary *dict = [array objectAtIndex:0];
//        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"pic"]]];
        //分区的数据
        NSArray *dataArray = [dic objectForKey:@"datas"];
        NSDictionary *dicti = [dataArray objectAtIndex:0];
        NSArray *listArray = [dicti objectForKey:@"list"];
        for (NSDictionary *dictionary in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dictionary];
            [self.dataSource addObject:model];
           
        }
        NSDictionary *rankdic = [dataArray objectAtIndex:1];
        NSArray *ranklistArray = [rankdic objectForKey:@"list"];
        for (NSDictionary *ranklistDic in ranklistArray) {
             KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:ranklistDic];
            [self.rankArray addObject:model];
        }

//         NSLog(@"%ld",self.dataSource.count);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"group" WithPath:@"group.plist"];
        NSDictionary *diction = [dic objectForKey:@"focusImages"];
        NSArray *array = [diction objectForKey:@"list"];
        NSDictionary *dict = [array objectAtIndex:0];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"pic"]]];
        //分区的数据
        NSArray *dataArray = [dic objectForKey:@"datas"];
        NSDictionary *dicti = [dataArray objectAtIndex:0];
        NSArray *listArray = [dicti objectForKey:@"list"];
        for (NSDictionary *dictionary in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dictionary];
            [self.dataSource addObject:model];
            
        }
        NSDictionary *rankdic = [dataArray objectAtIndex:1];
        NSArray *ranklistArray = [rankdic objectForKey:@"list"];
        for (NSDictionary *ranklistDic in ranklistArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:ranklistDic];
            [self.rankArray addObject:model];
        }
    [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }
    return self.rankArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     KHJListViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.model = [self.dataSource objectAtIndex:indexPath.row];
        return cell;
    }
    cell.model = [self.rankArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30 * lFitHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30 * lFitHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 * lFitWidth, 12 * lFitHeight, 10 * lFitWidth, 15 * lFitHeight)];
    imageView.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [headerView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 20 * lFitHeight)];
    label.font = [UIFont systemFontOfSize:17 * lFitWidth];
    [headerView addSubview:label];
    if (section == 0) {
          label.text = @"节目榜单";
    }
    if (section == 1) {
        label.text = @"主播榜单";
    }
    return headerView;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        KHJAnchorListViewController *khvc = [[KHJAnchorListViewController alloc] init];
        khvc.model = [self.rankArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:khvc animated:YES];
    }
    if (indexPath.section == 0) {
        KHJProgramListViewController *kpvc = [[KHJProgramListViewController alloc] init];
        kpvc.model = [self.dataSource objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:kpvc animated:YES];
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
