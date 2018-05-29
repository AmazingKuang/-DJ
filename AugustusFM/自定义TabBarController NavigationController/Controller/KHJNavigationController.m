//
//  KHJNavigationController.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNavigationController.h"
#import "KHJPlayerMusiciViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+WebCache.h>
#import "KHJTabBarPlayButtonView.h"
#import "JXLDayAndNightMode.h"
@interface KHJNavigationController ()<KHJTabBarPlayButtonViewDelegate>
@property (nonatomic, retain) KHJTabBarPlayButtonView *playView;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) NSURL *musicURL;



@end

@implementation KHJNavigationController
- (void)dealloc{
    [_player release];
    [_musicURL release];
    [_playView release];
    //关闭消息中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 防止其他ViewController的导航被遮挡
    self.navigationBarHidden = YES;
    
    // 开启两个通知接收(LXMyCenterViewController传入)
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePlayView:) name:@"hidePlayView" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPlayView:) name:@"showPlayView" object:nil];
    
    // 开启一个通知接受,播放URL及图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingWithInfoDictionary:) name:@"BeginPlay" object:nil];
    
    self.playView = [[KHJTabBarPlayButtonView alloc] init];
    self.playView.delegate = self;
    [self.view addSubview:_playView];
    [_playView release];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
  
    
  }

// 隐藏图片
- (void)hidePlayView:(NSNotification *)notification
{
    self.playView.hidden = YES;
}

// 显示图片
- (void)showPlayView:(NSNotification *)notification
{
    self.playView.hidden = NO;
}

/** 通过播放地址 和 播放图片 */
- (void)playingWithInfoDictionary:(NSNotification *)notification {
    // 设置背景图
    NSURL *coverURL = notification.userInfo[@"coverURL"];
    self.musicURL = notification.userInfo[@"musicURL"];
    [self.playView.contentImageView sd_setImageWithURL:coverURL placeholderImage:nil options:SDWebImageRetryFailed];
    
    // 支持后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    // 开始播放
    self.player = [AVPlayer playerWithURL:self.musicURL];
    [self.player play];
    
    // 已改到背景变化时再变化
        self.playView.playButton.selected = YES;
}

#pragma mark - PlayView的代理方法
- (void)playButtonDidClick:(BOOL)selected {
    // 按钮被点击方法, 判断按钮的selected状态
    if (selected)
    {
        [self.player play];  // 继续播放
    }
    else
    {
        [self.player pause];  // 暂停播放, 以后会取消, 此处应该是跳转最后一个播放器控制器
    }
    if (self.musicURL == nil) {
        KHJPlayerMusiciViewController *sdVC = [KHJPlayerMusiciViewController shareDetailViewController];
        [self presentViewController:sdVC animated:YES completion:^{
            
        }];
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
