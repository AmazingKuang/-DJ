//
//  KHJTwoProgramListCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTwoProgramListCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJTwoProgramListCell ()

@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UIImageView *coverSmallImageView;
@property (nonatomic, retain) UILabel *titleLabel;
//小人图片
@property (nonatomic, retain) UIImageView *personImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;
//下载图片
@property (nonatomic, retain) UIImageView *downImageView;

@end
@implementation KHJTwoProgramListCell

- (void)dealloc{
    [_numberLabel release];
    [_coverSmallImageView release];
    [_titleLabel release];
    [_personImageView release];
    [_nicknameLabel release];
    [_downImageView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numberLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_numberLabel];
        
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverSmallImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.personImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_personImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        self.downImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_downImageView];
        
        [_numberLabel release];
        [_coverSmallImageView release];
        [_titleLabel release];
        [_personImageView release];
        [_nicknameLabel release];
        [_downImageView release];
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJTwoProgramListCell *cell = (KHJTwoProgramListCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.textColor = [UIColor blackColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJTwoProgramListCell *cell = (KHJTwoProgramListCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
        }];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.numberLabel.frame = CGRectMake(10 * lFitWidth, 40 * lFitHeight, 20 * lFitWidth, 20 * lFitHeight);
    self.numberLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.numberLabel.textAlignment = 1;
    self.numberLabel.textColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    self.coverSmallImageView.frame = CGRectMake( self.numberLabel.frame.origin.x +  self.numberLabel.frame.size.width + 5 * lFitWidth, 5 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.coverSmallImageView.layer.masksToBounds = YES;
    self.coverSmallImageView.layer.cornerRadius = 40 * lFitHeight;
    self.titleLabel.frame = CGRectMake(self.coverSmallImageView.frame.origin.x + self.coverSmallImageView.frame.size.width + 5 * lFitWidth, self.coverSmallImageView.frame.origin.y, 280 * lFitWidth, 45 * lFitHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:16 * lFitWidth];
    self.titleLabel.numberOfLines = 0;
    
    self.personImageView.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.nicknameLabel.frame = CGRectMake(self.personImageView.frame.origin.x + self.personImageView.frame.size.width + 5 * lFitWidth, self.personImageView.frame.origin.y - 3 * lFitHeight, 240 * lFitWidth, 20 * lFitHeight);
    self.nicknameLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.nicknameLabel.alpha = 0.5;
    self.downImageView.frame = CGRectMake( self.nicknameLabel.frame.origin.x +  self.nicknameLabel.frame.size.width,  self.nicknameLabel.frame.origin .y - 3 * lFitHeight, 30 * lFitWidth, 30 * lFitHeight);
    
    
//    
//    self.numberLabel.backgroundColor = [UIColor redColor];
//     self.coverSmallImageView.backgroundColor = [UIColor blueColor];
//     self.titleLabel.backgroundColor = [UIColor grayColor];
//     self.personImageView.backgroundColor = [UIColor greenColor];
//     self.nicknameLabel.backgroundColor = [UIColor purpleColor];
//     self.downImageView.backgroundColor = [UIColor brownColor];
    
}
- (void)setModel:(KHJParticularsModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
    self.nicknameLabel.text = model.nickname;
    self.personImageView.image = [UIImage imageNamed:@"find_hotUser_fans-1"];
//    self.downImageView.image = [[UIImage imageNamed:@"np_more_down-1"] imageWithRenderingMode:1];
    
}
- (void)setLabelInter:(NSInteger)labelInter{
    if (_labelInter != labelInter) {
        _labelInter = labelInter;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",_labelInter];

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
