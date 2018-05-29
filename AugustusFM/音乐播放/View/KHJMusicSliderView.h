//
//  KHJMusicSliderView.h
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KHJMusicSliderViewDelegate <NSObject>
@optional
- (void)sliderScroll:(CGFloat)value;

@end

@interface KHJMusicSliderView : UIView
//签代理
@property (nonatomic, assign) id<KHJMusicSliderViewDelegate>delegate;


// 播放进度条
@property (nonatomic, retain) UISlider *playerSlider;
// 音频播放当前进度
@property (nonatomic, retain) UILabel *musicCurrentProgress;
// 音频播放全部进度
@property (nonatomic, retain) UILabel *musicOverallProgress;
//slider图片
- (void)sliderThumb:(NSString *)thumbImageName
  maximumTrackImage:(NSString *)maximumTrackImageName
  minimumTrackImage:(NSString *)minimumTrackImageName;

//播放总时长
- (void)musicOverallValue:(CGFloat)overallValue;

//当前进度条的值
- (void)currentValue:(CGFloat)currentValue;

//滑动滑块获得滑块的Value修改音频进度的Block
- (void)changeSliderValue:(void (^)(CGFloat value))changeValue;

//根据播放进度修改滑块的位置
- (void)playerSliderValue:(void (^)(UISlider *slider))changeSlider;
/**
 *  播放状态清空
 */
- (void)playStatusClear;

- (void)addPlayerTimer;
- (void)removePlayerTimer;

@end
