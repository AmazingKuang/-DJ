//
//  KHJProgramListViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJProgramListViewController.h"
#import "KHJNetTool.h"
#import "KHJListViewModel.h"
//顶部的cell
#import "KHJTopProgramListCollectionViewCell.h"
//主的maincollectionView
#import "KHJMainProgramListCollectionViewCell.h"
//两个label的cell
#import "KHJTwoProgramListCell.h"
//三个label的cell
#import "KHJThreeProgramCell.h"
#import "KHJTotalProgramModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
#import "KHJParticularsModel.h"
#import "KHJPlayerMusiciViewController.h"
#import "KHJDetailRecommend.h"
#import "KHJspecialDetailViewController.h"
@interface KHJProgramListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
//创建一个tableView
@property (nonatomic, retain) UITableView *tableView;

//顶部的视图
@property (nonatomic, retain) UICollectionView *topCollectionView;
//主的视图
@property (nonatomic, retain) UICollectionView *mainCollectionView;
//顶部的数据
@property (nonatomic, retain) NSMutableArray *topArray;
//主数据
@property (nonatomic, retain) NSMutableArray *mainArray;
//最火节目数据源
@property (nonatomic, retain) NSMutableArray *hotArray;
//定义一个联动的监听变量
@property (nonatomic, assign) NSInteger selectedItem;

