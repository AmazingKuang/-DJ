//
//  KHJHearListTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJHearListTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJHearListTableViewCell ()
@property (nonatomic, retain) UIImageView *coverPathImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
//小圆圈图片
@property (nonatomic, retain) UIImageView *roundImageView;
//箭头图片
@property (nonatomic, retain) UIImageView *turnImageView;

@property (nonatomic, retain) UILabel *footnoteLabel;
@end



@implementation KHJHearListTableViewCell

- (void)dealloc{
    [_coverPathImageView release];
    [_titleLabel release];
    [_subtitleLabel release];
    [_roundImageView release];
    [_turnImageView release];
    [_footnoteLabel release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverPathImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverPathImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.subtitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subtitleLabel];
        
        self.roundImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_roundImageView];
        
        self.footnoteLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_footnoteLabel];
        
        self.turnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_turnImageView];
        
        [_coverPathImageView release];
        [_titleLabel release];
        [_subtitleLabel release];
        [_roundImageView release];
        [_turnImageView release];
        [_footnoteLabel release];
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJHearListTableViewCell *cell = (KHJHearListTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.subtitleLabel.backgroundColor = [UIColor whiteColor];
            cell.subtitleLabel.textColor = [UIColor blackColor];
            cell.footnoteLabel.backgroundColor = [UIColor whiteColor];
            cell.footnoteLabel.textColor = [UIColor blackColor];

        } nightMode:^(UIView *view) {
            KHJHearListTableViewCell *cell = (KHJHearListTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.subtitleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.subtitleLabel.textColor = [UIColor whiteColor];
            cell.footnoteLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.footnoteLabel.textColor = [UIColor whiteColor];
        }];

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverPathImageView.frame = CGRectMake(5 * lFitWidth, 5 * lFitWidth, 80 * lFitWidth, 80 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.coverPathImageView.frame.origin.x + self.coverPathImageView.frame.size.width + 5 * lFitWidth, self.coverPathImageView.frame.origin.y, 300 * lFitWidth, 30 * lFitHeight);
    self.subtitleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.titleLabel.frame.size.width, 30 * lFitHeight);
    self.roundImageView.frame = CGRectMake(self.subtitleLabel.frame.origin.x, self.subtitleLabel.frame.origin.y + self.subtitleLabel.frame.size.height+ 3 * lFitHeight, 15 * lFitWidth, 15 * lFitHeight);
    self.footnoteLabel.frame = CGRectMake(self.roundImageView.frame.origin.x + self.roundImageView.frame.size.width , self.roundImageView.frame.origin.y - 3 * lFitHeight, 250 * lFitWidth, 20 * lFitHeight);
    
    self.turnImageView.frame = CGRectMake(380 * lFitWidth, 30 * lFitHeight, 10 * lFitWidth, 15 * lFitHeight);
    
    self.titleLabel.font = [UIFont systemFontOfSize:16 * lFitWidth];
    self.subtitleLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.subtitleLabel.alpha = 0.5;
    self.footnoteLabel.font = [UIFont systemFontOfSize:12 * lFitWidth];
    self.footnoteLabel.alpha = 0.5;
    
    
//    self.coverPathImageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
//    self.subtitleLabel.backgroundColor = [UIColor blueColor];
//    self.footnoteLabel.backgroundColor = [UIColor grayColor];
//    
//    
    
    
}

- (void)setModel:(KHJDetailListenModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    if (model.coverPath == nil) {
        [self.coverPathImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPathBig] placeholderImage:[UIImage imageNamed:@"no_network"]];
    }
    if (model.coverPathBig == nil) {
        [self.coverPathImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"no_network"]];
    }
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subtitle;
    self.footnoteLabel.text = model.footnote;
    self.roundImageView.image = [UIImage imageNamed:@"Unknown"];
    self.turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
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
