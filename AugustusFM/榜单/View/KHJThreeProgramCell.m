//
//  KHJThreeProgramCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJThreeProgramCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJThreeProgramCell ()

@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UIImageView *coverSmallImageView;
@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, retain) UILabel *nicknameLabel;
//圆图片
@property (nonatomic, retain) UIImageView *roundImageView;

@property (nonatomic, retain) UILabel *tracksCountsLabel;
//三角图片
@property (nonatomic, retain) UIImageView *triangleImageView;

@end
@implementation KHJThreeProgramCell
- (void)dealloc{
    [_numberLabel release];
    [_coverSmallImageView release];
    [_titleLable release];
    [_nicknameLabel release];
    [_roundImageView release];
    [_tracksCountsLabel release];
    [_triangleImageView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numberLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_numberLabel];
        
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverSmallImageView];
        
        self.titleLable = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLable];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
        self.roundImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_roundImageView];
        
        self.tracksCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_tracksCountsLabel];
        
        self.triangleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_triangleImageView];
        
        [_numberLabel release];
        [_coverSmallImageView release];
        [_titleLable release];
        [_nicknameLabel release];
        [_roundImageView release];
        [_tracksCountsLabel release];
        [_triangleImageView release];
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJThreeProgramCell *cell = (KHJThreeProgramCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.backgroundColor = [UIColor whiteColor];
            cell.nicknameLabel.textColor = [UIColor blackColor];
            cell.titleLable.backgroundColor = [UIColor whiteColor];
            cell.titleLable.textColor = [UIColor blackColor];
            cell.tracksCountsLabel.backgroundColor = [UIColor whiteColor];
            cell.tracksCountsLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJThreeProgramCell *cell = (KHJThreeProgramCell
                                         *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nicknameLabel.textColor = [UIColor whiteColor];
            cell.titleLable.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLable.textColor = [UIColor whiteColor];
            cell.tracksCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.tracksCountsLabel.textColor = [UIColor whiteColor];
        }];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.numberLabel.frame = CGRectMake(10 * lFitWidth, 40 * lFitHeight, 20 * lFitWidth, 20 * lFitHeight);
    self.numberLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.numberLabel.textColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    self.numberLabel.textAlignment = 1;

    self.coverSmallImageView.frame = CGRectMake(self.numberLabel.frame.origin.x + self.numberLabel.frame.size.width + 5 * lFitWidth, 5 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
//    self.coverSmallImageView.layer.masksToBounds = YES;
//    self.coverSmallImageView.layer.cornerRadius = 40;
    self.titleLable.frame = CGRectMake(self.coverSmallImageView.frame.origin.x + self.coverSmallImageView.frame.size.width + 5 * lFitWidth, self.coverSmallImageView.frame.origin.y, 250 * lFitWidth, 30 * lFitHeight);
    self.titleLable.font = [UIFont systemFontOfSize:16 * lFitWidth];
    self.nicknameLabel.frame = CGRectMake(self.titleLable.frame.origin.x, self.titleLable.frame.origin.y + self.titleLable.frame.size.height + 5 * lFitHeight, 250 * lFitWidth, 20 * lFitHeight);
    self.nicknameLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.nicknameLabel.alpha = 0.5;
    
    self.roundImageView.frame = CGRectMake( self.nicknameLabel.frame.origin.x,  self.nicknameLabel.frame.origin.y +  self.nicknameLabel.frame.size.height + 8 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.tracksCountsLabel.frame = CGRectMake(self.roundImageView.frame.origin.x + self.roundImageView.frame.size.width + 5 * lFitWidth, self.roundImageView.frame.origin.y - 3 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight);
    self.tracksCountsLabel.alpha = 0.5;
    self.tracksCountsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    
    self.triangleImageView.frame = CGRectMake(self.nicknameLabel.frame.origin.x + self.nicknameLabel.frame.size.width + 20 * lFitWidth, self.nicknameLabel.frame.origin.y - 3 * lFitHeight, 8 * lFitWidth, 10 * lFitHeight);
  
//    self.numberLabel.backgroundColor = [UIColor redColor];
//    self.coverSmallImageView.backgroundColor = [UIColor blueColor];
//    self.titleLable.backgroundColor = [UIColor grayColor];
//    self.nicknameLabel.backgroundColor = [UIColor blueColor];
//    self.roundImageView.backgroundColor = [UIColor purpleColor];
//    self.tracksCountsLabel.backgroundColor = [UIColor brownColor];
//    self.triangleImageView.backgroundColor = [UIColor redColor];
    
}

- (void)setModel:(KHJDetailRecommend *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLable.text = model.title;
    self.nicknameLabel.text = model.nickname;
    self.tracksCountsLabel.text = [NSString stringWithFormat:@"%ld集",[model.tracks integerValue]];
    self.roundImageView.image = [UIImage imageNamed:@"Unknown"];
    self.triangleImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
    
    
    
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
