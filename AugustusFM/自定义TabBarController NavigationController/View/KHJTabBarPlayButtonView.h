//
//  KHJTabBarPlayButtonView.h
//  AugustusFM
//
//  Created by dllo on 16/7/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseView.h"

@protocol KHJTabBarPlayButtonViewDelegate <NSObject>
//传入按钮的属性
- (void)playButtonDidClick:(BOOL)isSelected;
@end
@interface KHJTabBarPlayButtonView : KHJBaseView
/**
 *  背景图片
 */
@property (nonatomic, retain) UIImageView *circleImageView;
//专辑的图片内容视图
@property (nonatomic, retain) UIImageView *contentImageView;
/**
 *  播放按钮
 */

@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, assign) id<KHJTabBarPlayButtonViewDelegate>delegate;
@end
