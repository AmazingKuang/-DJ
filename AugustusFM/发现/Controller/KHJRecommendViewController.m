//
//  KHJRecommendViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJRecommendViewController.h"
//轮播图
#import "SDCycleScrollView.h"
#import "KHJNetTool.h"
//中间数据的cell
#import "KHJMiddleCollectionViewCell.h"
//中间数据的model
#import "KHJMiddleModel.h"
//小编推荐
#import "KHJRecommendCell.h"
//小编推荐Model
#import "KHJBigRecommengModel.h"
//精品听单
#import "KHJHearListTableViewCell.h"
//精品听单Model
#import "KHJHearListModel.h"
//推广的Cell
#import "KHJSpreadTableViewCell.h"
//推广的model
#import "KHJSpreadModel.h"
//付费精品.听娱乐,听资讯
#import "KHJBigPayTableViewCell.h"

//推出小编推荐的vc
#import "KHJDetailRecommenendViewController.h"
//推出精品听单
#import "KHJDetailListenListViewController.h"
//听资讯详情
#import "KHJspecialDetailViewController.h"
//听资讯
#import "KHJDetailRecommend.h"
//精品听单
#import "KHJDetailListenModel.h"

#import "KHJhearingViewController.h"
//听小说.听资讯 详情
#import "KHJNovelDetailViewController.h"
//今日最火
#import "KHJProgramListViewController.h"
#import "KHJIDModel.h"
#import "KHJListViewModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJRecommendViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
//主界面的tableView
@property (nonatomic, retain) UITableView *tableView;
//轮播图
@property (nonatomic,retain)SDCycleScrollView *scrollView;
@property (nonatomic, retain) UIView *headerView;
//轮播图数据
@property (nonatomic, retain) NSMutableArray *circulationArray;
//中间的collectionView(听资讯.今日最火...)
@property (nonatomic, retain) UICollectionView *collectionView;
//中间collectionView(听资讯.今日最火...)数组
@property (nonatomic, retain) NSMutableArray *middleArray;
//小编推荐的数据源数组
@property (nonatomic, retain) NSMutableArray *recommengdataSource;
//精品听单数据源
@property (nonatomic, retain) NSMutableArray *headListArray;
//推广的数据源
@property (nonatomic, retain) NSMutableArray *spreadArray;
////付费精品.听娱乐,听资讯数据源
@property (nonatomic, retain) NSMutableArray *payArray;
//付费精品.听娱乐,听资讯标题数组]
@property (nonatomic, retain) NSMutableArray *titleArray;
//..中间听资讯详情
@property (nonatomic, retain) NSMutableArray *tingArray;


@property (nonatomic, retain) NSMutableArray *idArray;

@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJRecommendViewController
- (void)dealloc{
    [_tableView release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [_scrollView release];
    [_headerView release];
    [_circulationArray release];
    [_collectionView release];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [_middleArray release];
    [_recommengdataSource release];
    [_headListArray release];
    [_spreadArray release];
    [_payArray release];
    [_titleArray release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:NO];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    中间collectionView(听资讯.今日最火...)数组
    self.middleArray = [NSMutableArray array];
    //轮播图数据
    self.circulationArray = [NSMutableArray array];
    //小编推荐
    self.recommengdataSource = [NSMutableArray array];
    //精品听单
    self.headListArray = [NSMutableArray array];
    //推广
    self.spreadArray = [NSMutableArray array];
    ////付费精品.听娱乐,听资讯数据源
    self.payArray = [NSMutableArray array];
    
    self.idArray = [NSMutableArray array];
    self.tingArray = [NSMutableArray array];
    [self createTableView];
    [self getData];
    //推广的数据
    [self getSpreadData];
    ////付费精品.听娱乐,听资讯数据源
    self.titleArray = [NSMutableArray array];
    [self getinfrmationData];
}
- (void)createTableView{
    //创建整个的tableView
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.bounces = NO;
//    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   //创建头视图
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300 * lFitHeight )];
//    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    //创建轮播图
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight) delegate:self placeholderImage:[UIImage imageNamed:@"no_network"]];
    [self.headerView addSubview:_scrollView];
    [_scrollView release];
    [self.view addSubview:_tableView];
    [_tableView release];
    //创建中间的collectionView视图
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((ScreenWidth - 85 * lFitWidth) / 4, 85 * lFitHeight );
    flowLayout.minimumLineSpacing = 17 * lFitHeight;
    flowLayout.minimumInteritemSpacing = 17 * lFitWidth;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(17 * lFitHeight, 17 * lFitWidth, 17 * lFitHeight, 17 * lFitWidth);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200 * lFitHeight, ScreenWidth, 110 * lFitHeight) collectionViewLayout:flowLayout];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.headerView addSubview:_collectionView];
    [_collectionView release];
    //注册cell
    [self.collectionView registerClass:[KHJMiddleCollectionViewCell class] forCellWithReuseIdentifier:@"middleCell"];
    //注册小编推荐的Cell
    [self.tableView registerClass:[KHJRecommendCell class] forCellReuseIdentifier:@"RecommendCell"];
    //注册精品听单cell
    [self.tableView registerClass:[KHJHearListTableViewCell class] forCellReuseIdentifier:@"hearCell"];
    //推广的cell
    [self.tableView registerClass:[KHJSpreadTableViewCell class] forCellReuseIdentifier:@"spreadCell"];
    //付费精品.听资讯 ,听娱乐cell
    [self.tableView registerClass:[KHJBigPayTableViewCell class] forCellReuseIdentifier:@"payCell"];
    
    
    /**
     夜间模式
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        _scrollView.backgroundColor = [UIColor whiteColor];
        _headerView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        _scrollView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        _collectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _headerView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        
    }];

    
    
}
#pragma mark -- 轮播图,今日资讯,小编推荐,精品听单的数据
- (void)getData{
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v3/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=4.3.86";
    //菊花加载
//    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        /**
         *  归档
         */
        [KHJArchiverTools archiverObject:dic ByKey:@"good" WithPath:@"good.plist"];
        
        
        //轮播图
        NSDictionary *dict = [dic objectForKey:@"focusImages"];
        NSArray *array = [dict objectForKey:@"list"];
        for (NSDictionary *dictionary in array) {
            [self.circulationArray addObject:[dictionary objectForKey:@"pic"]];
        }
