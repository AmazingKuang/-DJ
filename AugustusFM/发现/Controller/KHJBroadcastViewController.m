//
//  KHJBroadcastViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBroadcastViewController.h"
//本地台之类的cell
#import "KHJLocalCollectionViewCell.h"
//新闻台之类的cell
#import "KHJListCollectionViewCell.h"
//午安大连的cell
#import "KHJDalianTableViewCell.h"
//本地台的点击方法
#import "KHJCapitalBroadcastViewController.h"
//国家台
#import "KHJCountryBroadcastViewController.h"
//省市台
#import "KHJProvinceBroadcastViewController.h"
//网络台
#import "KHJNetWorkViewController.h"
//新闻台.音乐台之类的
#import "KHJnewsBroadcastViewController.h"
//大连更多
#import "KHJmoreDalianViewController.h"
//排行榜的
#import "KHJmoreRankViewController.h"

#import "KHJNetTool.h"
#import "KHJDalianModel.h"
#import "KHJTopDownBaseModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJBroadcastViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
//建立tableView视图
@property (nonatomic, retain) UITableView *tableView;
//collectionView视图
@property (nonatomic, retain) UICollectionView *collectionView;
//listView
@property (nonatomic, retain) UICollectionView *listCollectionView;
//tableView的头视图
@property (nonatomic, retain) UIView *headerView;

@property (nonatomic, retain) NSMutableArray *topImageArray;

@property (nonatomic, retain) NSMutableArray *topTitleArray;
//tableView的数组
@property (nonatomic, retain) NSMutableArray *dalianArray;

//排行榜的数据
@property (nonatomic, retain) NSMutableArray *listArray;
//大连更多的数据
@property (nonatomic, retain) NSMutableArray *DalianmoreArray;
//排行榜更多数据
@property (nonatomic, retain) NSMutableArray *rankMoreArray;

@property (nonatomic, assign) BOOL click;

//新闻台..音乐台的数组
@property (nonatomic, retain) NSMutableArray *upArray;
//
@property (nonatomic, retain) NSMutableArray *downArray;
//监听事件
@property (nonatomic, retain) NSIndexPath *selectItem;

@end

