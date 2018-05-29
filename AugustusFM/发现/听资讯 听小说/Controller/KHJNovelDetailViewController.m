//
//  KHJNovelDetailViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNovelDetailViewController.h"
#import "KHJNetTool.h"
#import "KHJIDModel.h"
#import "KHJNovelTopCollectionViewCell.h"
#import "GetHeightTools.h"
#import "KHJNovelMainCollectionViewCell.h"

#import "KHJDetailRecommend.h"

#import "KHJNovelRecommendCollectionViewCell.h"
//没有用
#import "KHJNovelBigModel.h"
//推荐tableView的Model
#import "KHJDetailRecommend.h"
//归档工具
#import "KHJArchiverTools.h"
//菊花加载
#import <MBProgressHUD.h>

#import "JXLDayAndNightMode.h"
@interface KHJNovelDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KHJNovelMainCollectionViewCellDelegate>

//最上面的头标题
@property (nonatomic, retain) UICollectionView *topCollectionView;
//大的collectionView
@property (nonatomic, retain) UICollectionView *mainCollectionView;
//上面的标题数组
@property (nonatomic, retain) NSMutableArray *topArray;
//主要的数组
@property (nonatomic, retain) NSMutableArray *mainArray;
/** 监听被选中的item下标 */
@property(nonatomic, assign)NSInteger selectedItem;
/** 分栏标题 */
@property(nonatomic, copy)NSString *tagName;

@property (nonatomic, assign) NSInteger categrayId;
//推荐数据源
@property (nonatomic, retain) NSMutableArray *remmendArray;
//轮播图数据
@property (nonatomic, retain) NSMutableArray *headArray;
//推荐里tableView的数据源
@property (nonatomic, retain) NSMutableArray *tableViewArray;

@property (nonatomic, assign) NSInteger keyNumber;

@property (nonatomic, assign) NSInteger iddd;
@property (nonatomic, retain) MBProgressHUD *mbView;

@end

