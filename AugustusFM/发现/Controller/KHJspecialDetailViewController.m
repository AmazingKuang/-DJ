//
//  KHJspecialDetailViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJspecialDetailViewController.h"
#import "KHJNetTool.h"
#import <UIImageView+WebCache.h>
#import "KHJParticularsTableViewCell.h"
#import "KHJContentIntroTableViewCell.h"
#import "KHJAnchorIntroduceCell.h"
#import "KHJAnchorIntroduceModel.h"

#import "KHJDeTailRecommendTableViewCell.h"
//精彩推荐
#import "KHJDetailRecommend.h"
#import "KHJParticularsModel.h"
//播放界面
#import "KHJPlayerMusiciViewController.h"
#import <MJRefresh.h>
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
//数据库
#import "KHJDataBaseTool.h"
#import "JXLDayAndNightMode.h"
@interface KHJspecialDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableview;

@property (nonatomic, retain) UIImageView *coverMiddleImageView;

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *playTimesLabel;
@property (nonatomic, retain) UIView *headerView;
//内容简介
@property (nonatomic, retain) NSString *contentString;
//主播介绍数据源
@property (nonatomic, retain) NSMutableArray *anchorDatasource;

//精彩推荐数据源
@property (nonatomic, retain) NSMutableArray *listDatasource;
@property (nonatomic, assign) BOOL isClick;
//节目
@property (nonatomic, retain) NSMutableArray *programArray;
//上拉加载下拉刷新
@property (nonatomic, assign) NSInteger pageNumber;

@property (nonatomic, retain) MBProgressHUD *mbView;
//收藏按钮监听变量
@property (nonatomic, assign) BOOL isCollected;

@end

@implementation KHJspecialDetailViewController
- (void)dealloc{
    [_tableview release];
    [_coverMiddleImageView release];
    [_titleLabel release];
    [_nicknameLabel release];
    [_playTimesLabel release];
    [_headerView release];
    [_contentString release];
    [_anchorDatasource release];
    [_listDatasource release];
    [_programArray release];
    self.tableview.delegate = nil;
    self.tableview.dataSource = nil;
    [super dealloc];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.tabBar setHidden:YES];
    KHJDataBaseTool *dataBase = [[KHJDataBaseTool alloc] init];
    self.isCollected = [dataBase isCollectedInTableadS:_model.albumId];
    [self getData];
    [self getdetailData];
    KHJDataBaseTool *data = [[KHJDataBaseTool alloc] init];
    BOOL res = [data isCollectedInTableadS:_model.albumId];
    if (res) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_h"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
    }
    else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_n"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
        
    }
    [self.tableview reloadData];

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.view.backgroundColor = [UIColor redColor];
       //主播介绍
    self.anchorDatasource = [NSMutableArray array];
    //节目
    self.programArray = [NSMutableArray array];
      //精彩推荐数据源
    self.listDatasource = [NSMutableArray array];
       self.navigationItem.title = @"专辑详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 * lFitWidth]}];
    [self getData];
    [self getdetailData];
    [self createTableView];
    [self createHeaderView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedButtonItem:)];

    
}
- (void)didClickedRightBarButtonItem:(UIBarButtonItem *)barbutton{
    if (!self.isCollected){
        KHJDataBaseTool *dataTool = [KHJDataBaseTool shareInstance];
        [dataTool insert:self.model];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_h"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
        
        
        MBProgressHUD *textOnlyHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        textOnlyHUD.mode = MBProgressHUDModeText;
        textOnlyHUD.detailsLabelText = @"已收藏";
        [textOnlyHUD hide:YES afterDelay:1.f];
        self.isCollected = YES;
    }
    else {
        KHJDataBaseTool *dataTool = [KHJDataBaseTool shareInstance];
        [dataTool deleteDataWithModel:self.model.albumId];
        //提示框:
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"np_like_n"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedRightBarButtonItem:)];
        self.isCollected = NO;
        MBProgressHUD *textOnlyHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        textOnlyHUD.mode = MBProgressHUDModeText;
        textOnlyHUD.detailsLabelText = @"取消收藏";
        [textOnlyHUD hide:YES afterDelay:1.f];
    }

}