@implementation KHJBroadcastViewController
- (void)dealloc{
    [_tableView release];
    [_collectionView release];
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    [_topImageArray release];
    [_topTitleArray release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //头条image
    self.topImageArray = [NSMutableArray array];
    //头条title
    self.topTitleArray = [NSMutableArray array];
    //大连w的数组初始化
    self.dalianArray = [NSMutableArray array];
    //排行榜的数据初始化
    self.listArray = [NSMutableArray array];
    //大连更多的数据
    self.DalianmoreArray = [NSMutableArray array];
    //新闻台数组
    self.upArray = [NSMutableArray array];
    self.downArray = [NSMutableArray array];
    //排行榜更多数据
    self.rankMoreArray = [NSMutableArray array];
    // 大连更多的数据
    [self getmoredata];
    //排行榜更多数据
    [self getmoreRankData];
  

    [self getTopData];
    [self getDalianData];
    [self createSubView];
    [self createlistCollectionView];
    /**
     夜间模式
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        _collectionView.backgroundColor = [UIColor whiteColor];
        _listCollectionView.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _headerView.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        _headerView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        // 设置夜间模式状态
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        _collectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _listCollectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
 
    }];

   
}
- (void)getTopData{
    self.topImageArray = [NSMutableArray arrayWithObjects:@"icon_radio_local",@"icon_radio_country",@"icon_radio_province",@"icon_radio_internet", nil];
    self.topTitleArray = [NSMutableArray arrayWithObjects:@"本地台",@"国家台",@"省市台",@"网络台", nil];
}

#pragma mark -- 大连..排行榜的数据
- (void)getDalianData{

    NSString *string = @"http://live.ximalaya.com/live-web/v4/homepage";
       [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"live" WithPath:@"live.plist"];
        NSDictionary *dicti = [dic objectForKey:@"data"];
        NSArray *array = [dicti objectForKey:@"localRadios"];
         //新闻台..之类的数据
        NSDictionary *updownarray = [dicti objectForKey:@"categories"];
        //空model
        KHJTopDownBaseModel *topDownmodel = [[KHJTopDownBaseModel alloc] init];
        for (NSDictionary *dictionary in updownarray) {
            KHJTopDownBaseModel *model = [[KHJTopDownBaseModel alloc] initWithDic:dictionary];
           
            [self.downArray addObject:model];
           
        }
        [self.downArray addObject:topDownmodel];
        for (NSInteger i = 0; i < 7; i++) {
            [self.upArray addObject:self.downArray[i]];
           
           
            
        }
         [self.upArray addObject:topDownmodel];
//         NSLog(@"----%ld",self.upArray.count);
        //大连的数据
        for (NSDictionary *dict in array) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:dict];
            [self.dalianArray addObject:model];
            
        }
        //排行榜的数据
        NSArray *listArray = [dicti objectForKey:@"topRadios"];
        for (NSDictionary *distion in listArray) {
             KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:distion];
            
            [self.listArray addObject:model];
        }
        [self.listCollectionView reloadData];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
     NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"live" WithPath:@"live.plist"];
        if (dic.count != 0) {
        NSDictionary *dicti = [dic objectForKey:@"data"];
        NSArray *array = [dicti objectForKey:@"localRadios"];
        //新闻台..之类的数据
        NSDictionary *updownarray = [dicti objectForKey:@"categories"];
        //空model
        KHJTopDownBaseModel *topDownmodel = [[KHJTopDownBaseModel alloc] init];
        for (NSDictionary *dictionary in updownarray) {
            KHJTopDownBaseModel *model = [[KHJTopDownBaseModel alloc] initWithDic:dictionary];
            
            [self.downArray addObject:model];
            
        }
        [self.downArray addObject:topDownmodel];
        for (NSInteger i = 0; i < 7; i++) {
                [self.upArray addObject:self.downArray[i]];
            }
        [self.upArray addObject:topDownmodel];
        //大连的数据
        for (NSDictionary *dict in array) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:dict];
            [self.dalianArray addObject:model];
            
        }
        //排行榜的数据
        NSArray *listArray = [dicti objectForKey:@"topRadios"];
        for (NSDictionary *distion in listArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:distion];
            
            [self.listArray addObject:model];
        }
    }
        [self.listCollectionView reloadData];
        [self.tableView reloadData];
        
    }];
    
}

#pragma mark -- 大连更多的数据
- (void)getmoredata{
    NSString *string = @"http://live.ximalaya.com/live-web/v1/radio/local?pageNum=1&pageSize=20";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"web" WithPath:@"web.plist"];
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSArray *dataArray = [dict objectForKey:@"data"];
        for (NSDictionary *diction in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:diction];
            [self.DalianmoreArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"web" WithPath:@"web.plist"];
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSArray *dataArray = [dict objectForKey:@"data"];
        for (NSDictionary *diction in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:diction];
            [self.DalianmoreArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark --- 排行榜的数据
- (void)getmoreRankData{
    NSString *string = @"http://live.ximalaya.com/live-web/v2/radio/hot?pageNum=1&pageSize=20";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"radio" WithPath:@"radio.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:dict];
            
            [self.rankMoreArray addObject:model];
                   }
      
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"radio" WithPath:@"radio.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:dict];
            
            [self.rankMoreArray addObject:model];
        }
        
        [self.tableView reloadData];
    }];
    
    
}

- (void)createSubView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //注册午安大连的 cell
    [self.tableView registerClass:[KHJDalianTableViewCell class] forCellReuseIdentifier:@"dalianCell"];
    
    self.headerView =[[UIView alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, 180 * lFitHeight)];
      self.tableView.tableHeaderView = _headerView;
    [_headerView release];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth / 4 - 20 * lFitWidth, 70  *lFitHeight);
    flowLayout.minimumLineSpacing = 5 * lFitHeight;
    flowLayout.minimumInteritemSpacing = 5 * lFitWidth;
    flowLayout.sectionInset = UIEdgeInsetsMake(5 * lFitHeight, 5 * lFitWidth, 5 * lFitHeight, 5 * lFitWidth);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80 * lFitHeight) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
  
    [self.headerView addSubview:_collectionView];
    [_collectionView release];
    //注册collectionView的Cell
    [self.collectionView registerClass:[KHJLocalCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
- (void)createlistCollectionView{
    UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
    flowOut.itemSize = CGSizeMake((ScreenWidth - 20 * lFitWidth) / 4, 40 * lFitHeight);
    flowOut.minimumLineSpacing = 1;
    flowOut.minimumInteritemSpacing = 1;
    flowOut.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    self.listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5 * lFitWidth, 90 * lFitHeight, ScreenWidth - 10 * lFitWidth, 85 * lFitHeight) collectionViewLayout:flowOut];
    self.listCollectionView.backgroundColor = [UIColor whiteColor];
    self.listCollectionView.delegate = self;
    self.listCollectionView.dataSource = self;
    [self.headerView addSubview:_listCollectionView];
    //注册listControllview
    [self.listCollectionView registerClass:[KHJListCollectionViewCell class] forCellWithReuseIdentifier:@"listCell"];
    
    
}
#pragma mark -- collectionView的点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        if (indexPath.item == 0) {
            KHJCapitalBroadcastViewController *kcbvc = [[KHJCapitalBroadcastViewController alloc] init];
            [self.navigationController pushViewController:kcbvc animated:YES];
        }
        if (indexPath.item == 1) {
            KHJCountryBroadcastViewController *kbvc = [[KHJCountryBroadcastViewController alloc] init];
            [self.navigationController pushViewController:kbvc animated:YES];
        }
        
        if (indexPath.item == 2) {
            KHJProvinceBroadcastViewController *kpvc= [[KHJProvinceBroadcastViewController alloc] init];
            [self.navigationController pushViewController:kpvc animated:YES];
        }
        if (indexPath.item == 3) {
            KHJNetWorkViewController *nvc = [[KHJNetWorkViewController alloc]init];
            
            [self.navigationController pushViewController:nvc animated:YES];
        }
       
        
    }
    
    
    
    if (collectionView == _listCollectionView) {
        if (_click == NO) {
            if (indexPath.item != 7) {
                KHJnewsBroadcastViewController *knvc = [[KHJnewsBroadcastViewController alloc] init];
                
                knvc.model = [self.upArray objectAtIndex:indexPath.item];
                [self.navigationController pushViewController:knvc animated:YES];
            }
            if (indexPath.item == 7) {
                self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 260 * lFitHeight);
                self.tableView.tableHeaderView = _headerView;
                self.listCollectionView.frame = CGRectMake(5 * lFitWidth, 90 * lFitHeight, ScreenWidth - 10 * lFitWidth, 170 * lFitHeight);
                self.click = YES;
            }
        }
        else {
            if (indexPath.item == 7) {
                self.click = YES;
            }
            if (indexPath.item != self.downArray.count - 1) {
                    KHJnewsBroadcastViewController *knvc = [[KHJnewsBroadcastViewController alloc] init];
                knvc.model = [self.downArray objectAtIndex:indexPath.item];
                    [self.navigationController pushViewController:knvc animated:YES];

            }
            if (indexPath.item == self.downArray.count - 1) {
            self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 180 * lFitHeight);

            self.tableView.tableHeaderView = _headerView;
                self.listCollectionView.frame = CGRectMake(5 * lFitWidth, 90 * lFitHeight, ScreenWidth - 10 * lFitWidth, 85 * lFitHeight);
                self.click = NO;
            }
            
        }
         [self.listCollectionView reloadData];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        return 4;
    }
    if (_click == NO) {
        return self.upArray.count;
        }
    else{
     return self.downArray.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _collectionView) {
        KHJLocalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.localimageView.image = [UIImage imageNamed:[self.topImageArray objectAtIndex:indexPath.row]];
        cell.locaLabel.text = [self.topTitleArray objectAtIndex:indexPath.row];
        return cell;
    }
    
    
    KHJListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    
    cell.imageView.hidden = YES;
    
    if (_click == NO) {
         cell.model = [self.upArray objectAtIndex:indexPath.item];
        
        if (indexPath.item == 7) {
            cell.imageView.hidden = NO;
            cell.imageView.image =[UIImage imageNamed:@"navidrop_arrow_down_h"];
        }
    }
    else{
        
        cell.model = [self.downArray objectAtIndex:indexPath.item];
       
        if (indexPath.item == self.downArray.count - 1) {
            cell.imageView.image =[UIImage imageNamed:@"navidrop_arrow_up_h"];
             cell.imageView.hidden = NO;
        }
        
    }
       cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    return cell;
    
}
#pragma mark -- tableView的协议方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95 * lFitHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30 * lFitHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20 * lFitHeight)];
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10 * lFitHeight)];
//    grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    [headerView addSubview:grayView];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 * lFitWidth, 15 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight)];
    imageView.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [headerView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 5 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 20 * lFitHeight)];
    label.font = [UIFont systemFontOfSize:14];
   
    [headerView addSubview:label];
    
    UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(350 * lFitWidth, 10 * lFitHeight, 30 * lFitWidth, 20 * lFitHeight)];
    moreLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    moreLabel.text = @"更多";
    moreLabel.alpha = 0.5;
    [headerView addSubview:moreLabel];
    
    [tableView jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        //        // 设置日间模式状态
        grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        headerView.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        moreLabel.backgroundColor = [UIColor whiteColor];
        moreLabel.textColor = [UIColor blackColor];
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        headerView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        grayView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        label.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        label.textColor = [UIColor whiteColor];
        moreLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        moreLabel.textColor = [UIColor whiteColor];
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

    
    
    UIImageView *turnImageView =[[ UIImageView alloc] initWithFrame:CGRectMake(moreLabel.frame.origin.x + moreLabel.frame.size.width + 5 * lFitWidth, 15 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight)];
    turnImageView.alpha = 0.5;
    turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
    [headerView addSubview:turnImageView];
    if (section == 0) {
        label.text = @"大连";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClicked:)];
        [headerView addGestureRecognizer:tap];
        
        
    }
    if (section == 1) {
        label.text = @"排行榜";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [headerView addGestureRecognizer:tap];
        

        
    }
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     KHJDalianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dalianCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (self.dalianArray.count != 0) {
            cell.model = [self.dalianArray objectAtIndex:indexPath.row];
        
        }
            }
    else{
        if (self.listArray.count != 0) {
             cell.model = [self.listArray objectAtIndex:indexPath.row];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        //显示当前播放行:
        if (_selectItem != indexPath) {
            [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectItem.row inSection:_selectItem.section]] soundImageView] setImage:[UIImage imageNamed:@"sound_playbtn"]];
        }
        [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] soundImageView] setImage:[UIImage imageNamed:@"cell_sound_pause_n"]];
          }
    if (indexPath.section == 1) {
    //显示当前播放行:
    if (_selectItem != indexPath) {
        [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectItem.row inSection:_selectItem.section]] soundImageView] setImage:[UIImage imageNamed:@"sound_playbtn"]];
    }
    [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] soundImageView] setImage:[UIImage imageNamed:@"cell_sound_pause_n"]];
   
        }
    //通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[self.listArray objectAtIndex:indexPath.row] coverSmall]];
    userInfo[@"musicURL"] = [NSURL URLWithString:[[self.listArray objectAtIndex:indexPath.row] ts24]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    NSString *state = @"";
    if (indexPath) {
        state = @"pause";
    } else {
        state = @"play";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"good" object:state];
    _selectItem = indexPath;
    

  }
#pragma mark -- 大连更多的轻拍手势
- (void)didClicked:(UITapGestureRecognizer *)tap{
    KHJmoreDalianViewController *morevc = [[KHJmoreDalianViewController alloc] init];
    morevc.array = self.DalianmoreArray;
    [self.navigationController pushViewController:morevc animated:YES];
}
#pragma mark -- 排行榜的轻拍手势
- (void)didTap:(UITapGestureRecognizer *)tap{
    KHJmoreRankViewController *krvc = [[KHJmoreRankViewController alloc] init];
    krvc.dataSource = self.rankMoreArray;
     
    [self.navigationController pushViewController:krvc animated:YES];
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