@implementation KHJNovelDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = _model.title;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topArray = [NSMutableArray array];
    self.remmendArray = [NSMutableArray array];
    self.headArray = [NSMutableArray array];
    self.tableViewArray = [NSMutableArray array];
    [self createTopcollectionView];
    [self createMainCollectionView];
    [self getData];
    [self getRecommendData];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButton)];

}
- (void)didClickedBarButton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTopcollectionView{
    //创建一个系统提供的布局对象:
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置每个单元格的尺寸:
    flowLayOut.itemSize = CGSizeMake(90, 50);
    self.automaticallyAdjustsScrollViewInsets = NO;
    //最小列间距:
    flowLayOut.minimumInteritemSpacing = 0;
    //最小行间距:
    flowLayOut.minimumLineSpacing = 10;
    //设置内容区域与周围的距离;
//    flowLayOut.sectionInset = UIEdgeInsetsMake(10, 0, 0, 10);
    //设置滚动方向:
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //初始化collectionView:    
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50) collectionViewLayout:flowLayOut];
    //设置颜色
    self.topCollectionView.backgroundColor = [UIColor whiteColor];
    self.topCollectionView.bounces = NO;
    //设置代理人
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_topCollectionView];
    
    //注册cell
    [self.topCollectionView registerClass:[KHJNovelTopCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    /**
     *  夜间模式
     */
    
    [self.view jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor blackColor];
        _topCollectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

    
}
- (void)createMainCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64  - 50);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight - 64 - 50) collectionViewLayout:flowLayout];
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.delegate  = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.pagingEnabled = YES;
    
    
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView release];
    //注册大的collectionView
    [self.mainCollectionView registerClass:[KHJNovelMainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    //注册推荐的cell
    [self.mainCollectionView registerClass:[KHJNovelRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"rCell"];
    
    /**
     *  夜间模式
     *
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor blackColor];
        _mainCollectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];

    
    
    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
        return self.topArray.count + 1;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _topCollectionView) {
        KHJNovelTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
        if (indexPath.item != 0) {
            if (self.topArray.count != 0) {
                KHJIDModel *model = [self.topArray objectAtIndex:indexPath.row - 1];
                cell.model = model;

            }
                }else{
            cell.label.text = @"推荐";
        }
        
        
        if (_selectedItem == indexPath.item) {
            [cell setDidSelected:YES];
        }
        else{
            [cell setDidSelected:NO];
        }
        return cell;

    }if (collectionView == _mainCollectionView) {
        if (indexPath.item == 0) {
            KHJNovelRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rCell" forIndexPath:indexPath];
            cell.topscrollviewArray = self.headArray;
            cell.mainArray = self.tableViewArray;
            void (^blc)(KHJspecialDetailViewController *) = ^(KHJspecialDetailViewController *kdvc){
                [self.navigationController pushViewController:kdvc animated:YES];
            };
            cell.block = blc;
            return cell;
        }
        else{
            KHJNovelMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            cell.listArray = self.mainArray;
            cell.delegate = self;
            void (^bloc) (KHJspecialDetailViewController *) = ^(KHJspecialDetailViewController *ksvc){
                [self.navigationController pushViewController:ksvc animated:YES];
                
            };
            cell.block = bloc;
            return cell;
        }
        
    }
    
    return nil;
    
   }

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _topCollectionView) {
        if (indexPath.item != 0) {
            //从网络请求列表内容数据:
            if (self.topArray.count != 0) {
                if (_model.idd == nil) {
                    [self getMainCollectionData:[_model.categoryId integerValue] keyword:[[[self.topArray objectAtIndex:indexPath.item - 1] keywordId] integerValue] pNumber:1];
                }
                if(_model.categoryId == nil){
                    [self getMainCollectionData:[_model.idd integerValue] keyword:[[[self.topArray objectAtIndex:indexPath.item - 1] keywordId] integerValue] pNumber:1];

                }
                
                self.keyNumber = [[[self.topArray objectAtIndex:indexPath.item - 1] keywordId] integerValue];
            }
            
        }
       
        //将前一个item还原
        KHJNovelTopCollectionViewCell *topcell = (KHJNovelTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [topcell setDidSelected:NO];
        //获取当前点击的item
        KHJNovelTopCollectionViewCell *cell = (KHJNovelTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
        
        
        //点击item改变偏移量:
        if (indexPath.item > 1 && indexPath.item < self.topArray.count - 1) {
            [self.topCollectionView setContentOffset:CGPointMake((indexPath.item - 1) * (90 + 10) - 50, 0) animated:YES];
        }
        else if (indexPath.item == 1 || indexPath.item == 0)
        {
            [self.topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (indexPath.item == self.topArray.count - 1 || indexPath.item == self.topArray.count)
        {
            [self.topCollectionView setContentOffset:CGPointMake((self.topArray.count - 3) * (90 + 10) - 4, 0) animated:YES];
        }
        [self.mainCollectionView setContentOffset:CGPointMake(indexPath.item * ScreenWidth, 0)];
    }

}
//#pragma mark -- 滑动改变头部栏目的偏移量和当前栏
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.mainCollectionView) {
        if (scrollView.contentOffset.x / ScreenWidth >= 1) {
            //从网络请求列表内容数据:
            if (_model.idd == nil) {
                [self getMainCollectionData:[_model.categoryId integerValue] keyword:[[[self.topArray objectAtIndex:scrollView.contentOffset.x / ScreenWidth - 1] keywordId] integerValue] pNumber:1];
            }
            else{
                [self getMainCollectionData:[_model.idd integerValue] keyword:[[[self.topArray objectAtIndex:scrollView.contentOffset.x / ScreenWidth - 1] keywordId] integerValue] pNumber:1];
            }
            self.keyNumber = [[[self.topArray objectAtIndex:scrollView.contentOffset.x / ScreenWidth - 1] keywordId] integerValue];
             NSLog(@"2好的好的的%ld",_keyNumber);
          
        }
        
        if (scrollView.contentOffset.x / ScreenWidth > 1 && scrollView.contentOffset.x / ScreenWidth < self.topArray.count - 1) {
            [self.topCollectionView setContentOffset:CGPointMake((scrollView.contentOffset.x / ScreenWidth - 1) * (90 + 10) - 50, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / ScreenWidth == 1 || scrollView.contentOffset.x / ScreenWidth == 0)
        {
            [self.topCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (scrollView.contentOffset.x / ScreenWidth == self.topArray.count - 1 || scrollView.contentOffset.x / ScreenWidth == self.topArray.count)
        {
            [self.topCollectionView setContentOffset:CGPointMake((self.topArray.count - 3) * (90 + 10) - 4, 0) animated:YES];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / ScreenWidth inSection:0];
        //将前一个item复原:
        KHJNovelTopCollectionViewCell *lastCell = (KHJNovelTopCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedItem inSection:0]];
        [lastCell setDidSelected:NO];
        //获取当前点击的item:
        KHJNovelTopCollectionViewCell *cell = (KHJNovelTopCollectionViewCell *)[self.topCollectionView cellForItemAtIndexPath:indexPath];
        [cell setDidSelected:YES];
        _selectedItem = indexPath.item;
    }
}
//最上面的数据
- (void)getData{
    NSString *string = nil;
    if (_model.idd  == nil) {
     string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/keywords?categoryId=%ld&channel=and-d8&contentType=album&device=android&version=5.4.15",[_model.categoryId integerValue]];
    }
    if (_model.categoryId == nil) {
        string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/keywords?categoryId=%ld&channel=and-d8&contentType=album&device=android&version=5.4.15",[_model.idd integerValue]];
    }
#pragma mark -- 菊花加载
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
        [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
            NSDictionary *dic = result;
            [KHJArchiverTools archiverObject:dic ByKey:@"cate" WithPath:@"cate.plist"];
            NSArray *array = [dic objectForKey:@"keywords"];
            for (NSDictionary *dict in array) {
                KHJIDModel *model = [[KHJIDModel alloc] initWithDic:dict];
                [self.topArray addObject:model];
            }
            //模拟移除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.mbView hide:YES];
            });

            if (self.topArray.count != 0) {
                [self.topCollectionView reloadData];
                [self.mainCollectionView reloadData];
                
            }
            
        } failure:^(NSError *error) {
            NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"cate" WithPath:@"cate.plist"];
            NSArray *array = [dic objectForKey:@"keywords"];
            for (NSDictionary *dict in array) {
                KHJIDModel *model = [[KHJIDModel alloc] initWithDic:dict];
                [self.topArray addObject:model];
            }
            
            if (self.topArray.count != 0) {
                [self.topCollectionView reloadData];
                [self.mainCollectionView reloadData];
                
            }

            
            
        }];
    }
//大的collectionView的数据



- (void)getMainCollectionData:(NSInteger)iddd keyword:(NSInteger)keywordId pNumber:(NSInteger)pageNumber{
    if (pageNumber == 1) {
         self.mainArray = [NSMutableArray array];
    }
   
    NSString *string = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v2/category/keyword/albums?calcDimension=hot&categoryId=%ld&device=android&keywordId=%ld&pageId=%ld&pageSize=20&status=0&version=5.4.15",iddd,keywordId,pageNumber];
    /**
     *  菊花加载
     */
    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mbView.detailsLabelText = @"玩命加载中....";
        [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
            NSDictionary *dic = result;
            [KHJArchiverTools archiverObject:dic ByKey:@"dime" WithPath:@"dime.plist"];
            NSArray *listarray = [dic objectForKey:@"list"];
            for (NSDictionary *dict in listarray) {
                KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dict];
                [self.mainArray addObject:model];
            }
//            //模拟移除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.mbView hide:YES];
            });
            [self.mainCollectionView reloadData];
        } failure:^(NSError *error) {
         NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"dime" WithPath:@"dime.plist"];
            NSArray *listarray = [dic objectForKey:@"list"];
            for (NSDictionary *dict in listarray) {
                KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dict];
                [self.mainArray addObject:model];
            }
            
            [self.mainCollectionView reloadData];
            
        }];
}
#pragma mark -- 实现代理方法
- (void)getdelegateData:(NSInteger)page{
    if (_model.idd == nil) {
        [self getMainCollectionData:[_model.categoryId integerValue] keyword:_keyNumber pNumber:page];
//          NSLog(@"1好的好的的%ld",_keyNumber);
            }
    else{
        [self getMainCollectionData:[_model.idd integerValue] keyword:_keyNumber pNumber:page];
    }
}

