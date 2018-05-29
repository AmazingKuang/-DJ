//
//  KHJSubscibeViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSubscibeViewController.h"
#import "KHJDataBaseTool.h"
#import "KHJSubScibeTableViewCell.h"
#import "KHJspecialDetailViewController.h"
#import "KHJCollectreCommendViewController.h"
#import "KHJTwoSubScibeTableViewCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJSubscibeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *dataArr;
//完成时的图片
@property (nonatomic, retain) UIView *secondView;


@end

@implementation KHJSubscibeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"订阅听";
    
    [self.navigationController.navigationBar jxl_setDayMode:^(UIView *view) {
        UINavigationBar *bar = (UINavigationBar *)view;
        // 改变状态栏前景色为黑色
        bar.barStyle = UIBarStyleDefault;
        bar.barTintColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    } nightMode:^(UIView *view) {
        
        UINavigationBar *bar = (UINavigationBar *)view;
        // 改变状态栏前景色为白色
        bar.barStyle = UIBarStyleBlack;
        bar.barTintColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];
    
    [self createSubView];
}
+ (UINavigationController *)defaultSubscibeViewUINavigationController{
    static UINavigationController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KHJSubscibeViewController *vc= [[KHJSubscibeViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [vc release];
        });
    return nav;
}
- (void)getData{
    KHJDataBaseTool *dataTool = [KHJDataBaseTool shareInstance];
    self.dataArr = (NSMutableArray *)[dataTool selectAll];
    [self.tableView reloadData];
}
- (void)createSubView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 * lFitHeight)];
    headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00];
    
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150 * lFitWidth, 13 * lFitHeight, 100 * lFitWidth, 15 * lFitHeight)];
    nameImageView.image = [UIImage imageNamed:@"btn_downloadsound_clear_h"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedTap:)];
    nameImageView.userInteractionEnabled = YES;
    [nameImageView addGestureRecognizer:tap];
    [headerView addSubview:nameImageView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.tableHeaderView = headerView;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    /**
     夜间模式
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
          self.tableView.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
       
        self.tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
        

        
    }];

    //注册cell
    [self.tableView registerClass:[KHJSubScibeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[KHJTwoSubScibeTableViewCell class] forCellReuseIdentifier:@"twoCell"];
}
- (void)didClickedTap:(UITapGestureRecognizer *)tap{
    if (self.dataArr.count != 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要全部清除?" preferredStyle:UIAlertControllerStyleAlert];
        alertController.modalPresentationStyle = UIModalPresentationFullScreen;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            KHJDataBaseTool *dataTool = [KHJDataBaseTool shareInstance];
            [dataTool removeAllData];
            [self.dataArr removeAllObjects];
            [self.tableView reloadData];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [alertController addAction:action2];
        //显示
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"亲,伦家清理完了😊" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action1];
        
        //显示
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return 1;
    }
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count == 0) {
        KHJTwoSubScibeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        //        [cell addSubview:_secondView];
        cell.bigImageView.image = [UIImage imageNamed:@"noData_subscription"];
        void (^bld) (KHJCollectreCommendViewController * ) = ^(KHJCollectreCommendViewController *vvc){
            [self.navigationController pushViewController:vvc animated:YES];
        };
        cell.block = bld;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    KHJSubScibeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据中的对应元素
        KHJDataBaseTool *dataBase = [KHJDataBaseTool shareInstance];
        [dataBase deleteDataWithModel:[[self.dataArr objectAtIndex:indexPath.row] albumId]];
        [self getData];
        //刷新
        [tableView reloadData];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count == 0) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count == 0) {
        return 350 * lFitHeight;
    }
    
    return 100  * lFitHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count != 0) {
        KHJspecialDetailViewController *khjv = [[KHJspecialDetailViewController alloc] init];
        khjv.model = [self.dataArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:khjv animated:YES];
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
