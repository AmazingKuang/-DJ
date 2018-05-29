//
//  AudioPlayerManager.h
//  MusicDemo
//
//  Created by QC.L on 15/6/21.
//  Copyright © 2015年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol AudioPlayerManagerDelegate <NSObject>

//@optional
/**
 *  音频播放结束
 */
- (void)didFinshPlay;
///**
// *  音频播放开始
// */
//- (void)startPlay;
///**
// *  音频播放状态变更
// */
//- (void)changeStauts;

@end

@interface AudioPlayerManager : AVPlayer

@property (nonatomic, assign) id <AudioPlayerManagerDelegate> delegate;
/**
 *  单例方法
 *
 *  @return player
 */
+ (AudioPlayerManager *)shareAudioPlayerManager;

/**
 *  播放音频的方法
 *
 *  @param url 音频的url
 */
- (void)playerPlayWithUrl:(NSString *)url;

/**
 *  终止播放的方法
 */
- (void)stop;



@end
