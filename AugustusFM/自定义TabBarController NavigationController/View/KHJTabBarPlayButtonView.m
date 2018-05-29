//
//  KHJTabBarPlayButtonView.m
//  AugustusFM
//
//  Created by dllo on 16/7/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTabBarPlayButtonView.h"

@interface KHJTabBarPlayButtonView ()
//设置一个私有的定时器
@property (nonatomic, retain) CADisplayLink *timer;
@end

@implementation KHJTabBarPlayButtonView
- (void)dealloc{
    [_circleImageView release];
    [_contentImageView release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //布局
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        [self addSubview:backgroundImageView];
        [backgroundImageView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [backgroundImageView release];
        
        UIImageView *showImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_playshadow"]];
        [backgroundImageView addSubview:showImageView];
        [showImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundImageView).with.offset(0);
            make.centerX.equalTo(backgroundImageView.centerX).with.offset(0);
            make.width.equalTo(65);
            make.height.equalTo(65);
        }];
        [showImageView release];
        self.circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_loop"]];
        [backgroundImageView addSubview:_circleImageView];
        [_circleImageView release];
        
        [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(backgroundImageView.centerY).with.offset(0);
            make.centerX.equalTo(backgroundImageView.centerX).with.offset(0);
            make.width.equalTo(55);
            make.height.equalTo(55);
        }];

        //设置用户交互:
        backgroundImageView.userInteractionEnabled = YES;
        self.circleImageView.userInteractionEnabled = YES;
        
        //按钮被点击前:
        [self.playButton setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClicked:) name:@"good" object:nil];
        

        
    }
    return self;
}
- (void)didClicked:(NSNotification *)not{
    if ([not.object isEqualToString:@"pause"]) {
        [self.timer setPaused:NO];
        [self.playButton setImage:[UIImage imageNamed:@"toolbar_pause_h"] forState:UIControlStateNormal];
    }
    else{
        [self.timer setPaused:YES];
         [self.playButton setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
    }
}
/**
 *  背景图旋转
 */
- (void)rotation{
    self.circleImageView.layer.transform = CATransform3DRotate(self.circleImageView.layer.transform, AngleToRadian(72 / 60.0), 0, 0, 1);
}
#pragma mark - 播放按钮和专辑图片CADisplayLink定时器懒加载
- (UIButton *)playButton {
    if (!_playButton) {
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 去掉长按高亮
        [_playButton setHighlighted:NO];
        
        // 被点击后 "avatar_bg" 透明
//        [_playButton setBackgroundImage:[UIImage imageNamed:@"avatar_bg"] forState:UIControlStateSelected];//168*168
//        [_playButton setImage:[UIImage imageNamed:@"toolbar_pause_h"] forState:UIControlStateSelected];//110*110
        [self addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY).offset(0);
            make.centerX.equalTo(self.centerX).offset(0);
            make.width.equalTo(55);
            make.height.equalTo(55);
        }];
        
        // 按钮点击后做的方法
        [_playButton addTarget:self action:@selector(didClickedPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
#pragma mark -- 点击播放按钮:
- (void)didClickedPlayButton:(UIButton *)sender
{
    // 点击和不点击时图交换
    if ([self.delegate respondsToSelector:@selector(playButtonDidClick:)]) {
        sender.selected = !sender.selected;
        self.timer.paused = !sender.selected;
        
        [self.delegate playButtonDidClick:sender.selected];
    }
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        // 声明一个内容视图, 并约束好位置
        _contentImageView = [[UIImageView alloc] init];
        // 绑定到圆视图
        [self.circleImageView addSubview:_contentImageView];
        //        [_contentImageView release];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
        // KVO观察image变化,变化了就启动定时器
        [self.contentImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        
        // 作圆内容视图背景
        self.contentImageView.layer.cornerRadius = 22.5;
        self.contentImageView.clipsToBounds = YES;
    }
    return _contentImageView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"]) {
        // 启动定时器
        self.playButton.selected = YES;
        self.timer.paused = NO;
    }
}

- (CADisplayLink *)timer
{
    if (!_timer) {
        // 创建定时器, 一秒钟调用rotation方法60次
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotation)];
        // 手动将定时器加入到事件循环中
        // NSRunLoopCommonModes会使得RunLoop会随着界面切换扔继续使用, 不然如果使用Default的话UI交互没问题, 但滑动TableView就会出现不转问题, 因为RunLoop模式改变会影响定时器调度
        [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _timer;
}



@end
