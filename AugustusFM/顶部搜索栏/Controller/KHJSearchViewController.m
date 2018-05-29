//
//  KHJSearchViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSearchViewController.h"
#import "KHJBaseView.h"
#import "KHJSearchHotContentCollectionViewCell.h"
#import "KHJNetTool.h"
#import "KHJNoDataSearchView.h"
#import "KHJSearchContentTableViewCell.h"
#import "KHJSearchModel.h"
#import "KHJDetailRecommend.h"
#import "KHJspecialDetailViewController.h"
#import "JXLDayAndNightMode.h"
@interface KHJSearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
//搜索页面视图
@property (nonatomic, retain) UITableView *tableView;
//搜索页面结合视图
@property (nonatomic, retain) UICollectionView *collectionView;
/** 没有数据时视图 */
@property(nonatomic, retain)KHJNoDataSearchView *noDataSearchView;
//数据源数组
@property (nonatomic, retain) NSMutableArray *arrForSearch;

/** 搜索栏 */
@property (nonatomic, retain) UISearchBar *search;
/** 取消返回按钮 */
@property (nonatomic, retain) UIButton *backButton;
/** 搜索文字 */
@property (nonatomic, copy) NSString *searchText;
/** 热搜视图 */
@property(nonatomic, retain)KHJBaseView *hotSearchView;
/** 热搜文字数组 */
@property(nonatomic, retain)NSMutableArray *hotSearchDataSource;


@end


@implementation KHJSearchViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (void)dealloc {
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    [_tableView release];
    [_collectionView release];
    [_arrForSearch release];
    [_search release];
    [_hotSearchView release];
    [_noDataSearchView release];
    [_hotSearchDataSource release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadView
{
    [super loadView];
    //交互返回手势,自定义导航栏按钮后也可以用返回手势:
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    //创建搜索栏:
    [self createSearchBar];
    //创建根视图:
    [self createTableView];
    //创建热搜集合视图:
    [self createCollectionView];
    //创建没有数据页面视图:
    [self showNoDataSearchView];
    self.tableView.hidden = YES;
    
    self.hotSearchDataSource = [NSMutableArray array];
    //请求热搜词:
    [self getDataFromNet];
    
    [self.view jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _hotSearchView.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        _tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
         _collectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _hotSearchView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];

    }];
    
    
    
    
    
}