//        [self.circulationArray removeObjectAtIndex:0];
            //小编推荐的数据
        NSDictionary *recommenddic = [dic objectForKey:@"editorRecommendAlbums"];
        NSMutableArray *listiarray = [recommenddic objectForKey:@"list"];
        for (NSDictionary *listddic in listiarray) {
            KHJDetailRecommend *bigModel = [[KHJDetailRecommend alloc] initWithDic:listddic];
            [self.recommengdataSource addObject:bigModel];
        }
        //听资讯.今日最火中间的数据
        NSDictionary *dicti = [dic objectForKey:@"discoveryColumns"];
        NSMutableArray *listArray = [dicti objectForKey:@"list"];
        
        NSDictionary *dict1 = [listArray objectAtIndex:0];
        NSDictionary *dict2 = [listArray objectAtIndex:1];
        NSDictionary *dict3 = [listArray objectAtIndex:2];
//        NSDictionary *dict4 = [listArray objectAtIndex:5];
        NSMutableArray *listarray = [NSMutableArray array];
        [listarray addObject:dict1];
        [listarray addObject:dict2];
        [listarray addObject:dict3];
//        [listarray addObject:dict4];
        for (NSDictionary *dict5 in listarray) {
            KHJDetailRecommend *modeled = [[KHJDetailRecommend alloc] initWithDic:dict5];
            [self.tingArray addObject:modeled];
        }
       //精品听单
        NSDictionary *hearDic = [dic objectForKey:@"specialColumn"];
        NSArray *hearArray = [hearDic objectForKey:@"list"];
        for (NSDictionary *hearlistDic in hearArray) {
            KHJDetailListenModel *model = [[KHJDetailListenModel alloc] initWithDic:hearlistDic];
            [self.headListArray addObject:model];
        }
        
        
        self.scrollView.imageURLStringsGroup = self.circulationArray;
               [self.collectionView reloadData];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"good" WithPath:@"good.plist"];
        //轮播图
        NSDictionary *dict = [dic objectForKey:@"focusImages"];
        NSArray *array = [dict objectForKey:@"list"];
        for (NSDictionary *dictionary in array) {
            [self.circulationArray addObject:[dictionary objectForKey:@"pic"]];
        }
