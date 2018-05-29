//
//  KHJAnchorListTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJAnchorListTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJAnchorListTableViewCell ()
//数字
@property (nonatomic, retain) UILabel *numberLabel;

@property (nonatomic, retain) UIImageView *middleLogoImageView;

@property (nonatomic, retain) UILabel *nicknameLabel;

@property (nonatomic, retain) UILabel *personDescribeLabel;
//小人图片
@property (nonatomic, retain) UIImageView *personImageView;

@property (nonatomic, retain) UILabel *followersCountsLabel;

//箭头图片
@property (nonatomic, retain) UIImageView *turnImageView;


//线条
@property (nonatomic, retain) UILabel *lineLabel;

@end


@implementation KHJAnchorListTableViewCell
- (void)dealloc{
    [_numberLabel release];
    [_middleLogoImageView release];
    [_nicknameLabel release];
    [_personImageView release];
    [_personDescribeLabel release];
    [_followersCountsLabel release];
    [super dealloc];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numberLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_numberLabel];
        
        self.middleLogoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_middleLogoImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        self.personImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_personImageView];
        
        self.personDescribeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_personDescribeLabel];
        
        self.followersCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_followersCountsLabel];
        
        self.turnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_turnImageView];
        
        self.lineLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_lineLabel];
        
        [_numberLabel release];
        [_middleLogoImageView release];
        [_nicknameLabel release];
        [_personImageView release];
        [_personDescribeLabel release];
        [_followersCountsLabel release];
        [_turnImageView release];
        [self jxl_setDayMode:^(UIView *view) {
            KHJAnchorListTableViewCell *cell = (KHJAnchorListTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.textColor = [UIColor blackColor];
            cell.personDescribeLabel.backgroundColor = [UIColor whiteColor];
            cell.personDescribeLabel.textColor = [UIColor blackColor];
            cell.followersCountsLabel.backgroundColor = [UIColor whiteColor];
            cell.followersCountsLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJAnchorListTableViewCell *cell = (KHJAnchorListTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
            cell.personDescribeLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.personDescribeLabel.textColor = [UIColor whiteColor];
            cell.followersCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.followersCountsLabel.textColor = [UIColor whiteColor];
        }];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",_number];
    self.numberLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.numberLabel.frame = CGRectMake(10 * lFitWidth, 40 * lFitHeight, 20 * lFitWidth, 20 * lFitHeight);
    self.numberLabel.textColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
    self.middleLogoImageView.frame = CGRectMake(self.numberLabel.frame.origin.x + self.numberLabel.frame.size.width + 10 * lFitWidth, 5 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.nicknameLabel.frame = CGRectMake(self.middleLogoImageView.frame.origin.x + self.middleLogoImageView.frame.size.width + 10 * lFitWidth, self.middleLogoImageView.frame.origin.y, 200 * lFitWidth, 30 * lFitHeight);
    self.personDescribeLabel.frame = CGRectMake(self.nicknameLabel.frame.origin.x, self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.size.height + 5 * lFitHeight, 250 * lFitWidth, 20 * lFitHeight);
    
    self.personImageView.frame = CGRectMake(self.personDescribeLabel.frame.origin.x, self.personDescribeLabel.frame.origin.y + self.personDescribeLabel.frame.size.height + 8 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.followersCountsLabel.frame = CGRectMake( self.personImageView.frame.origin.x +  self.personImageView.frame.size.width + 5 * lFitWidth,  self.personImageView.frame.origin.y - 3 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight);
    
    self.turnImageView.frame = CGRectMake(self.personDescribeLabel.frame.origin.x + self.personDescribeLabel.frame.size.width + 10 * lFitWidth, self.personDescribeLabel.frame.origin.y - 10 * lFitHeight, 8 * lFitWidth, 10 * lFitHeight);
    self.nicknameLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.personDescribeLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.personDescribeLabel.alpha = 0.5;
    
    self.followersCountsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.followersCountsLabel.alpha = 0.5;
    
    self.lineLabel.frame = CGRectMake(0, self.followersCountsLabel.frame.origin.y + self.followersCountsLabel.frame.size.height + 5 * lFitHeight, ScreenWidth, 1);
    self.lineLabel.alpha = 0.2;
    self.lineLabel.backgroundColor = [UIColor blackColor];
    
    
    self.personImageView.image = [UIImage imageNamed:@"find_hotUser_fans-1"];
    self.turnImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
    
    
//      self.numberLabel.backgroundColor = [UIColor redColor];
//    self.middleLogoImageView.backgroundColor = [UIColor blueColor];
//    self.nicknameLabel.backgroundColor = [UIColor greenColor];
//    self.personImageView.backgroundColor = [UIColor grayColor];
//    self.personDescribeLabel.backgroundColor = [UIColor yellowColor];
//    self.followersCountsLabel.backgroundColor = [UIColor purpleColor];
//    self.turnImageView.backgroundColor = [UIColor redColor];

    
}
- (void)setModel:(KHJListViewModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    [self.middleLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.middleLogo] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nicknameLabel.text = model.nickname;
    self.personDescribeLabel.text = model.personDescribe;
    if ([model.followersCounts integerValue] < 10000) {
         self.followersCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.followersCounts integerValue]];
    }
    else{
        self.followersCountsLabel.text = [NSString stringWithFormat:@"%.1f万",[model.followersCounts floatValue]/ 10000];
    }
    
    
    
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
