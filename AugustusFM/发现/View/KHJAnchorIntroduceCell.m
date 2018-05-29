//
//  KHJAnchorIntroduceCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJAnchorIntroduceCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@implementation KHJAnchorIntroduceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.smallLogoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_smallLogoImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        self.followersLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_followersLabel];
        
        self.personalSignatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_personalSignatureLabel];
        
        
        /**
         *  夜间模式
         */
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJAnchorIntroduceCell *cell = (KHJAnchorIntroduceCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.nicknameLabel.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.textColor = [UIColor blackColor];
            cell.followersLabel.backgroundColor = [UIColor whiteColor];
            cell.followersLabel.textColor = [UIColor blackColor];
            cell.personalSignatureLabel.backgroundColor = [UIColor whiteColor];
            cell.personalSignatureLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJAnchorIntroduceCell *cell = (KHJAnchorIntroduceCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
            cell.followersLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.followersLabel.textColor = [UIColor whiteColor];
            cell.personalSignatureLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.personalSignatureLabel.textColor = [UIColor whiteColor];
        }];
  
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight, 200 * lFitWidth, 30 * lFitHeight);
    
    self.smallLogoImageView.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.smallLogoImageView.layer.masksToBounds = YES;
    self.smallLogoImageView.layer.cornerRadius = 40 * lFitHeight;
    
    self.nicknameLabel.frame = CGRectMake(self.smallLogoImageView.frame.origin.x + self.smallLogoImageView.frame.size.width + 5 * lFitWidth, self.smallLogoImageView.frame.origin.y, 200 * lFitWidth, 30 * lFitHeight);
    self.followersLabel.frame = CGRectMake(self.nicknameLabel.frame.origin.x, self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.size.height + 5 * lFitHeight, 200 * lFitWidth, 20 * lFitHeight);
    self.followersLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.followersLabel.alpha = 0.5;
    
    self.personalSignatureLabel.frame = CGRectMake(self.smallLogoImageView.frame.origin.x, self.followersLabel.frame.origin.y + self.followersLabel.frame.size.height + 20 * lFitHeight, 380 * lFitWidth, 60 * lFitHeight);
    self.personalSignatureLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.titleLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.nicknameLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.personalSignatureLabel.numberOfLines = 0;
    
}
- (void)setModel:(KHJAnchorIntroduceModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.titleLabel.text = @"主播介绍";
    [self.smallLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.smallLogo] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nicknameLabel.text = model.nickname;
    self.followersLabel.text = [NSString stringWithFormat:@"已被%.1f万人关注",[[model followers] floatValue] / 10000];
    self.personalSignatureLabel.text = model.personalSignature;
    

    
    
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