- (void)didClickedButtonItem:(UIBarButtonItem *)bot{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140 * lFitHeight)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor whiteColor];

    self.tableview.tableHeaderView = _headerView;
    [self.view addSubview:_tableview];
    //内容简介cell
    [self.tableview registerClass:[KHJContentIntroTableViewCell class] forCellReuseIdentifier:@"cell"];
    //主播介绍
    [self.tableview registerClass:[KHJAnchorIntroduceCell class] forCellReuseIdentifier:@"inCell"];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    //精彩推荐注册cell
    [self.tableview registerClass:[KHJDeTailRecommendTableViewCell class] forCellReuseIdentifier:@"pCell"];
    //节目
    [self.tableview registerClass:[KHJParticularsTableViewCell class] forCellReuseIdentifier:@"taCell"];
       //上拉加载
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //开始下拉加载
            [self getMoreData];
        [self.tableview.mj_footer endRefreshing];
        
        
}];

    
    [_tableview jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        
    }];
}
- (void)createHeaderView{
    self.coverMiddleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * lFitWidth, 10 * lFitHeight, 100 * lFitWidth, 100 * lFitHeight)];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverMiddleImageView.frame.origin.x + self.coverMiddleImageView.frame.size.width + 10 * lFitWidth, self.coverMiddleImageView.frame.origin.y, 200 * lFitWidth, 30 * lFitHeight)];
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight)];
    
    self.playTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nicknameLabel.frame.origin.x, self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.size.height + 5 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight)];
    
    UIImageView *readimageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.playTimesLabel.frame.origin.x - 50 * lFitWidth, self.playTimesLabel.frame.origin.y + self.playTimesLabel.frame.size.height + 40 * lFitHeight, 60 * lFitWidth, 15 * lFitHeight)];
    readimageView.image = [[UIImage imageNamed:@"newAblum_pay_rss"] imageWithRenderingMode:1];
    
    UIImageView *downloadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(readimageView.frame.origin.x + readimageView.frame.size.width + 170 * lFitWidth, readimageView.frame.origin.y, 60 * lFitWidth, 15 * lFitHeight)];
    downloadImageView.image = [[UIImage imageNamed:@"newAblum_free_download"] imageWithRenderingMode:1];
    self.titleLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
     self.nicknameLabel.textColor = [UIColor blueColor];
    self.nicknameLabel.font = [UIFont systemFontOfSize:13 * lFitWidth];
    self.playTimesLabel.font = [UIFont systemFontOfSize:13 * lFitWidth];
    self.nicknameLabel.alpha = 0.5;
    self.playTimesLabel.alpha = 0.5;
    
    [self.headerView addSubview:_coverMiddleImageView];
    [self.headerView addSubview:_titleLabel];
    [self.headerView addSubview:_nicknameLabel];
    [self.headerView addSubview:_playTimesLabel];
