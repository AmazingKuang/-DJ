//
//  KHJProvinceBroadcastViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJProvinceBroadcastViewController.h"
#import "KHJNetTool.h"
//顶部的collectionView的Cell
#import "KHJTopProvinceCollectionViewCell.h"
//主的collectionView
#import "KHJProvinceBroadcastCollectionViewCell.h"
//顶部的model
#import "KHJProvinceModel.h"
//解析工具
#import "KHJNetTool.h"
//主CollectionView的model
#import "KHJDalianModel.h"
#import "KHJArchiverTools.h"
#import <MBProgressHUD.h>
#import "JXLDayAndNightMode.h"
@interface KHJProvinceBroadcastViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KHJProvinceBroadcastCollectionViewCellDelegate>
//顶部的collectionView
@property (nonatomic, retain) UICollectionView *topCollectionView;
//主的collectionView
@property (nonatomic, retain) UICollectionView *mainCollectionView;
//顶部的数组
@property (nonatomic, retain) NSMutableArray *topArray;
//maincollectionView数据
@property (nonatomic, retain) NSMutableArray *mainArray;
//监听变量
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, assign) NSInteger proVinceNumber;
@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJProvinceBroadcastViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"省市台";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1]style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarbutton)];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTopCollectionView];
    [self createMainCollectionView];
    [self getData];
    [self getMainDataPage:1 proVince:110000];
    
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

    
}
- (void)didClickedBarbutton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTopCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    flowLayout.itemSize = CGSizeMake(60 * lFitWidth, 40 * lFitHeight);
    flowLayout.minimumLineSpacing = 10 * lFitHeight;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10 * lFitWidth, 0, 10 * lFitWidth);
    
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 50 * lFitWidth, 40 * lFitHeight) collectionViewLayout:flowLayout];
    self.topCollectionView.backgroundColor = [UIColor whiteColor];
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    [self.view addSubview:_topCollectionView];
    
    //注册顶部的cell
    [self.topCollectionView registerClass:[KHJTopProvinceCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (void)createMainCollectionView{
    UICollectionViewFlowLayout *flowLuyout = [[UICollectionViewFlowLayout alloc] init];
    flowLuyout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64 - 40 * lFitHeight);
    self.automaticallyAdjustsScrollViewInsets = NO;
    flowLuyout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLuyout.minimumLineSpacing = 0;
    flowLuyout.minimumInteritemSpacing = 0;
    flowLuyout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 * lFitHeight, ScreenWidth, ScreenHeight - 64  - 40 * lFitHeight) collectionViewLayout:flowLuyout];
    self.mainCollectionView.pagingEnabled = YES;
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    
    
    [self.view addSubview:_mainCollectionView];
    //注册主cell
    [self.mainCollectionView registerClass:[KHJProvinceBroadcastCollectionViewCell class] forCellWithReuseIdentifier:@"mainCell"];
    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return self.topArray.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        KHJTopProvinceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = [self.topArray objectAtIndex:indexPath.item];
        if (_selectedItem == indexPath.item) {
            [cell setDidSelected:YES];
        }
        else{
            [cell setDidSelected:NO];
        }
   
        return cell;

    }
    KHJProvinceBroadcastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.delegate = self;
//    cell.backgroundColr = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    cell.array = self.mainArray;
    return cell;
    
    
  }