//        [self.circulationArray removeObjectAtIndex:0];
        //小编推荐的数据
        NSDictionary *recommenddic = [dic objectForKey:@"editorRecommendAlbums"];
        NSMutableArray *listiarray = [recommenddic objectForKey:@"list"];
        for (NSDictionary *listddic in listiarray) {
            KHJDetailRecommend *bigModel = [[KHJDetailRecommend alloc] initWithDic:listddic];
            [self.recommengdataSource addObject:bigModel];
        }
        //听资讯.今日最火中间的数据
        NSDictionary *dicti = [dic objectForKey:@"discoveryColumns"];
        NSMutableArray *listArray = [dicti objectForKey:@"list"];
        if (listArray.count != 0) {
        NSDictionary *dict1 = [listArray objectAtIndex:0];
        NSDictionary *dict2 = [listArray objectAtIndex:1];
        NSDictionary *dict3 = [listArray objectAtIndex:2];
        NSDictionary *dict4 = [listArray objectAtIndex:5];
        NSMutableArray *listarray = [NSMutableArray array];
        [listarray addObject:dict1];
        [listarray addObject:dict2];
        [listarray addObject:dict3];
        [listarray addObject:dict4];
                for (NSDictionary *dict5 in listarray) {
            KHJDetailRecommend *modeled = [[KHJDetailRecommend alloc] initWithDic:dict5];
            [self.tingArray addObject:modeled];
        }
        }
        //精品听单
        NSDictionary *hearDic = [dic objectForKey:@"specialColumn"];
        NSArray *hearArray = [hearDic objectForKey:@"list"];
        for (NSDictionary *hearlistDic in hearArray) {
            KHJDetailListenModel *model = [[KHJDetailListenModel alloc] initWithDic:hearlistDic];
            [self.headListArray addObject:model];
        }
        
        
//        self.scrollView.imageURLStringsGroup = self.circulationArray;
        [self.collectionView reloadData];
        [self.tableView reloadData];
    }];
    
}
#pragma mark -- 推广的数据
- (void)getSpreadData{
    NSString *string = @"http://adse.ximalaya.com/ting/feed?device=android&name=find_native&network=WIFI&operator=0&version=5.4.9";
    //菊花加载
//    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"headd" WithPath:@"headd.plist"];
        NSArray *array = [dic objectForKey:@"data"];
        for (NSDictionary *diction in array) {
            KHJSpreadModel *model = [[KHJSpreadModel alloc] initWithDic:diction];
            [self.spreadArray addObject:model];
        }
        [self.tableView reloadData];
        //模拟移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
//        });
//
        
    } failure:^(NSError *error) {
     NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"headd" WithPath:@"headd.plist"];
        NSArray *array = [dic objectForKey:@"data"];
        for (NSDictionary *diction in array) {
            KHJSpreadModel *model = [[KHJSpreadModel alloc] initWithDic:diction];
            [self.spreadArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark -- 付费精品,听资讯,听小说
- (void)getinfrmationData{
    NSString *string = @"http://mobile.ximalaya.com/mobile/discovery/v1/recommend/hotAndGuess?device=android";
    //菊花加载
//    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"foot" WithPath:@"foot.plist"];
        NSDictionary *dict = [dic objectForKey:@"hotRecommends"];
        NSArray *array = [dict objectForKey:@"list"];
        for (NSDictionary *diction in array) {
            KHJBigPayModel *model = [[KHJBigPayModel alloc] initWithDic:diction];
            [self.payArray addObject:model];
//                    
        }
        
        [self.tableView reloadData];
        //模拟移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
//        });
    } failure:^(NSError *error) {
      NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"foot" WithPath:@"foot.plist"];
        NSDictionary *dict = [dic objectForKey:@"hotRecommends"];
        NSArray *array = [dict objectForKey:@"list"];
        for (NSDictionary *diction in array) {
            KHJBigPayModel *model = [[KHJBigPayModel alloc] initWithDic:diction];
            [self.payArray addObject:model];
            //
        }
        [self.tableView reloadData];
    }];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tingArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJMiddleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"middleCell" forIndexPath:indexPath];
    cell.model = [self.tingArray objectAtIndex:indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{ 
    if (indexPath.row == 0) {
        KHJspecialDetailViewController *khuj = [[KHJspecialDetailViewController alloc] init];
        khuj.model = [self.tingArray objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:khuj animated:YES];
    }
    if (indexPath.row == 1) {
        KHJProgramListViewController *kvc= [[KHJProgramListViewController alloc] init];
        kvc.model = [self.tingArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:kvc animated:YES];
    }
    if (indexPath.row == 2) {
        KHJProgramListViewController *kvcd= [[KHJProgramListViewController alloc] init];
        kvcd.model = [self.tingArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:kvcd animated:YES];

    }
    if (indexPath.row == 3) {
        KHJProgramListViewController *kvcdd= [[KHJProgramListViewController alloc] init];
        kvcdd.model = [self.tingArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:kvcdd animated:YES];
        
    }

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
       return 40 * lFitHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 * lFitHeight)];
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10 * lFitHeight)];
//    grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    [headerView addSubview:grayView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 * lFitWidth, 15 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight)];
    imageView.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [headerView addSubview:imageView];
    [imageView release];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 * lFitWidth, 10 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight)];
    label.font = [UIFont systemFontOfSize:15 * lFitHeight];
        [headerView addSubview:label];
    [label release];
    
    UILabel *moreLable = [[UILabel alloc] initWithFrame:CGRectMake(330 * lFitWidth, 10 * lFitHeight, 40 * lFitWidth, 20 * lFitHeight)];
    moreLable.text = @"更多";
    moreLable.font = [UIFont systemFontOfSize:15 * lFitHeight];
    [headerView addSubview:moreLable];
    [moreLable release];
    UIImageView *turnImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(385 * lFitWidth, 15 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight)];
    turnImageVIew.image = [[UIImage imageNamed:@"np_loverview_arraw"] imageWithRenderingMode:1];
    [headerView addSubview:turnImageVIew];
    [turnImageVIew release];
    [tableView jxl_setDayMode:^(UIView *view) {
        tableView.backgroundColor = [UIColor whiteColor];
//        // 设置日间模式状态
        grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        headerView.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        moreLable.backgroundColor = [UIColor whiteColor];
        moreLable.textColor = [UIColor blackColor];
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        headerView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        label.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        label.textColor = [UIColor whiteColor];
        moreLable.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        moreLable.textColor = [UIColor whiteColor];
        tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

    
    if (section == 0) {
        label.text = @"小编推荐";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
        [headerView addGestureRecognizer:tap];
        

    } else if (section == 1) {
        label.text = @"精品听单";
        UITapGestureRecognizer *listTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedList:)];
        [headerView addGestureRecognizer:listTap];
//    } else if (section == 2) {
////        label.text = @"推广";
    } else if (self.payArray.count != 0) {
        KHJBigPayModel *model = [self.payArray objectAtIndex:section  - 2];
        label.text = model.title;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 10 * lFitHeight, ScreenWidth, 30 * lFitHeight);
        button.alpha = 0.1;
