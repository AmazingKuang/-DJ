//
//  KHJSecondAnchorDetailViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSecondAnchorDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "GetHeightTools.h"
#import "KHJNetTool.h"
#import "KHJParticularsTableViewCell.h"
#import "KHJParticularsModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import "KHJPlayerMusiciViewController.h"
@interface KHJSecondAnchorDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
//定义背景图
@property (nonatomic, retain) UIImageView *backgroundImageView;
//定义圆形图片
@property (nonatomic, retain) UIImageView *circleImageView;
//定义名字
@property (nonatomic, retain) UILabel *nameLabel;
//定义内容图片
@property (nonatomic, retain) UILabel *contentLabel;
//旋转图片
@property (nonatomic, retain) UIImageView *turnImageView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) UILabel *attentionnumberLabel;
@property (nonatomic, retain) UILabel *fasnumber;
@property (nonatomic, retain) MBProgressHUD *mbView;
@property (nonatomic, assign) NSInteger pNumber;
@end

@implementation KHJSecondAnchorDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    [self getData:1];
    self.pNumber = 1;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButtonitem:)];
    self.navigationItem.title = _model.nickname;
    [self createTableView];
}
- (void)didClickedBarButtonitem:(UIBarButtonItem *)bar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //创建头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 270 * lFitHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    //创建背景图
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight)];
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_model.smallLogo]];
    UIToolbar *blurView = [[UIToolbar alloc] init];

    blurView.barStyle = UIBarStyleBlack;
    blurView.frame = _backgroundImageView.bounds;
    [_backgroundImageView addSubview:blurView];
    [blurView release];
    [headerView addSubview:_backgroundImageView];
    //创建圆形图片
    self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(170 * lFitWidth, 20 * lFitHeight, 70 * lFitWidth, 70 * lFitHeight)];
    [self.circleImageView sd_setImageWithURL:[NSURL URLWithString:_model.smallLogo]];
    _circleImageView.layer.masksToBounds = YES;
    _circleImageView.layer.cornerRadius = 35 * lFitHeight;
    [headerView addSubview:_circleImageView];
    //创建名字label
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150 * lFitWidth, 95 * lFitWidth, 100 * lFitWidth, 20 * lFitHeight)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = _model.nickname;
    self.nameLabel.textAlignment = 1;
    [headerView addSubview:_nameLabel];
    //定义内容label
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(130 * lFitWidth, 120 * lFitHeight, 150 * lFitWidth, 30 * lFitHeight)];
    self.contentLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.textAlignment =1;
    self.contentLabel.text = _model.personDescribe;
    [headerView addSubview:_contentLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(180 * lFitWidth, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 5 * lFitHeight, 30 * lFitWidth, 30 * lFitHeight);
    self.turnImageView = [[UIImageView alloc] init];
    _turnImageView.frame = CGRectMake(15 * lFitWidth, 0, 15 * lFitWidth, 10 * lFitHeight);
    _turnImageView.image = [[UIImage imageNamed:@"navidrop_arrow_down_h"] imageWithRenderingMode:1];
    [button addSubview:_turnImageView];
//    button.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:button];
    [button addTarget:self action:@selector(didCLickedButton:) forControlEvents:UIControlEventTouchUpInside];
    //创建一个关注的的人
    self.attentionnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 * lFitWidth, 210 * lFitHeight, 80 * lFitWidth, 30 * lFitHeight)];
    self.attentionnumberLabel.textAlignment = 1;
    self.attentionnumberLabel.text = [NSString stringWithFormat:@"%ld",[_model.tracksCounts integerValue]];
    [headerView addSubview:_attentionnumberLabel];
    //关注label
    UILabel *attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * lFitWidth, 245 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight)];
    attentionLabel.textAlignment = 1;
    attentionLabel.text  =@"关注的人";
    [headerView addSubview:attentionLabel];
    //粉丝
    self.fasnumber = [[UILabel alloc] initWithFrame:CGRectMake(160 * lFitWidth, 210 * lFitHeight, 80 * lFitWidth, 30 * lFitHeight)];
    self.fasnumber.textAlignment = 1;
    if ([_model.followersCounts integerValue] < 10000) {
        self.fasnumber.text = [NSString stringWithFormat:@"%ld",[_model.followersCounts integerValue]];
    }
    else{
    self.fasnumber.text = [NSString stringWithFormat:@"%.1f万",[_model.followersCounts floatValue] / 10000];
    }
    [headerView addSubview:_fasnumber];
    //粉丝名字
    UILabel *fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(150 * lFitWidth, 245 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight)];
    fansLabel.text = @"粉丝";
    fansLabel.textAlignment = 1;
    [headerView addSubview:fansLabel];
    //赞过的人
    UILabel *praisenumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(290 * lFitWidth, 210 * lFitHeight, 80 * lFitWidth, 30 * lFitHeight)];
    praisenumberLabel.text = @"0";
    praisenumberLabel.textAlignment = 1;
    [headerView addSubview:praisenumberLabel];
    //赞过的名字
    UILabel *praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(280 * lFitWidth, 245 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight)];
    praiseLabel.text = @"赞过的";
    praiseLabel.textAlignment = 1;
    [headerView addSubview:praiseLabel];
    if (_model.tracksCounts != nil) {
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 270 * lFitHeight);
        self.tableView.tableHeaderView = headerView;
    }
    else{
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight);
        self.attentionnumberLabel.hidden = YES;
        attentionLabel.hidden = YES;
        self.fasnumber.hidden = YES;
        fansLabel.hidden = YES;
        praiseLabel.hidden  = YES;
        praisenumberLabel.hidden = YES;
        self.tableView.tableHeaderView = headerView;
    }
    //注册cell
    [self.tableView registerClass:[KHJParticularsTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getOneData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
    
 
}
- (void)didCLickedButton:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
    [UIView animateWithDuration:0.8 animations:^{
        self.circleImageView.center = CGPointMake(ScreenWidth / 2, -70 * lFitHeight);
        self.circleImageView.transform = CGAffineTransformRotate(self.circleImageView.transform, M_PI);
        self.circleImageView.alpha = 0;
        self.nameLabel.center = CGPointMake(ScreenWidth / 2, 20 * lFitHeight);
        self.turnImageView.transform = CGAffineTransformRotate(self.turnImageView.transform, M_PI);
        CGFloat height = [GetHeightTools heightWith:_contentLabel.text];
        CGFloat weight = [GetHeightTools getTextWidth:_contentLabel.text withFontSize:14];
        self.contentLabel.frame = CGRectMake(130 * lFitWidth, 70 * lFitHeight, weight, height);
         self.contentLabel.center = CGPointMake(ScreenWidth / 2, 60 * lFitHeight);

    }];
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            self.circleImageView.center = CGPointMake(ScreenWidth / 2, 50  *lFitHeight);
            self.circleImageView.transform = CGAffineTransformRotate(self.circleImageView.transform, M_PI);
            self.circleImageView.alpha = 1;
            self.nameLabel.center = CGPointMake(ScreenWidth / 2, 100 * lFitHeight);
            self.turnImageView.transform = CGAffineTransformRotate(self.turnImageView.transform, M_PI);
            self.contentLabel.frame = CGRectMake(130 * lFitWidth, 120 * lFitHeight, 150 * lFitWidth, 30 * lFitHeight);
            self.contentLabel.center = CGPointMake(ScreenWidth / 2, 130  *lFitHeight);

        }];
       
    }
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

#pragma mark -- 请求数据
- (void)getData:(NSInteger)pageNumber{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/v1/artist/tracks?device=android&pageId=%ld&toUid=%ld&track_base_url=http://mobile.ximalaya.com/mobile/v1/artist/tracks",pageNumber,[_model.uid integerValue]];
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"nase" WithPath:@"nase.plist"];
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
            
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
        });
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"nase" WithPath:@"nase.plist"];
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *dict in listArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:dict];
            [self.dataSource addObject:model];
            
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJParticularsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30 * lFitHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30 * lFitHeight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5 * lFitWidth, 5 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight)];
    label.text = [NSString stringWithFormat:@"发布的声音(%ld)",self.dataSource.count];
    [headView addSubview:label];
    
    return headView;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJPlayerMusiciViewController *kvc = [KHJPlayerMusiciViewController shareDetailViewController];
    kvc.model = [self.dataSource objectAtIndex:indexPath.row];
    kvc.musicArr = self.dataSource;
    kvc.index = indexPath.item;
    [self presentViewController:kvc animated:YES completion:nil];
    
    //通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[self.dataSource objectAtIndex:indexPath.row] coverMiddle]];
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
