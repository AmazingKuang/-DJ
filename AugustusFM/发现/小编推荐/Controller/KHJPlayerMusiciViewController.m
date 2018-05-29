//
//  KHJPlayerMusiciViewController.m
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJPlayerMusiciViewController.h"
#import <UIImageView+WebCache.h>
#import "AudioPlayerManager.h"
#import "KHJMusicPlayView.h"
#import "KHJMusicSliderView.h"
#import "KHJNetTool.h"
#import "KHJSoundTopView.h"
#import "CALayer+PauseAimate.h"

@interface KHJPlayerMusiciViewController ()<AudioPlayerManagerDelegate>
/** 背景图片 */
@property(nonatomic, retain) UIImageView *backgroundImageView;
/** 顶部专辑信息视图 */
@property(nonatomic, retain) KHJSoundTopView *topView;
/** 中间歌曲信息视图 */
@property(nonatomic, retain)UIImageView *songImageView;
// 播放视图的view
@property (nonatomic, retain) KHJMusicPlayView *playView;
// 进度条的view
@property (nonatomic, retain) KHJMusicSliderView *musicSlider;
// 音乐播放器
@property (nonatomic, retain) AudioPlayerManager *playerManager;

@end

@implementation KHJPlayerMusiciViewController
- (void)dealloc
{
    [_backgroundImageView release];
    [_topView release];
    [_playView release];
    [_songImageView release];
    [_musicSlider release];
    [_musicArr release];
    [_playerManager release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    
}

+ (KHJPlayerMusiciViewController *)shareDetailViewController{
    static KHJPlayerMusiciViewController *detail = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        detail = [[KHJPlayerMusiciViewController alloc] init];
    });
    return detail;

}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.playerManager = [AudioPlayerManager shareAudioPlayerManager];
        self.playerManager.delegate = self;
    }
    return self;
}


- (void)createView{
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_bg2"]];
    [self.view addSubview:_backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    [_backgroundImageView release];
    
    // 设置毛玻璃效果
    [self setBlurView];
    
    //顶部歌曲信息视图:
    self.topView = [[KHJSoundTopView alloc] init];
    self.topView.goBackBlock = ^(void)
    {
        NSString *state = @"";
        if (self.playerManager.rate == 0) {
            state = @"playing";
        } else {
            state = @"pause";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"good" object:state];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
};
    [self.view addSubview:_topView];
    [self.topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(20 * lFitHeight);
        make.height.equalTo(60 * lFitHeight);
    }];
    self.topView.model = self.model;
    [_topView release];
    
    //中间图片视图:
    self.songImageView = [[UIImageView alloc] init];
    [self.view addSubview:_songImageView];
    [self.songImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.bottom).with.offset(70 * lFitHeight);
        make.centerX.equalTo(self.view.centerX).with.offset(0);
        make.height.width.equalTo(280 * lFitWidth);
    }];
    self.songImageView.layer.cornerRadius = 140 * lFitHeight;
    self.songImageView.clipsToBounds = YES;
    self.songImageView.layer.borderWidth = 7 * lFitHeight;
    self.songImageView.layer.borderColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.0].CGColor;
    [_songImageView release];
    [self.songImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    
//#pragma mark 进度条视图
    self.musicSlider = [[KHJMusicSliderView alloc] init];
    [self.view addSubview:_musicSlider];
    [self.musicSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10 * lFitWidth);
        make.height.equalTo(40 * lFitHeight);
        make.right.equalTo(self.view).with.offset(-10 * lFitWidth);
        make.bottom.equalTo(self.view).with.offset(-124 * lFitHeight);
    }];
    [_musicSlider release];
    [self.musicSlider sliderThumb:@"player_slider_playback_thumb" maximumTrackImage:@"player_slider_playback_right" minimumTrackImage:@"player_slider_playback_left"];
    [self.musicSlider musicOverallValue:[self.model.duration floatValue]];
    
#pragma mark 播放控制视图
    self.playView = [[KHJMusicPlayView alloc] init];
    [self.view addSubview:_playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(64 * lFitHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-50 * lFitWidth);
    }];
    [_playView release];
   
