//
//  KHJMusicPlayView.h
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHJMusicPlayView : UIView
//播放按钮
@property (nonatomic, retain) UIButton *playButton;
//上一曲
@property (nonatomic, retain) UIButton *previousButton;
//下一曲
@property (nonatomic, retain) UIButton *nextButton;
//是否在播放
@property (nonatomic, assign) BOOL play;
//播放block
- (void)playImage:(NSString *)playImage pause:(NSString *)pauseImage play:(void (^)(UIButton *play))clickPlay pause:(void (^)(UIButton *pause))clickPause;
// 下一曲的block
- (void)nextImage:(NSString *)nextImage nextMusic:(void (^)(UIButton *next))clickNext;
// 上一曲的block
- (void)previousImage:(NSString *)previousImage previousMusic:(void (^)(UIButton *previous))clickPrevious;
@end
