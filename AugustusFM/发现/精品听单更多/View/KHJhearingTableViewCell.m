//
//  KHJhearingTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJhearingTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJhearingTableViewCell ()

@property (nonatomic, retain) UIImageView *coverSmallImageView;
@property (nonatomic, retain) UILabel *titleLabel;
//头像
@property (nonatomic, retain) UIImageView *headImageView;

@property (nonatomic, retain) UILabel *nicknameLabel;
//三角符号
@property (nonatomic, retain) UIImageView *triangleImageView;
@property (nonatomic, retain) UILabel *playsCountsLabel;
//时间头像
@property (nonatomic, retain) UIImageView *timeImageView;
@property (nonatomic, retain) UILabel *durationLabel;
//红心
@property (nonatomic, retain) UIImageView *heartImageView;
@property (nonatomic, retain) UILabel *favoritesCountsLabel;
@property (nonatomic, retain) UIImageView *commentsCountsImageView;
@property (nonatomic, retain) UILabel *commentsCountsLabel;
@property (nonatomic, retain) UIImageView *downloadImageView;


@end


@implementation KHJhearingTableViewCell
- (void)dealloc{
    [_coverSmallImageView release];
    [_titleLabel release];
    [_headImageView release];
    [_nicknameLabel release];
    [_triangleImageView release];
    [_playsCountsLabel release];
    [_timeImageView release];
    [_durationLabel release];
    [_heartImageView release];
    [_favoritesCountsLabel release];
    [_commentsCountsImageView release];
    [_commentsCountsLabel release];
    [_downloadImageView release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverSmallImageView];
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        self.triangleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_triangleImageView];
        self.playsCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_playsCountsLabel];
        self.timeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_timeImageView];
        self.durationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_durationLabel];
        self.heartImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_heartImageView];
        self.favoritesCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_favoritesCountsLabel];
        self.commentsCountsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_commentsCountsImageView];
        self.commentsCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_commentsCountsLabel];
        self.downloadImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_downloadImageView];
        
        [_coverSmallImageView release];
        [_titleLabel release];
        [_headImageView release];
        [_nicknameLabel release];
        [_triangleImageView release];
        [_playsCountsLabel release];
        [_timeImageView release];
        [_durationLabel release];
        [_heartImageView release];
        [_favoritesCountsLabel release];
        [_commentsCountsImageView release];
        [_commentsCountsLabel release];
        [_downloadImageView release];

        /**
         *  夜间模式
         */
        [self jxl_setDayMode:^(UIView *view) {
            KHJhearingTableViewCell *cell = (KHJhearingTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
              } nightMode:^(UIView *view) {
            KHJhearingTableViewCell *cell = (KHJhearingTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
            cell.playsCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.playsCountsLabel.textColor = [UIColor whiteColor];
            cell.durationLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.durationLabel.textColor = [UIColor whiteColor];
            cell.favoritesCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.favoritesCountsLabel.textColor = [UIColor whiteColor];
            cell.commentsCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.commentsCountsLabel.textColor = [UIColor whiteColor];
        }];

        
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.coverSmallImageView.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.coverSmallImageView.frame.origin.x + self.coverSmallImageView.frame.size.width + 10 * lFitWidth, 10 * lFitHeight, 280 * lFitWidth, 50 * lFitHeight);
    self.titleLabel.numberOfLines = 0;
    
    self.headImageView.frame = CGRectMake(self.titleLabel.frame.origin.x , self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8 * lFitHeight, 12  *lFitWidth, 12  * lFitHeight);
    self.nicknameLabel.frame = CGRectMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width + 5 * lFitWidth, self.headImageView.frame.origin.y - 3 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight);
    self.triangleImageView.frame = CGRectMake(self.headImageView.frame.origin.x, self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.size.height + 7 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.playsCountsLabel.frame = CGRectMake(self.triangleImageView.frame.origin.x + self.triangleImageView.frame.size.width + 5 * lFitWidth, self.triangleImageView.frame.origin.y - 3 * lFitHeight, 40 * lFitWidth, 20 * lFitHeight);
    self.timeImageView.frame = CGRectMake(self.playsCountsLabel.frame.origin.x + self.playsCountsLabel.frame.size.width + 10 * lFitWidth, self.playsCountsLabel.frame.origin.y + 3 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.durationLabel.frame = CGRectMake(self.timeImageView.frame.origin.x + self.timeImageView.frame.size.width + 5 * lFitWidth, self.timeImageView.frame.origin.y - 3 * lFitHeight, 40 * lFitWidth, 20 * lFitHeight);
    self.heartImageView.frame = CGRectMake(self.durationLabel.frame.origin.x + self.durationLabel.frame.size.width + 5 * lFitWidth, self.durationLabel.frame.origin.y + 3 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.favoritesCountsLabel.frame = CGRectMake(self.heartImageView.frame.origin.x + self.heartImageView.frame.size.width + 5 * lFitWidth, self.heartImageView.frame.origin.y - 3 * lFitHeight, 40 * lFitWidth, 20 * lFitHeight);
    
    self.commentsCountsImageView.frame = CGRectMake( self.favoritesCountsLabel.frame.origin.x +  self.favoritesCountsLabel.frame.size.width + 10 * lFitWidth,  self.favoritesCountsLabel.frame.origin.y + 3 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.commentsCountsLabel.frame = CGRectMake(self.commentsCountsImageView.frame.origin.x + self.commentsCountsImageView.frame.size.width + 5 * lFitWidth, self.commentsCountsImageView.frame.origin.y - 3 * lFitHeight, 40 * lFitWidth, 20 * lFitHeight);
    
    
    self.downloadImageView.frame = CGRectMake(self.commentsCountsLabel.frame.origin.x + self.commentsCountsLabel.frame.size.width + 15 * lFitWidth, self.commentsCountsLabel.frame.origin.y - 5 * lFitHeight, 40 * lFitWidth, 40 * lFitHeight);
    
    self.titleLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.playsCountsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.playsCountsLabel.alpha = 0.5;
    self.durationLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.durationLabel.alpha = 0.5;
    self.favoritesCountsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.favoritesCountsLabel.alpha = 0.5;
    self.commentsCountsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.commentsCountsLabel.alpha = 0.5;
    
    
    
}
- (void)setModel:(KHJParticularsModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
    self.headImageView.image = [UIImage imageNamed:@"member_num-1"];
    self.nicknameLabel.text = model.nickname;
    self.triangleImageView.image = [UIImage imageNamed:@"sound_playtimes"];
    if ([model.playsCounts integerValue] < 10000) {
        self.playsCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.playsCounts integerValue]];
    }
    else{
        self.playsCountsLabel.text = [NSString stringWithFormat:@"%.f万",[model.playsCounts floatValue] / 10000];
    }
    
    self.timeImageView.image = [UIImage imageNamed:@"Unknown"];
    self.durationLabel.text = [NSString stringWithFormat:@"%.2f",[model.duration floatValue] / 60];
    
    self.heartImageView.image = [UIImage imageNamed:@"sound_likes"];
    self.favoritesCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.favoritesCounts integerValue]];
    self.commentsCountsImageView.image = [UIImage imageNamed:@"sound_comments-1"];
    self.commentsCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.commentsCounts integerValue]];
    self.downloadImageView.image = [UIImage imageNamed:@"np_more_down-2"];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
