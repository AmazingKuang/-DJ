//
//  KHJSoundTopView.m
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSoundTopView.h"

@interface KHJSoundTopView ()
/** 返回按钮 */
@property(nonatomic, retain) UIButton *leftBackButton;
/** 右侧更多按钮 */
@property(nonatomic, retain) UIButton *rightMoreButton;
/** 标题 */
@property(nonatomic, retain) UILabel *soundLabel;
/** 作者 */
@property(nonatomic, retain) UILabel *singerLabel;
@end

@implementation KHJSoundTopView
- (void)dealloc
{
    [_soundLabel release];
    [_singerLabel release];
    [_model release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBackButton setImage:[UIImage imageNamed:@"icon_radio_show"] forState:UIControlStateNormal];
        [self.leftBackButton setImage:[UIImage imageNamed:@"icon_radio_show"] forState:UIControlStateHighlighted];
        [self.leftBackButton addTarget:self action:@selector(didClickedBackButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBackButton];
        [self.leftBackButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self).with.offset(0);
            make.width.equalTo(60);
        }];
        
        self.soundLabel = [[UILabel alloc] init];
        self.soundLabel.textAlignment = NSTextAlignmentCenter;
        self.soundLabel.font = [UIFont systemFontOfSize:17];
        self.soundLabel.textColor = [UIColor whiteColor];
        [self addSubview:_soundLabel];
        [self.soundLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).with.offset(0);
            make.top.equalTo(self).with.offset(0);
            make.height.equalTo(40);
            make.width.equalTo(230);
        }];
        [_soundLabel release];
        
        self.singerLabel = [[UILabel alloc] init];
        self.singerLabel.font = [UIFont systemFontOfSize:15];
        self.singerLabel.textAlignment = NSTextAlignmentCenter;
        self.singerLabel.textColor = [UIColor whiteColor];
        [self addSubview:_singerLabel];
        [self.singerLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            make.height.equalTo(20);
            make.width.equalTo(180);
        }];
        [_singerLabel release];
        
        self.rightMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightMoreButton setImage:[UIImage imageNamed:@"main_tab_more"] forState:UIControlStateNormal];
        [self.rightMoreButton addTarget:self action:@selector(didClickedMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightMoreButton];
        [self.rightMoreButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self).with.offset(0);
            make.width.equalTo(60);
        }];
        
        
        
    }
    return self;
}
- (void)setModel:(KHJParticularsModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.soundLabel.text = model.title;
    self.singerLabel.text = model.nickname;
}
#pragma mark -- 返回按钮
- (void)didClickedBackButton:(UIButton *)sender{
    self.goBackBlock();
}
- (void)didClickedMoreButton:(UIButton *)sender{
    NSLog(@"你点击了按钮");
}



@end
