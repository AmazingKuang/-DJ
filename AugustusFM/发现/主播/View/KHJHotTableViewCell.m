//
//  KHJHotTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJHotTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJHotTableViewCell ()
@property (nonatomic, retain) UIImageView *smallLogoImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *personDescribeLabel;
@property (nonatomic, retain) UILabel *tracksCountsLabel;
//圆图片
@property (nonatomic, retain) UIImageView *roundImageView;
//person图片
@property (nonatomic, retain) UIImageView *personImageView;
@property (nonatomic, retain) UILabel *followersCountsLabel;
//播放图片
@property (nonatomic, retain) UIImageView *playImageView;
//关注图片
@property (nonatomic, retain) UIImageView *attentionImageView;

@end
@implementation KHJHotTableViewCell
- (void)dealloc{
    [_smallLogoImageView release];
    [_nicknameLabel release];
    [_personDescribeLabel release];
    [_tracksCountsLabel release];
    [_roundImageView release];
    [_personImageView release];
    [_followersCountsLabel release];
    [_playImageView release];
    [_attentionImageView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.smallLogoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_smallLogoImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        self.personDescribeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_personDescribeLabel];
        
        self.tracksCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_tracksCountsLabel];
        
        self.roundImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_roundImageView];
        
        self.personImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_personImageView];
        
        self.followersCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_followersCountsLabel];
        
        self.playImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_playImageView];
        
        self.attentionImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_attentionImageView];
        [_smallLogoImageView release];
        [_nicknameLabel release];
        [_personDescribeLabel release];
        [_tracksCountsLabel release];
        [_roundImageView release];
        [_personImageView release];
        [_followersCountsLabel release];
        [_playImageView release];
        [_attentionImageView release];
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJHotTableViewCell *cell = (KHJHotTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.textColor = [UIColor blackColor];
            cell.personDescribeLabel.backgroundColor = [UIColor whiteColor];
            cell.personDescribeLabel.textColor = [UIColor blackColor];

            cell.tracksCountsLabel.backgroundColor = [UIColor whiteColor];
            cell.tracksCountsLabel.textColor = [UIColor blackColor];
            cell.followersCountsLabel.backgroundColor = [UIColor whiteColor];
            cell.followersCountsLabel.textColor = [UIColor blackColor];

        } nightMode:^(UIView *view) {
            KHJHotTableViewCell *cell = (KHJHotTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
            cell.personDescribeLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.personDescribeLabel.textColor = [UIColor whiteColor];
            cell.tracksCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.tracksCountsLabel.textColor = [UIColor whiteColor];
        }];
        
        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.smallLogoImageView.frame = CGRectMake(5 * lFitWidth, 5 * lFitHeight, 100 * lFitWidth, 100 * lFitHeight);
    self.nicknameLabel.frame = CGRectMake(self.smallLogoImageView.frame.origin.x + self.smallLogoImageView.frame.size.width + 5 * lFitWidth, 10 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight);
    self.personDescribeLabel.frame = CGRectMake(self.nicknameLabel.frame.origin.x, self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.size.height + 5 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight);
    self.personDescribeLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.personDescribeLabel.alpha = 0.5;
    
    self.roundImageView.frame = CGRectMake(self.personDescribeLabel.frame.origin.x, self.personDescribeLabel.frame.origin.y + self.personDescribeLabel.frame.size.height + 8 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.tracksCountsLabel.frame = CGRectMake(self.roundImageView.frame.origin.x + self.roundImageView.frame.size.width + 5 * lFitWidth, self.roundImageView.frame.origin.y - 3 * lFitHeight, 50 * lFitWidth, 20 * lFitHeight);
    self.personImageView.frame = CGRectMake(self.tracksCountsLabel.frame.origin.x + self.tracksCountsLabel.frame.size.width + 5 * lFitWidth, self.tracksCountsLabel.frame.origin.y + 3 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    _followersCountsLabel.frame = CGRectMake(self.personImageView.frame.origin.x + self.personImageView.frame.size.width + 5 * lFitWidth, self.personImageView.frame.origin.y - 3 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight);
    
    self.playImageView.frame = CGRectMake(self.roundImageView.frame.origin.x + 5 * lFitWidth, _followersCountsLabel.frame.origin.y + _followersCountsLabel.frame.size.height + 10 * lFitHeight, 20 * lFitWidth, 20 * lFitHeight);
    self.attentionImageView.frame = CGRectMake(self.playImageView.frame.origin.x + self.playImageView.frame.size.width + 200 * lFitWidth, self.playImageView.frame.origin.y, 50 * lFitWidth, 25 * lFitHeight);
    
    self.nicknameLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
//    self.smallLogoImageView.backgroundColor = [UIColor redColor];
//    self.nicknameLabel.backgroundColor = [UIColor blueColor];
//    self.personDescribeLabel.backgroundColor = [UIColor greenColor];
//    self.tracksCountsLabel.backgroundColor = [UIColor purpleColor];
//    self.roundImageView.backgroundColor = [UIColor brownColor];
//    self.personImageView.backgroundColor = [UIColor grayColor];
//    self.followersCountsLabel.backgroundColor = [UIColor blueColor];
//    self.playImageView.backgroundColor = [UIColor yellowColor];
//    self.attentionImageView.backgroundColor = [UIColor redColor];
}
- (void)setModel:(KHJsmallAnchorModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.smallLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.smallLogo] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nicknameLabel.text = model.nickname;
    if ([model.tracksCounts integerValue] < 10000) {
        self.tracksCountsLabel.text = [NSString stringWithFormat:@"%.ld",[model.tracksCounts integerValue]];
    }
    else{
    self.tracksCountsLabel.text = [NSString stringWithFormat:@"%.1f万",[model.tracksCounts floatValue] / 10000];
    }
    self.roundImageView.image = [UIImage imageNamed:@"Unknown"];
    self.personImageView.image = [UIImage imageNamed:@"member_num"];
    self.personDescribeLabel.text = model.personDescribe;
    self.followersCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.followersCounts integerValue]];
    self.playImageView.image = [UIImage imageNamed:@"sound_playbtn"];
    self.attentionImageView.image = [UIImage imageNamed:@"find_radio_focuse"];
    
                                      
                                      
                                      
                                
    
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