#pragma mark -- item的点击方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
      KHJProvinceModel *model = [self.topArray objectAtIndex:indexPath.row];
        self.proVinceNumber = [model.code integerValue];
        [self getMainDataPage:1 proVince:[model.code integerValue]];
        //将前一个item还原
        KHJTopProvinceCollectionViewCell *latCell = (KHJTopProvinceCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [latCell setDidSelected:NO];
        //获取当前的item
        KHJTopProvinceCollectionViewCell *cell = (KHJTopProvinceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
//        NSLog(@"!!!!%ld",indexPath.item);
       //item改变偏移量
        if (indexPath.item > 1 && indexPath.item < self.topArray.count - 2) {
            
            [self.topCollectionView setContentOffset:CGPointMake((indexPath.item - 1) * (60 * lFitWidth + 10 * lFitWidth) - 60 * lFitWidth, 0) animated:YES];
        }
        else if (indexPath.item == 1 || indexPath.item == 0){
            [self.topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (indexPath.item == self.topArray.count - 1 || indexPath.item == self.topArray.count){
            [self.topCollectionView setContentOffset:CGPointMake((self.topArray.count - 5)  * (60 * lFitWidth + 10 * lFitWidth) + 10 * lFitWidth  , 0) animated:YES];
        }
        [self.mainCollectionView setContentOffset:CGPointMake(indexPath.item * ScreenWidth, 0) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _mainCollectionView) {
        KHJProvinceModel *model = [self.topArray objectAtIndex:scrollView.contentOffset.x / ScreenWidth];
        self.proVinceNumber = [model.code integerValue];
        [self getMainDataPage:1 proVince:[model.code integerValue]];
        if (scrollView.contentOffset.x / ScreenWidth > 1 && scrollView.contentOffset.x / ScreenWidth < self.topArray.count - 2) {
            [self.topCollectionView setContentOffset:CGPointMake((scrollView.contentOffset.x / ScreenWidth - 1) * (60 * lFitWidth + 10 * lFitWidth) - 60 * lFitWidth, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / ScreenWidth == 1 || scrollView.contentOffset.x / ScreenWidth == 0)
        {
            [self.topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / ScreenWidth == self.topArray.count - 1 || scrollView.contentOffset.x / ScreenWidth == self.topArray.count)
        {
            [self.topCollectionView setContentOffset:CGPointMake((self.topArray.count - 5) * (60 * lFitWidth + 10 * lFitWidth) + 10 * lFitWidth, 0) animated:YES];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / ScreenWidth inSection:0];
        //将前一个item复原:
        KHJTopProvinceCollectionViewCell *lastCell = (KHJTopProvinceCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        //获取当前点击的item:
        KHJTopProvinceCollectionViewCell *cell = (KHJTopProvinceCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
    }
}
#pragma mark -- 实现协议方法
- (void)getDelegateData:(NSInteger)pageNumber{
    
    [self getMainDataPage:pageNumber proVince:_proVinceNumber];
}
#pragma mark -- 头部的数据
- (void)getData{
   self.topArray = [NSMutableArray array];
    NSString *string = @"http://live.ximalaya.com/live-web/v2/province?device=iPhone&statEvent=pageview%2Fradiolist%40%E7%9C%81%E5%B8%82%E5%8F%B0&statModule=%E7%9C%81%E5%B8%82%E5%8F%B0&statPage=tab%40%E5%8F%91%E7%8E%B0_%E5%B9%BF%E6%92%AD";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        [KHJArchiverTools archiverObject:dic ByKey:@"event" WithPath:@"event.plist"];
        NSArray *dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            KHJProvinceModel *model = [[KHJProvinceModel alloc] initWithDic:dict];
            [self.topArray addObject:model];
        }
        [self.topCollectionView reloadData];
        [self.mainCollectionView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"event" WithPath:@"event.plist"];
        NSArray *dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            KHJProvinceModel *model = [[KHJProvinceModel alloc] initWithDic:dict];
            [self.topArray addObject:model];
        }
        [self.topCollectionView reloadData];
        [self.mainCollectionView reloadData];
    }];
    
    
    
}

#pragma mark -- maincollectinview的数据
- (void)getMainDataPage:(NSInteger)pageNUmber proVince:(NSInteger)provinceNumber{
    if (pageNUmber == 1) {
         self.mainArray = [NSMutableArray array];
    }
    NSString *string = [NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v2/radio/province?device=iPhone&pageNum=%ld&pageSize=30&provinceCode=%ld",pageNUmber,provinceNumber];
    //菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        [KHJArchiverTools archiverObject:dic ByKey:@"xi" WithPath:@"xi.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dictionary in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:dictionary];
            [self.mainArray addObject:model];
        }
//        NSLog(@"数组个数%ld",self.mainArray.count);
//        NSLog(@"页数%ld",pageNUmber);
//        NSLog(@"id号%ld",provinceNumber);
        [self.mainCollectionView reloadData];
        //模拟移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[self.mbView hide:YES];
        });
    } failure:^(NSError *error) {
      NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"xi" WithPath:@"xi.plist"];
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dictionary in dataArray) {
            KHJDalianModel *model = [[KHJDalianModel alloc] initWithDic:dictionary];
            [self.mainArray addObject:model];
        }
        [self.mainCollectionView reloadData];

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
