//
//  AudioPlayerManager.m
//  MusicDemo
//
//  Created by QC.L on 15/6/21.
//  Copyright © 2015年 QC.L. All rights reserved.
//

#import "AudioPlayerManager.h"

@implementation AudioPlayerManager

- (void)dealloc
{
    // 关闭消息中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark 播放器单例方法
+ (AudioPlayerManager *)shareAudioPlayerManager
{
    static AudioPlayerManager *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[AudioPlayerManager alloc] init];
    });
    return player;
}
#pragma mark 播放器播放方法
- (void)playerPlayWithUrl:(NSString *)url
{
    if (self.currentItem) {
        [self removeObserver:self forKeyPath:@"status"];
    }
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];

    [self addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    [self replaceCurrentItemWithPlayerItem:item];
    
    [self play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [item release];
}

- (void)interruptPlay:(NSNotification *)notif
{
//        NSLog(@"%@", notif);
}

- (void)playing:(NSNotification *)notfi
{
//        NSLog(@"%@", notfi);
}

- (void)playEnd
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didFinshPlay)]) {
        [self.delegate didFinshPlay];
    }
}

- (void)stop
{
    [self setRate:0.0];
    [self replaceCurrentItemWithPlayerItem:nil];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

//        NSLog(@"%@", change);
        switch ([change[@"new"] integerValue]) {
            case AVPlayerItemStatusFailed:
                NSLog(@"错误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备播放");
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"未知情况");
                break;
            default:
                NSLog(@"其他");
                break;
        }
}


@end
