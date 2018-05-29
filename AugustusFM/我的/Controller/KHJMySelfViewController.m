//
//  KHJMySelfViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJMySelfViewController.h"
#import "KHJMySelfTableCell.h"
#import <SDImageCache.h>
#import "JXLDayAndNightMode.h"
#import "KHJBanBenViewController.h"
#import "KHJDutyViewController.h"
@interface KHJMySelfViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation KHJMySelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [self createTableView];
}
+ (UINavigationController *)defaultMySelfNavigationController{
    static UINavigationController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        KHJMySelfViewController *mySelfVc = [[KHJMySelfViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:mySelfVc];
        [mySelfVc release];
    });
    return nav;
}
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //图片下拉放大
    //设置tableview的contentView距离上边界200
    //相对于0点,已经向下偏移了-200

    self.tableView.contentInset = UIEdgeInsetsMake(200.0 * lFitHeight + 64, 0, 0, 0);
    //相对于0点,图片坐标应该是(0,-200)
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -100.0 * lFitHeight, self.view.frame.size.width, 100 * lFitHeight)];
    self.imageView.image = [UIImage imageNamed:@"2"];
    //设置imageView高度改变时宽度也跟着改变
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:_imageView];
    
    [_imageView release];

    //
    [self.tableView registerClass:[KHJMySelfTableCell class] forCellReuseIdentifier:@"cell"];
    
    
    /**
     夜间模式
     */
    [self.view jxl_setDayMode:^(UIView *view) {
        
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
       
    } nightMode:^(UIView *view) {
        
        // 设置夜间模式状态
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
       
    }];

    [_tableView jxl_setDayMode:^(UIView *view) {
         _tableView.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
         _tableView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
    }];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //刚开始y的偏移量初始值就是-264
//    NSLog(@"y1 === %f",scrollView.contentOffset.y);
    CGFloat y = scrollView.contentOffset.y + 64;//加上导航栏高度,第一次是-200
//    NSLog(@"y2 === %f",y);
    
    if (y < -100 * lFitHeight) {
        CGRect frame = self.imageView.frame;
        frame.origin.y = y;//偏移了多少,
        frame.size.height =  -y;//tablview向下偏移了多少,高度就是多少
        self.imageView.frame = frame;
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJMySelfTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.item == 0) {
        cell.nameImageVIew.image = [[UIImage imageNamed:@"Unknown-6"] imageWithRenderingMode:1];
        cell.nameLabel.text = @"清理缓存";
        cell.turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];

    }
    if (indexPath.item == 1) {
        cell.nameImageVIew.image = [[UIImage imageNamed:@"Unknown-2"] imageWithRenderingMode:1];
        cell.nameLabel.text = @"夜间模式";
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(350 * lFitWidth, 10 * lFitHeight, 60 * lFitWidth, 30 * lFitHeight)];
        [cell addSubview:switchView];
        if (JXLDayAndNightModeDay == [[JXLDayAndNightManager shareManager] contentMode]) {
            switchView.on = NO;
        } else {
            switchView.on = YES;
        }
        [switchView addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
        [self.view jxl_setDayMode:^(UIView *view) {
            self.view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        }];

        
    }
    if (indexPath.item == 2) {
        cell.nameImageVIew.image = [UIImage imageNamed:@"Unknown5"];
        cell.nameLabel.text = @"版本信息";
        cell.turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];

    }
    if (indexPath.item == 3) {
        cell.nameImageVIew.image = [UIImage imageNamed:@"Unknown-3"];
        cell.nameLabel.text = @"免责声明";
        cell.turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
    }
    
    return cell;
}
- (void)switchValueChange:(UISwitch *)switchView {
    if (switchView.on) {
        
        [[JXLDayAndNightManager shareManager] nightMode];
    } else {
        [[JXLDayAndNightManager shareManager] dayMode];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        SDImageCache *sdimage = [[SDImageCache alloc] init];
        NSString *string =[NSString stringWithFormat:@"当前缓存大小为%.2fM,是否确认清理?",[sdimage checkTmpSize]];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:string preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [[SDImageCache sharedImageCache] clearDisk];
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [alertController addAction:action2];
        //显示
        [self presentViewController:alertController animated:YES completion:nil];

    }
    if (indexPath.item == 2) {
        KHJBanBenViewController *bazn = [[KHJBanBenViewController alloc] init];
        [self.navigationController pushViewController:bazn animated:YES];
    }
    if (indexPath.item == 3) {
        KHJDutyViewController *vc = [[KHJDutyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
