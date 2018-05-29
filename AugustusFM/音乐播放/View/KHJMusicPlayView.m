//
//  KHJMusicPlayView.m
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJMusicPlayView.h"

@interface KHJMusicPlayView ()
@property (nonatomic, copy) void (^clickedPlay)(UIButton *play);
@property (nonatomic, copy) void (^clickedPause)(UIButton *pause);
@property (nonatomic, copy) void (^clickedNext)(UIButton *next);
@property (nonatomic, copy) void (^clickedPrevious)(UIButton *previous);

@property (nonatomic, copy) NSString *playImage;
@property (nonatomic, copy) NSString *pauseImage;
@property (nonatomic, copy) NSString *nextImage;
@property (nonatomic, copy) NSString *previousImage;
@end

@implementation KHJMusicPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //播放按钮
        // 播放按钮
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
        // 上一曲
        self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_previousButton];
        // 下一曲
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextButton];
        // 让播放按钮的中心点位于该view的中间
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.center);
            make.size.mas_equalTo(CGSizeMake(64, 64));
        }];
        // 上一曲按钮中心点与播放按钮一样
        // x相对于播放按钮左边偏移40
        [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playButton.centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(64, 64));
            make.right.equalTo(self.playButton.mas_left).with.offset(-25);
        }];
        // 下一曲
        // x相对于播放按钮的右边偏移40
        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playButton.centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(64, 64));
            make.left.equalTo(self.playButton.mas_right).with.offset(25);
        }];
        
        
    }
    return self;
}

- (void)playImage:(NSString *)playImage pause:(NSString *)pauseImage play:(void (^)(UIButton *play))clickPlay pause:(void (^)(UIButton *pause))clickPause{
    self.playImage = playImage;
    self.pauseImage = pauseImage;
    [self.playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPlay = clickPlay;
    self.clickedPause = clickPause;
}
- (void)playAction:(UIButton *)button{
    [button setImage:[UIImage imageNamed:self.pauseImage] forState:UIControlStateNormal];
    [button removeTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPlay(button);
}
- (void)pauseAction:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:self.playImage] forState:UIControlStateNormal];
    [button removeTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPause(button);
}

- (void)nextAction:(UIButton *)button
{
    self.clickedNext(button);
}
- (void)nextImage:(NSString *)nextImage nextMusic:(void (^)(UIButton *next))clickNext
{
    self.nextImage = nextImage;
    [self.nextButton setBackgroundImage:[UIImage imageNamed:nextImage] forState:UIControlStateNormal];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:nextImage] forState:UIControlStateHighlighted];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedNext = clickNext;
}

- (void)previousImage:(NSString *)previousImage previousMusic:(void (^)(UIButton *previous))clickPrevious
{
    self.previousImage = previousImage;
    [self.previousButton setBackgroundImage:[UIImage imageNamed:previousImage] forState:UIControlStateNormal];
    [self.previousButton setBackgroundImage:[UIImage imageNamed:previousImage] forState:UIControlStateHighlighted];
    [self.previousButton addTarget:self action:@selector(previousAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPrevious = clickPrevious;
}

- (void)previousAction:(UIButton *)button
{
    self.clickedPrevious(button);
}

- (void)setPlay:(BOOL)play{
    if (play) {
        [self playAction:_playButton];

    }
    else{
        [self pauseAction:_playButton];


    }
}






@end
