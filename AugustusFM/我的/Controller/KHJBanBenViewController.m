//
//  KHJBanBenViewController.m
//  AugustusFM
//
//  Created by dllo on 16/8/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBanBenViewController.h"

@interface KHJBanBenViewController ()

@end

@implementation KHJBanBenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"版本信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedButton)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 80) / 2, ScreenHeight * 0.13, 80, 80)];
    imageView.image = [UIImage imageNamed:@"2"];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 20, ScreenWidth, 40)];
    [self.view addSubview:label1];
    label1.text = @"iOS客户端  1.1";
    label1.textColor = [UIColor colorWithRed:0.205 green:0.219 blue:1.000 alpha:1.000];
    label1.textAlignment = 1;
    label1.font = [UIFont systemFontOfSize:25];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, label1.frame.origin.y + label1.frame.size.height + 20, ScreenWidth * 4 / 7.0, 30)];
    [self.view addSubview:label2];
    label2.text = @"研发人员:";
    label2.textAlignment = 2;
    label2.textColor = [UIColor colorWithRed:0.205 green:0.219 blue:1.000 alpha:1.000];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 4 / 7.0, label2.frame.origin.y, 90, 70)];
    [self.view addSubview:label3];
    label3.text = @"旷华军";
    label3.numberOfLines = 3;
    label3.textAlignment = 0;
    label3.textColor = [UIColor colorWithRed:0.205 green:0.219 blue:1.000 alpha:1.000];


}
- (void)didClickedButton{
    [self.navigationController popViewControllerAnimated:YES];
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