//        button.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:button];
        button.tag = 50000 + section;
        [button addTarget:self action:@selector(didClickmessage:) forControlEvents:UIControlEventTouchUpInside];
       
    }
        return headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.payArray.count + 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.headListArray.count;
    }
//    if (section == 2) {
//        return self.spreadArray.count;
//    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //小编推荐
    if (indexPath.section == 0) {
        KHJRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCell"];
        void (^blck)(KHJspecialDetailViewController *) = ^(KHJspecialDetailViewController *svc){
            [self.navigationController pushViewController:svc animated:YES];
        };
        cell.block = blck;
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataSource = self.recommengdataSource;
        return cell;
 
    }
    
    //精品听单
    if (indexPath.section == 1) {
        KHJHearListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hearCell"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.headListArray objectAtIndex:indexPath.row];
        return cell;
    }
//    //推广
//    if (indexPath.section == 2) {
//        KHJSpreadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spreadCell"];
//         cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.model = [self.spreadArray objectAtIndex:indexPath.row];
//        return cell;
//
//    }
    KHJBigPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payCell"];
    
    void (^blod) (KHJspecialDetailViewController *) = ^(KHJspecialDetailViewController *vcController){
        [self.navigationController pushViewController:vcController animated:YES];
    };
    cell.block = blod;
    
    if (self.payArray.count != 0) {
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.payArray objectAtIndex:indexPath.section - 2];
    }
    return cell;
    
    
  }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 190 * lFitHeight;
    }
    if (indexPath.section == 1) {
        return 80 * lFitHeight;
    }
    return 180 * lFitHeight;
    
}
#pragma mark -- 小编推荐点击方法
- (void)gesture:(UITapGestureRecognizer *)tap{
    KHJDetailRecommenendViewController *dvc = [[KHJDetailRecommenendViewController alloc] init];
    [self.navigationController pushViewController:dvc animated:YES];
}
#pragma mark -- 精品听单点击方法
- (void)didClickedList:(UITapGestureRecognizer *)listTap{
    KHJDetailListenListViewController *kdvc = [[KHJDetailListenListViewController alloc] init];
    [self.navigationController pushViewController:kdvc animated:YES];
}

#pragma mark -- 听资讯,听小说
- (void)didClickmessage:(UIButton *)messageTap{
    KHJNovelDetailViewController *kdvc = [[KHJNovelDetailViewController alloc] init];
    
    NSInteger index = messageTap.tag - 50000;
    if (self.payArray.count != 0) {
        KHJBigPayModel *payModel = self.payArray[index - 2];
         kdvc.model = payModel;
}
    
    
    [self.navigationController pushViewController:kdvc animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        KHJhearingViewController *khj = [[KHJhearingViewController alloc] init];
        khj.model = [self.headListArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:khj animated:YES];
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
