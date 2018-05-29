//
//  KHJsmallAnchorCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJsmallAnchorCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJsmallAnchorCollectionViewCell ()
@property (nonatomic, retain) UIImageView *smallLogoImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;

@property (nonatomic, retain) UIImageView *attentionImageView;

//边框线
@property (nonatomic, retain) UIView *lineView;
@end

@implementation KHJsmallAnchorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_lineView];
        
        self.smallLogoImageView = [[UIImageView alloc] init];
        [self.lineView addSubview:_smallLogoImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        
        self.attentionImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_attentionImageView];
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJsmallAnchorCollectionViewCell *cell = (KHJsmallAnchorCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJsmallAnchorCollectionViewCell *cell = (KHJsmallAnchorCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
        }];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(10 * lFitWidth, 5 * lFitHeight, ScreenWidth / 3 - 30 * lFitWidth, 100 * lFitHeight);
    self.smallLogoImageView.frame = CGRectMake(1 , 1, ScreenWidth / 3 - 32 * lFitWidth, 98 * lFitHeight);
    self.nicknameLabel.frame = CGRectMake(15 * lFitWidth, self.smallLogoImageView.frame.origin.y + self.smallLogoImageView.frame.size.height + 5 * lFitHeight, 100 * lFitWidth, 30 * lFitHeight);
    
    self.attentionImageView.frame = CGRectMake(40 * lFitWidth, self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.size.height + 5 * lFitHeight, 50 * lFitWidth, 30 * lFitHeight);
    self.nicknameLabel.textAlignment = 1;
    
    self.nicknameLabel.font = [UIFont systemFontOfSize:13 ];
    self.attentionImageView.image = [UIImage imageNamed:@"find_radio_focuse"];
    
}
- (void)setModel:(KHJsmallAnchorModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.smallLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.smallLogo] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nicknameLabel.text = model.nickname;
}


@end