//    [self.headerView addSubview:readimageView];
//    [self.headerView addSubview:downloadImageView];
    
    
    
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _nicknameLabel.textColor = [UIColor whiteColor];
        _nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        
        _playTimesLabel.textColor = [UIColor whiteColor];
        _playTimesLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        }];
}
#pragma mark -- 请求数据
- (void)getData{
    NSString *sting = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album?albumId=%ld&device=android&isAsc=true&pageId=%ld&pageSize=20&pre_page=0&source=0&statPosition=1",_model.albumId ,_pageNumber];
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
//    NSLog(@"数量 : %ld",[_model.albumId integerValue]);
    [KHJNetTool GET:sting body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"number" WithPath:@"number.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSDictionary *albumDic = [dataDic objectForKey:@"album"];
        [self.coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:[albumDic objectForKey:@"coverLarge"]]];
        self.nicknameLabel.text = [NSString stringWithFormat:@"主播: %@",[albumDic objectForKey:@"nickname"]];
       
        self.titleLabel.text = [albumDic objectForKey:@"title"];
        self.playTimesLabel.text = [NSString stringWithFormat:@"播放: %.2f万次",[[albumDic objectForKey:@"playTimes"] floatValue] / 100000];
        
        NSDictionary *tracksDic = [dataDic objectForKey:@"tracks"];
        NSArray *liArray = [tracksDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:liDic];
            [self.programArray addObject:model];
            
        }
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mbView hide:YES];
        });

        [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"number" WithPath:@"number.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSDictionary *albumDic = [dataDic objectForKey:@"album"];
        [self.coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:[albumDic objectForKey:@"coverLarge"]]];
        self.nicknameLabel.text = [NSString stringWithFormat:@"主播: %@",[albumDic objectForKey:@"nickname"]];
        
        self.titleLabel.text = [albumDic objectForKey:@"title"];
        self.playTimesLabel.text = [NSString stringWithFormat:@"播放: %.2f万次",[[albumDic objectForKey:@"playTimes"] floatValue] / 100000];
        
        NSDictionary *tracksDic = [dataDic objectForKey:@"tracks"];
        NSArray *liArray = [tracksDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:liDic];
            [self.programArray addObject:model];
            
        }
        [self.tableview reloadData];
    }];
}
#pragma mark ---上拉加载数据
- (void)getMoreData{
    _pageNumber++;
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album/track?albumId=%ld&device=android&isAsc=true&pageId=%ld&pageSize=20&statPosition=2",_model.albumId ,_pageNumber];
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"part" WithPath:@"part.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        
        NSArray *liArray = [dataDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:liDic];
            [self.programArray addObject:model];
        }
        [self.mbView hide:YES afterDelay:1];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"part" WithPath:@"part.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        
        NSArray *liArray = [dataDic objectForKey:@"list"];
        for (NSDictionary *liDic in liArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:liDic];
            [self.programArray addObject:model];
    }
        [self.tableview reloadData];
    }];
}
#pragma mark -- 详情的数据
- (void)getdetailData{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/album/detail?albumId=%ld&device=android&statPosition=1",_model.albumId];

    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
//        NSLog(@"%@",result);
        [KHJArchiverTools archiverObject:dic ByKey:@"file" WithPath:@"file.plist"];
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSDictionary *diction = [dict objectForKey:@"detail"];
        self.contentString = [diction objectForKey:@"intro"];
        NSDictionary *anchorDic = [dict objectForKey:@"user"];
        KHJAnchorIntroduceModel *anchorModel = [[KHJAnchorIntroduceModel alloc] initWithDic:anchorDic];
        [self.anchorDatasource addObject:anchorModel];
        //精彩推荐
        NSDictionary *lisDic = [dict objectForKey:@"recs"];
        NSArray *listArray = [lisDic objectForKey:@"list"];
        for (NSDictionary *listDic in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:listDic];
            [self.listDatasource addObject:model];
            
        }

        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"file" WithPath:@"file.plist"];
        NSDictionary *dict = [dic objectForKey:@"data"];
        NSDictionary *diction = [dict objectForKey:@"detail"];
        self.contentString = [diction objectForKey:@"intro"];
        NSDictionary *anchorDic = [dict objectForKey:@"user"];
        KHJAnchorIntroduceModel *anchorModel = [[KHJAnchorIntroduceModel alloc] initWithDic:anchorDic];
        [self.anchorDatasource addObject:anchorModel];
        //精彩推荐
        NSDictionary *lisDic = [dict objectForKey:@"recs"];
        NSArray *listArray = [lisDic objectForKey:@"list"];
        for (NSDictionary *listDic in listArray) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:listDic];
            [self.listDatasource addObject:model];
            
        }
        
        [self.tableview reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isClick == NO) {
        return 3;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isClick == NO) {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    return 3;
    }
    return self.programArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isClick == NO) {
   if (indexPath.section == 0) {
        return 100 * lFitHeight;
    }
  if (indexPath.section == 1) {
        return 150 * lFitHeight;
    }
    return 100 * lFitHeight;
    }
    
    return 120 * lFitHeight;
    
   
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isClick == NO) {
    if (indexPath.section == 0) {
        KHJContentIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.introLabel.text = _contentString;
            return cell;
        }
        
        if (indexPath.section == 1) {
            KHJAnchorIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.anchorDatasource.count != 0) {
                cell.model = [self.anchorDatasource objectAtIndex:indexPath.row];

            }
            return cell;
        }
        if (indexPath.section == 2) {
            KHJDeTailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.listDatasource.count != 0) {
                cell.model = [self.listDatasource objectAtIndex:indexPath.row];

            }
            return cell;
        }
        
        

    }
    
    KHJParticularsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = [self.programArray objectAtIndex:indexPath.row];
 
    return cell;


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30 * lFitHeight;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    if (section == 0) {
        
      UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 * lFitHeight)];
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonOne.frame = CGRectMake(70 * lFitWidth, 0, 60 * lFitWidth, 30 * lFitHeight);
    UIButton *buttonTwo =[UIButton buttonWithType:UIButtonTypeSystem];
    buttonTwo.frame = CGRectMake(280 * lFitWidth, 0, 60 * lFitWidth, 30 * lFitHeight);
    buttonOne.titleLabel.font = [UIFont systemFontOfSize:19 * lFitWidth];
    buttonOne.titleLabel.textAlignment = 1;
    buttonTwo.titleLabel.textAlignment = 1;
    buttonTwo.titleLabel.font = [UIFont systemFontOfSize:19 * lFitWidth];
    [buttonOne setTitle:@"详情" forState:UIControlStateNormal];
    [buttonTwo setTitle:@"节目" forState:UIControlStateNormal];
    [buttonOne addTarget:self action:@selector(didClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonTwo addTarget:self action:@selector(didClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:buttonOne];
    [headerView addSubview:buttonTwo];
    
    //线条
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor =[UIColor redColor];
    [headerView addSubview:lineView];
   

    if (self.isClick == NO) {
        [buttonOne setTintColor:[UIColor redColor]];
        lineView.frame = CGRectMake(72 * lFitWidth, 35 * lFitHeight, 55 * lFitWidth, 2);
    }
    else{
        [buttonTwo setTintColor:[UIColor redColor]];
        lineView.frame = CGRectMake(282 * lFitWidth, 35 * lFitHeight, 55 * lFitWidth, 2);
    }
        return headerView;
    }
    return nil;
}
- (void)didClickedButton:(UIButton *)buttonOne{
    if ([buttonOne.titleLabel.text isEqualToString:@"详情"]) {
        self.isClick = NO;
    }
    else{
        self.isClick = YES;
    }
    [self.tableview reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isClick == YES) {
        KHJPlayerMusiciViewController *kpvc = [KHJPlayerMusiciViewController shareDetailViewController];
        kpvc.musicArr = self.programArray;
        kpvc.index = indexPath.row;
        kpvc.model = [self.programArray objectAtIndex:indexPath.item];

        [self presentViewController:kpvc animated:YES completion:nil];
        [kpvc release];
        //通知按钮旋转,播放及按钮改变图片和状态
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"coverURL"] = [NSURL URLWithString:[[self.programArray objectAtIndex:indexPath.row] coverMiddle]];
       
//        userInfo[@"musicURL"] = [NSURL URLWithString:[[self.programArray objectAtIndex:indexPath.row] playUrl64]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
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
