//
//  KHJ360ViewController.m
//  AugustusFM
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJ360ViewController.h"
#import "KHJNetTool.h"
#import "KHJ360Cell.h"
#import "KHJ360Model.h"
#import "KHJNavigationController.h"
@interface KHJ360ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arrayArr;

@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, retain) UIView *shareLineView;

@end



@implementation KHJ360ViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.title = @"360全景";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:19]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_n-1"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButtonItem:)];
}
- (void)didClickedBarButtonItem:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayArr = [NSMutableArray array];
   
    [self createViewandButton];
    [self createTablkeView];
    [self getTimeData];
}

- (void)createViewandButton{
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    timeButton.frame = CGRectMake(20, 0, ScreenWidth / 2 - 40, 30);
    [timeButton setTitle:@"按时间排序" forState:UIControlStateNormal];
    [timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timeButton addTarget:self action:@selector(didClickedtimeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeButton];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(50, 32, ScreenWidth / 2 - 100, 2)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_lineView];
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(ScreenWidth / 2 + 20, 0, ScreenWidth / 2 - 40, 30);
    [shareButton setTitle:@"按分享排序" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(didClickedShareButton:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.backgroundColor = [UIColor whiteColor];
    [self.view
     addSubview:shareButton];
    
    
    
    self.shareLineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 + 50, 32, ScreenWidth / 2 - 100, 2)];
    self.shareLineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_shareLineView];
    
}
- (void)createTablkeView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight - 64 - 40 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册cell
    [self.tableView registerClass:[KHJ360Cell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJ360Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [_arrayArr objectAtIndex:indexPath.row];
      return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}


- (void)didClickedtimeButton:(UIButton *)button{
    self.lineView.backgroundColor = [UIColor redColor];
    self.shareLineView.backgroundColor = [UIColor whiteColor];
    [self getTimeData];
}
- (void)didClickedShareButton:(UIButton *)button{
    self.lineView.backgroundColor = [UIColor whiteColor];
    self.shareLineView.backgroundColor = [UIColor redColor];
    [self getShareData];

}
#pragma mark -- 按时间排序的数据
- (void)getTimeData{
    [self.arrayArr removeAllObjects];
    NSString *string = @"http://baobab.wandoujia.com/api/v3/tag/videos?_s=386bf90e93cefc83af4966e84a6613f7&f=iphone&net=wifi&num=20&start=0&strategy=date&tagId=658&u=5b2b224c5b00b628366a35564c3ec03138d4cdfb&v=2.4.0&vc=1014";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        NSArray *tempArray = [dic objectForKey:@"itemList"];
        for (NSDictionary *dict in tempArray) {
            KHJ360Model *model = [[KHJ360Model alloc] initWithDic:dict];
            [self.arrayArr addObject:model];
        }
     
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark --- 按分享排序
- (void)getShareData{
    [self.arrayArr removeAllObjects];
    NSString *string = @"http://baobab.wandoujia.com/api/v3/tag/videos?_s=3809ac7b60d9253401b0af0ced2bae75&f=iphone&net=wifi&num=20&start=0&strategy=shareCount&tagId=658&u=5b2b224c5b00b628366a35564c3ec03138d4cdfb&v=2.4.0&vc=1014";
    [KHJNetTool GET:string body:nil headerFile:nil response:KHJJSON success:^(id result) {
        NSDictionary *dic = result;
        NSArray *array = [dic objectForKey:@"itemList"];
        for (NSDictionary *dict in array) {
            KHJ360Model *model = [[KHJ360Model alloc] initWithDic:dict];
            [self.arrayArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}




@end