@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJProgramListViewController
- (void)dealloc{
    [_tableView release];
    [_topCollectionView release];
    [_mainArray release];
    [_topArray release];
    [_mainCollectionView release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.mainCollectionView.delegate  = nil;
    self.mainCollectionView.dataSource = nil;
    self.topCollectionView.delegate = nil;
    self.topCollectionView.dataSource = nil;
    [super dealloc];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarbutton)];
    //顶部数组初始化
    self.topArray = [NSMutableArray array];
    self.mainArray = [NSMutableArray array];
    self.hotArray = [NSMutableArray array];
    self.navigationItem.title = _model.title;
     [self getTopData];
    //主数据
    [self getTotalMainData:_model.key];
    
    //最火节目数据
    [self getTotalHotData:_model.key];
    [self createTableView];
    [self createTopcollectionView];
    [self createMainCollectionView];
    
    /**
     夜间模式
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
        _topCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        _topCollectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _mainCollectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        
    }];

//    [self.topCollectionView setHidden:YES];
}
- (void)didClickedBarbutton{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 创建顶部的collectionview
- (void)createTopcollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80 * lFitWidth, 40 * lFitHeight);
    self.automaticallyAdjustsScrollViewInsets = NO;
    flowLayout.minimumLineSpacing = 10 * lFitHeight;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 * lFitHeight) collectionViewLayout:flowLayout];
//    self.topCollectionView.backgroundColor = [UIColor whiteColor];
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_topCollectionView];
    
    [_topCollectionView release];
    [flowLayout release];
    
    //注册顶部cell
    [self.topCollectionView registerClass:[KHJTopProgramListCollectionViewCell class] forCellWithReuseIdentifier:@"topCell"];
    
}
#pragma mark -- 创建大的mainCollectionView
- (void)createMainCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64 - 40 * lFitHeight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40 * lFitHeight, ScreenWidth, ScreenHeight - 64 - 40 * lFitHeight) collectionViewLayout:flowLayout];
//    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.pagingEnabled = YES;
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainCollectionView];
    [flowLayout release];
    [_mainCollectionView release];
    
    //注册cell
    [self.mainCollectionView registerClass:[KHJMainProgramListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
#pragma mark -- 创建一个tableView
- (void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    //注册两个label的cell
    [self.tableView registerClass:[KHJTwoProgramListCell class] forCellReuseIdentifier:@"cell"];
    //注册三个label的cell
    [self.tableView registerClass:[KHJThreeProgramCell class] forCellReuseIdentifier:@"threeCell"];
    
}
#pragma mark -- tableView的协议方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_model.contentType isEqualToString:@"track"]) {
      return self.hotArray.count;
    }
    return self.mainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_model.contentType isEqualToString:@"track"]) {
        KHJTwoProgramListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.hotArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.labelInter = indexPath.item + 1;
        return cell;
    }
    
    KHJThreeProgramCell *thCell =[tableView dequeueReusableCellWithIdentifier:@"threeCell"];
    thCell.selectionStyle = UITableViewCellSelectionStyleNone;
    thCell.model = [self.mainArray objectAtIndex:indexPath.row];
    thCell.labelInter = indexPath.item + 1;
    return thCell;
    
}
#pragma mark --- tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if ([_model.contentType isEqualToString:@"track"]) {
         KHJPlayerMusiciViewController *musicVc = [KHJPlayerMusiciViewController shareDetailViewController];
         musicVc.model = [self.hotArray objectAtIndex:indexPath.row];
         musicVc.musicArr = self.hotArray;
         musicVc.index = indexPath.row;
         [self presentViewController:musicVc animated:YES completion:nil];
         //通知按钮旋转,播放及按钮改变图片和状态
         NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
         userInfo[@"coverURL"] = [NSURL URLWithString:[[self.hotArray objectAtIndex:indexPath.row] coverSmall]];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];

     }
     else{
    KHJspecialDetailViewController *kvc = [[KHJspecialDetailViewController alloc] init];
    kvc.model = [self.mainArray objectAtIndex:indexPath.item];
    [self.navigationController pushViewController:kvc animated:YES];
     }
}


#pragma mark -- collectionView的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.topArray.count + 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        
        KHJTopProgramListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        if (indexPath.item != 0) {
            if (self.topArray.count != 0) {
                cell.model = [self.topArray objectAtIndex:indexPath.item - 1];
            }
        }else{
            cell.label.text = @"总榜";
        } if (_selectedItem == indexPath.row) {
            [cell setDidSelected:YES];
        }else{
            [cell setDidSelected:NO];
        }

               return cell;
    }
    
    KHJMainProgramListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        void (^blck)(KHJspecialDetailViewController *) = ^(KHJspecialDetailViewController *svc){
            [self.navigationController pushViewController:svc animated:YES];
        };
        cell.block = blck;

        void (^blk)(KHJPlayerMusiciViewController *) = ^(KHJPlayerMusiciViewController *svc){
            [self presentViewController:svc animated:YES completion:nil];
        };
        cell.blk = blk;

        
        if ([_model.contentType isEqualToString:@"track"]) {
            cell.firstArray = _hotArray;
        }
        else{
            cell.firstArray = _mainArray;
        }
    }
    
    else{
        
        void (^blck)(KHJspecialDetailViewController *) = ^(KHJspecialDetailViewController *svc){
            [self.navigationController pushViewController:svc animated:YES];
        };
        cell.block = blck;
        
        void (^blk)(KHJPlayerMusiciViewController *) = ^(KHJPlayerMusiciViewController *svc){
            [self presentViewController:svc animated:YES completion:nil];
        };
        cell.blk = blk;

        
        if ([_model.contentType isEqualToString:@"track"]) {
            cell.firstArray = _hotArray;
        }
        else{
            cell.firstArray = _mainArray;
        }

    }
    
    cell.titleString = _model.contentType;
    
    
    
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        if (indexPath.item == 0) {
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getTotalHotData:_model.key];
            }
            else{
                [self getTotalMainData:_model.key];
            }
        }
        else{    //从网络中请求数据
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getTotalHotData:[[self.topArray objectAtIndex:indexPath.item - 1] key]];
            }
            else{
                [self getTotalMainData:[[self.topArray objectAtIndex:indexPath.item - 1] key]];
            }
        }
        //将前一个item还原
        KHJTopProgramListCollectionViewCell *lastCell = (KHJTopProgramListCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        //获取当前的item
        KHJTopProgramListCollectionViewCell *cell = (KHJTopProgramListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.row;
        //点击item改变偏移量
        if (indexPath.item > 1 && indexPath.item < self.topArray.count - 1) {
            [self.topCollectionView setContentOffset:CGPointMake((indexPath.item - 1) * (80 * lFitWidth  + 10 * lFitWidth) - 50 * lFitWidth, 0) animated:YES];
        }else if (indexPath.item == 1 || indexPath.item == 0)
        {
            [self.topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (indexPath.item == self.topArray.count - 1 || indexPath.item == self.topArray.count)
        {
            [self.topCollectionView setContentOffset:CGPointMake((self.topArray.count - 3) * (80 * lFitWidth + 10 * lFitWidth) - 4 * lFitWidth, 0) animated:YES];
        }
        [self.mainCollectionView setContentOffset:CGPointMake(indexPath.item * ScreenWidth, 0)];
        }
    

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.mainCollectionView) {
        if (scrollView.contentOffset.x / ScreenWidth == 0) {
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getTotalHotData:_model.key];
            }
            else{
                [self getTotalMainData:_model.key];
            }
        }
        else{
            //从网络中请求数据
            if ([_model.contentType isEqualToString:@"track"]) {
                [self getTotalHotData:[[self.topArray objectAtIndex:scrollView.contentOffset.x / ScreenWidth - 1] key]];
            }
            else{
                [self getTotalMainData:[[self.topArray objectAtIndex:scrollView.contentOffset.x / ScreenWidth - 1] key]];
            }
        }
        
        if (scrollView.contentOffset.x / ScreenWidth > 1 && scrollView.contentOffset.x / ScreenWidth < self.topArray.count - 1) {
            [self.topCollectionView setContentOffset:CGPointMake((scrollView.contentOffset.x / ScreenWidth - 1) * (80 * lFitWidth + 10 * lFitWidth) - 50 * lFitWidth, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / ScreenWidth == 1 || scrollView.contentOffset.x / ScreenWidth == 0)
        {
            [self.topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / ScreenWidth == self.topArray.count - 1 || scrollView.contentOffset.x / ScreenWidth == self.topArray.count)
        {
            [self.topCollectionView setContentOffset:CGPointMake((self.topArray.count - 3) * (80 * lFitWidth + 10 * lFitWidth) - 4 * lFitWidth, 0) animated:YES];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / ScreenWidth inSection:0];
        //将前一个item复原:
        KHJTopProgramListCollectionViewCell *lastCell = (KHJTopProgramListCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        //获取当前点击的item:
        KHJTopProgramListCollectionViewCell *cell = (KHJTopProgramListCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;

        
        
    }
    
}


#pragma mark -- 请求顶部数据
- (void)getTopData{
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/track?device=iPhone&key=%@&pageId=1&pageSize=1&scale=2&statPosition=1",_model.key];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"xima" WithPath:@"xima.plist"];
        NSArray *array = [dic objectForKey:@"categories"];
        for (NSDictionary *dict in array) {
            KHJListViewModel *listModel = [[KHJListViewModel alloc] initWithDic:dict];
            [self.topArray addObject:listModel];
            [listModel release];
        }
      
        if (self.topArray.count == 0) {
            [self.topCollectionView removeFromSuperview];
            [self.mainCollectionView removeFromSuperview];
            self.tableView.hidden = NO;
        }
        
        [self.tableView reloadData];
        [self.topCollectionView reloadData];
        [self.mainCollectionView reloadData];

    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"xima" WithPath:@"xima.plist"];
        NSArray *array = [dic objectForKey:@"categories"];
        for (NSDictionary *dict in array) {
            KHJListViewModel *listModel = [[KHJListViewModel alloc] initWithDic:dict];
            [self.topArray addObject:listModel];
            [listModel release];
        }
        
        if (self.topArray.count == 0) {
            [self.topCollectionView removeFromSuperview];
            [self.mainCollectionView removeFromSuperview];
            self.tableView.hidden = NO;
        }
        
        [self.tableView reloadData];
        [self.topCollectionView reloadData];
        [self.mainCollectionView reloadData];
    }];
    
    

}
#pragma mark -- 总榜的数据,和最多经典榜
- (void)getTotalMainData:(NSString *)mainstr{
    [self.mainArray removeAllObjects];
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/album?device=iPhone&key=%@&pageId=1&pageSize=20&scale=2",mainstr];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"ximal" WithPath:@"ximal.plist"];
        NSArray *array = [dic objectForKey:@"list"];
        for (NSDictionary *dict in array) {
//            NSLog(@"~~~~~~%@",dict);
            KHJDetailRecommend *totalModel = [[KHJDetailRecommend alloc] initWithDic:dict];
            [self.mainArray addObject:totalModel];
            [totalModel release];
        }
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
        });
        [self.mainCollectionView reloadData];
              [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"ximal" WithPath:@"ximal.plist"];
        NSArray *array = [dic objectForKey:@"list"];
        for (NSDictionary *dict in array) {
            
            KHJDetailRecommend *totalModel = [[KHJDetailRecommend alloc] initWithDic:dict];
            [self.mainArray addObject:totalModel];
            [totalModel release];
        }
        [self.mainCollectionView reloadData];
        [self.tableView reloadData];
        
    }];
}
#pragma mark --- 总榜
- (void)getTotalHotData:(NSString *)str{
    [self.hotArray removeAllObjects];
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/track?device=android&key=%@&pageId=1&pageSize=20&statPosition=1",str];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"hota" WithPath:@"hota.plist"];
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *diction in listArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:diction];
            [self.hotArray addObject:model];
            [model release];
        }
        [self.mainCollectionView reloadData];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"hota" WithPath:@"hota.plist"];
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *diction in listArray) {
            KHJParticularsModel *model = [[KHJParticularsModel alloc] initWithDic:diction];
            [self.hotArray addObject:model];
            [model release];
        }
        [self.mainCollectionView reloadData];
        [self.tableView reloadData];

        
    }];

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
