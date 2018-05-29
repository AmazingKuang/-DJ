//
//  CALayer+PauseAimate.h
//  HeartToHeartFM
//
//  Created by dllo on 16/5/31.
//  Copyright © 2016年 LiuXin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end