#pragma  mark --//推荐的数据
- (void)getRecommendData{
//    self.mbView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.mbView.detailsLabelText = @"玩命加载中....";

    NSString *strin = nil;
    if (_model.idd == nil) {
     strin = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v3/category/recommends?categoryId=%ld&contentType=album&device=android&version=5.4.15",[_model.categoryId integerValue]];
    }
    if (_model.categoryId == nil) {
        strin = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v3/category/recommends?categoryId=%ld&contentType=album&device=android&version=5.4.15",[_model.idd integerValue]];

    }
    [KHJNetTool GET:strin body:nil headerFile:nil response:KHJJSON success:^(id result) {
            NSDictionary *dic = (NSDictionary *)result;
            [KHJArchiverTools archiverObject:dic ByKey:@"headdd" WithPath:@"headdd.plist"];
            //图片数组
            NSDictionary *dict = [dic objectForKey:@"focusImages"];
            NSArray *listArray = [dict objectForKey:@"list"];
            for (NSDictionary *listDic in listArray) {
                
                [self.headArray addObject:[listDic objectForKey:@"pic"]];
                //            NSLog(@"%@",self.headArray);
            }
            //下面tableView的数据
            NSDictionary *diction = [dic objectForKey:@"categoryContents"];
            NSArray *dicArray = [diction objectForKey:@"list"];
            for (NSDictionary *dictionary in dicArray) {
                if ([[dictionary objectForKey:@"moduleType"] integerValue] == 3 || [[dictionary objectForKey:@"moduleType"] integerValue] == 5 ) {
                    KHJNovelBigModel *bigModel = [[KHJNovelBigModel alloc] initWithDic:dictionary];
                    [self.tableViewArray addObject:bigModel];
                }
                
            }
        
            if (self.headArray.count) {
                [self.mainCollectionView reloadData];
                
            }
//        //模拟移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.mbView hide:YES];
//        });
//        [self.mbView hide:YES afterDelay:2];
        } failure:^(NSError *error) {
            NSDictionary *dic = [KHJArchiverTools unarchiverObjectByKey:@"headdd" WithPath:@"headdd.plist"];
            //图片数组
            NSDictionary *dict = [dic objectForKey:@"focusImages"];
            NSArray *listArray = [dict objectForKey:@"list"];
            for (NSDictionary *listDic in listArray) {
                
                [self.headArray addObject:[listDic objectForKey:@"pic"]];
                //            NSLog(@"%@",self.headArray);
            }
            //下面tableView的数据
            NSDictionary *diction = [dic objectForKey:@"categoryContents"];
            NSArray *dicArray = [diction objectForKey:@"list"];
            for (NSDictionary *dictionary in dicArray) {
                if ([[dictionary objectForKey:@"moduleType"] integerValue] == 3 || [[dictionary objectForKey:@"moduleType"] integerValue] == 5 ) {
                    KHJNovelBigModel *bigModel = [[KHJNovelBigModel alloc] initWithDic:dictionary];
                    [self.tableViewArray addObject:bigModel];
                }
                
            }
            if (self.headArray.count) {
            [self.mainCollectionView reloadData];
                
            }
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