#pragma mark 播放控制视图的播放和暂停
    __block KHJPlayerMusiciViewController *mdVC = self;
    [self.playView playImage:@"player_btn_play_normal" pause:@"player_btn_pause_normal" play:^(UIButton *play) {
        // 播放音频
        [mdVC.playerManager play];
        [mdVC.songImageView.layer resumeAnimate];
//         添加进度监听定时器
        [mdVC.musicSlider addPlayerTimer];
//        [self.musicSlider playerSlider];

    } pause:^(UIButton *pause) {
        // 暂停音频
        [mdVC.playerManager pause];
        [mdVC.songImageView.layer pauseAnimate];
        // 移除进度监听定时器
        [self.musicSlider removePlayerTimer];
    }];
    // 下一曲
    [self.playView nextImage:@"player_btn_next_normal" nextMusic:^(UIButton *next) {
        _index++;
      
        if (_index >= mdVC.musicArr.count) {
            _index = mdVC.musicArr.count - 1;
            [self changeMusicAlert:@"已经为最后一曲"];
        } else {
            mdVC.model = mdVC.musicArr[_index];
        }
    }];
//     上一曲
    [self.playView previousImage:@"player_btn_pre_normal" previousMusic:^(UIButton *previous) {
        _index--;
        if (_index < 0) {
            _index = 0;
            [mdVC changeMusicAlert:@"当前为第一曲"];
        } else {
            mdVC.model = mdVC.musicArr[_index];
        }
    }];
    
#pragma mark 音频播放进行时修改进度条位置
    [self.musicSlider playerSliderValue:^(UISlider *slider) {
        float value = CMTimeGetSeconds(mdVC.playerManager.currentItem.currentTime);
        slider.value = value;
        [mdVC.musicSlider currentValue:value];
    }];
    
#pragma mark 拖动进度条修改音频位置
    [self.musicSlider changeSliderValue:^(CGFloat value) {
        [mdVC.musicSlider removePlayerTimer];
        [mdVC.playerManager pause];
        [mdVC.playerManager seekToTime:CMTimeMakeWithSeconds(value, mdVC.playerManager.currentTime.timescale) completionHandler:^(BOOL finished) {
            if (finished) {
                [mdVC.playerManager play];
                [mdVC.musicSlider addPlayerTimer];
            }
        }];
    }];
  
}


#pragma mark -- 背景毛玻璃:
- (void)setBlurView
{
    UIToolbar *blurView = [[UIToolbar alloc] init];
    blurView.barStyle = UIBarStyleBlack;
    blurView.frame = self.view.bounds;
    [self.backgroundImageView addSubview:blurView];
    [blurView release];
}

#pragma mark -- 播放音乐:
- (void)playSounds
{
    self.topView.model = self.model;
//    self.topView
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    [self.songImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    // 播放
    self.playView.play = YES;
    [self addIconViewAnimate];
    // 播放音频
    if (_model.playPathAacv224 == nil) {
        [self.playerManager playerPlayWithUrl:self.model.playPath64];

    }
    else{
       [self.playerManager playerPlayWithUrl:self.model.playPathAacv224];
    }
}

#pragma mark -- 重新给歌曲信息赋值并停止上一曲,播放当前歌曲:
- (void)setModel:(KHJParticularsModel *)model
{
    if (model != _model) {
        [_model release];
        _model = [model retain];
        if (self.musicSlider) {
            [self.musicSlider musicOverallValue:[self.model.duration integerValue]];
        }
        [self playerStop];
        [self playSounds];
    }
}
#pragma mark -- 播放器暂停播放:
- (void)playerStop
{
    // 让播放器终止
    [self.playerManager stop];
    // 清除播放状态
    [self.musicSlider playStatusClear];

    //设置播放的按钮为要播放状态
    self.playView.play = NO;
}
#pragma mark -- 播放器的协议停止方法
- (void)didFinshPlay
{
    if (_musicArr) {
        [self playerStop];
        _index = _index + 1;
        if (_index >= self.musicArr.count) {
            _index = 0;
        }
        self.model = [self.musicArr objectAtIndex:_index];
    }
}
#pragma mark -- 播放到最后或最前提示:
- (void)changeMusicAlert:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- 给图片层添加动画:
- (void)addIconViewAnimate
{
    // 1.创建基本动画
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 2.给动画设置一些属性
    rotationAnim.fromValue = @(0);
    rotationAnim.toValue = @(M_PI * 2);
    rotationAnim.repeatCount = NSIntegerMax;
    rotationAnim.duration = 35;
    // 3.将动画添加到iconView的layer上面
    [self.songImageView.layer addAnimation:rotationAnim forKey:nil];
}
#pragma mark -- 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    //给songView添加动画
    [self addIconViewAnimate];
    self.playView.play = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
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