#pragma mark -- 创建搜索栏:
- (void)createSearchBar {
    
    KHJBaseView *topView = [[KHJBaseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64 * lFitHeight)];
    [self.view addSubview:topView];
    [topView release];
    
    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(10 * lFitWidth, 20 * lFitHeight, ScreenWidth - 60 * lFitWidth, 44 * lFitHeight)];
    self.search.backgroundImage = [[UIImage alloc] init];
    [topView addSubview:self.search];
    [self.search release];
    
    UITextField *searchField = [self.search valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f * lFitHeight;
        searchField.layer.borderColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1].CGColor;
        searchField.font = [UIFont systemFontOfSize:17 * lFitWidth];
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    self.search.placeholder = @"搜索想听的声音";
    self.search.delegate = self;
    [self.search becomeFirstResponder];
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.backButton];
    self.backButton.frame = CGRectMake(ScreenWidth - 50 * lFitWidth, 20 * lFitHeight, 50 * lFitWidth, 44 * lFitHeight);
    
    [self.backButton setTitle:@"取消" forState:UIControlStateNormal];
    self.backButton.font = [UIFont systemFontOfSize:17 * lFitWidth];
    [self.backButton setTitleColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 创建热搜集合视图:
- (void)createCollectionView
{
    self.hotSearchView = [[KHJBaseView alloc] initWithFrame:CGRectMake(0, 64 * lFitHeight, ScreenWidth, ScreenHeight - 64 * lFitHeight)];
    [self.view addSubview:_hotSearchView];
    [_hotSearchView release];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"大家都在搜的";
    label.font = [UIFont systemFontOfSize:11 * lFitHeight];
    [self.hotSearchView addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotSearchView).with.offset(20 * lFitWidth);
        make.top.equalTo(self.hotSearchView).with.offset(20 * lFitHeight);
        make.width.equalTo(200 * lFitWidth);
        make.height.equalTo(20 * lFitHeight);
    }];
    [label release];
    
    //创建一个系统提供的布局对象:
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置每个单元格的尺寸:
    flowLayOut.itemSize = CGSizeMake(100 * lFitWidth , 25 * lFitHeight);
    //最小列间距:
    flowLayOut.minimumInteritemSpacing = 10 * lFitHeight;
    //最小行间距:
    flowLayOut.minimumLineSpacing = 10 * lFitWidth;
    //设置内容区域与周围的距离;
    flowLayOut.sectionInset = UIEdgeInsetsMake(0, 20 * lFitHeight, 0, 20 * lFitHeight);
    //设置滚动方向:
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //初始化collectionView:
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50 * lFitHeight) collectionViewLayout:flowLayOut];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //设置代理人:
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //取消垂直滚动条:
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.hotSearchView addSubview:_collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotSearchView).with.offset(0);
        make.right.equalTo(self.hotSearchView).with.offset(0);
        make.top.equalTo(self.hotSearchView).with.offset(50 * lFitHeight);
        make.bottom.equalTo(self.hotSearchView).with.offset(0);
    }];
    [_collectionView release];
    [flowLayOut release];
    //注册cell:
    [self.collectionView registerClass:[KHJSearchHotContentCollectionViewCell class] forCellWithReuseIdentifier:@"hotCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotSearchDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KHJSearchHotContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
    if (self.hotSearchDataSource.count) {
        cell.label.text = [self.hotSearchDataSource objectAtIndex:indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchText = [self.hotSearchDataSource objectAtIndex:indexPath.item];
    self.hotSearchView.hidden = YES;
    self.tableView.hidden = NO;
    self.noDataSearchView.hidden = YES;
    self.search.text = self.searchText;
    [self getSearchContentWithText:self.searchText];
}

#pragma mark -- 从网络请求热门搜索数据:
- (void)getDataFromNet
{
    NSString *string = @"http://mobile.ximalaya.com/m/hot_search_keys?device=iPhone";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        self.hotSearchDataSource = [result objectForKey:@"keys"];
       
        [self.collectionView reloadData];

    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- 取消按钮:
- (void)handleButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
    self.search.hidden = YES;
    self.backButton.hidden = YES;
}

#pragma mark -- 创建根视图:
- (void)createTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    [self.tableView release];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[KHJSearchContentTableViewCell class] forCellReuseIdentifier:@"searchTableViewCell"];
    
    
    
}

#pragma mark -- 没有数据页面:
- (void)showNoDataSearchView
{
    self.noDataSearchView = [[KHJNoDataSearchView alloc] init];
    [self.tableView addSubview:_noDataSearchView];
    [self.noDataSearchView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(64 * lFitHeight);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    [_noDataSearchView release];
}

#pragma mark -- cell行数:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.arrForSearch.count != 0) {
        self.noDataSearchView.hidden = YES;
    }
    else
    {
        self.noDataSearchView.hidden = NO;
    }
    return self.arrForSearch.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 * lFitHeight;
}

#pragma mark -- cell内容:
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHJSearchContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.searchText = self.searchText;
    cell.model = [self.arrForSearch objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    KHJDetailRecommend *model = [self.arrForSearch objectAtIndex:indexPath.row];
    //跳转到公用专辑页面;
    KHJspecialDetailViewController *apVC = [[KHJspecialDetailViewController alloc] init];
    apVC.model = model;
    [self.navigationController pushViewController:apVC animated:YES];
    [apVC release];
}
//
#pragma mark -- 搜索文字并跳转:
- (void)getSearchContentWithText:(NSString *)text
{
    self.arrForSearch = [NSMutableArray array];
    NSString *string = [NSString stringWithFormat:@"http://search.ximalaya.com/suggest?device=iPhone&kw=%@",text];
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSArray *arrTemp = [result objectForKey:@"albumResultList"];
        for (NSDictionary *dic in arrTemp) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dic];
            [self.arrForSearch addObject:model];
            [model release];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- 搜索栏文字改变:
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchText = searchText;
    if (searchText.length == 0) {
        self.tableView.hidden = YES;
        self.hotSearchView.hidden = NO;
    }
    else
    {
        self.hotSearchView.hidden = YES;
        self.tableView.hidden = NO;
        self.noDataSearchView.hidden = YES;
        
    }
    [self getSearchContentWithText:searchText];
}

- (void)viewWillDisappear:(BOOL)animated {
    // 键盘回收.
    [self.search endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
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
