//
//  KHJMusicSliderView.m
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJMusicSliderView.h"

@interface KHJMusicSliderView ()
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, copy) void (^changeSlider)(CGFloat value);
@property (nonatomic, copy) void (^changeSliderValue)(UISlider *slider);


@end
@implementation KHJMusicSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.musicCurrentProgress = [[UILabel alloc] init];
        [self addSubview:self.musicCurrentProgress];
        self.musicCurrentProgress.text = @"00:00";
        self.musicCurrentProgress.textAlignment = NSTextAlignmentCenter;
        self.musicCurrentProgress.font = [UIFont systemFontOfSize:13];
        self.musicCurrentProgress.textColor = [UIColor whiteColor];
        [_musicCurrentProgress release];
        
        self.playerSlider = [[UISlider alloc] init];
        [self addSubview:_playerSlider];
        [self.playerSlider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        [_playerSlider release];
        
        
        self.musicOverallProgress = [[UILabel alloc] init];
        [self addSubview:self.musicOverallProgress];
        self.musicOverallProgress.text = @"--:--";
        self.musicOverallProgress.textAlignment = NSTextAlignmentCenter;
        self.musicOverallProgress.font = [UIFont systemFontOfSize:13];
        self.musicOverallProgress.textColor = [UIColor whiteColor];
        [_musicCurrentProgress release];
        
        // 当前播放进度的Label的位置
        [self.musicCurrentProgress mas_makeConstraints:^(MASConstraintMaker *make) {
            // Y的坐标与View的中心点的Y相同
            make.centerY.mas_equalTo(self.mas_centerY);
            // 固定大小
            make.size.mas_equalTo(CGSizeMake(60, 40));
            // 使其左坐标系与自定义view的左边距为5
            make.left.mas_equalTo(self.mas_left).with.offset(5);
        }];
        // 总体播放进度的Label的位置
        [self.musicOverallProgress mas_makeConstraints:^(MASConstraintMaker *make) {
            // Y的坐标与View的中心点的Y相同
            make.centerY.mas_equalTo(self.mas_centerY);
            // 固定大小
            make.size.mas_equalTo(CGSizeMake(60, 40));
            // 使其右坐标系与自定义view的右边距为5
            make.right.mas_equalTo(self.mas_right).with.offset(-5);
        }];
        
        // 设置player进度条
        [self.playerSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            // 设置其中心点与ws相同
            make.center.equalTo(self.center);
            // 设置左边距与当前进度条的右边
            make.left.mas_equalTo(self.musicCurrentProgress.mas_right).with.offset(0);
            // 设置右边距与当前进度条的左边
            make.right.mas_equalTo(self.musicOverallProgress.mas_left).with.offset(0);
            // 设置高度为40
            make.height.mas_equalTo(40);
        }];
        
    }
    return self;
}

- (void)addPlayerTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changeTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

- (void)removePlayerTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeTimer
{
    self.changeSliderValue(self.playerSlider);
}

- (void)playerSliderValue:(void (^)(UISlider *slider))changeSlider
{
    
    self.changeSliderValue = changeSlider;
}

- (void)currentValue:(CGFloat)currentValue
{
    self.playerSlider.value = currentValue;
    self.musicCurrentProgress.text = [self changeTimer:currentValue];
    
}

- (void)changeValue:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    self.musicCurrentProgress.text = [self changeTimer:slider.value];
    self.changeSlider(slider.value);
}

- (void)playStatusClear
{
    // 设置Slider的Value值为0
    [self.playerSlider setValue:0.0];
    // 设置播放器的时间为0
    [self.musicCurrentProgress setText:@"00:00"];
    // 移除定时器
    [self removePlayerTimer];
}

- (void)changeSliderValue:(void (^)(CGFloat value))changeValue
{
    self.changeSlider = changeValue;
}

- (void)sliderThumb:(NSString *)thumbImageName
  maximumTrackImage:(NSString *)maximumTrackImageName
  minimumTrackImage:(NSString *)minimumTrackImageName

{
    [self.playerSlider setThumbImage:[UIImage imageNamed:thumbImageName] forState:UIControlStateNormal];
    [self.playerSlider setMaximumTrackImage:[UIImage imageNamed:maximumTrackImageName] forState:UIControlStateNormal];
    [self.playerSlider setMinimumTrackImage:[UIImage imageNamed:minimumTrackImageName] forState:UIControlStateNormal];
    
}

- (void)musicOverallValue:(CGFloat)overallValue
{
    self.playerSlider.maximumValue = overallValue;
    self.musicOverallProgress.text = [self changeTimer:overallValue];
}
#pragma mark 将播放时长转为字符串
- (NSString *)changeTimer:(CGFloat)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (time >= 3600) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}


@end
