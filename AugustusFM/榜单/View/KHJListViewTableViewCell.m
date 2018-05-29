//
//  KHJListViewTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJListViewTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@implementation KHJListViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverPathImageVIew = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverPathImageVIew];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.firstTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_firstTitleLabel];
        
        self.secondTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_secondTitleLabel];
        self.turnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_turnImageView];
        
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJListViewTableViewCell *cell = (KHJListViewTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.firstTitleLabel.backgroundColor = [UIColor whiteColor];
            cell.firstTitleLabel.textColor = [UIColor blackColor];
            cell.secondTitleLabel.backgroundColor = [UIColor whiteColor];
            cell.secondTitleLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJListViewTableViewCell *cell = (KHJListViewTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.firstTitleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.firstTitleLabel.textColor = [UIColor whiteColor];
            cell.secondTitleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.secondTitleLabel.textColor = [UIColor whiteColor];
        }];

        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverPathImageVIew.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.coverPathImageVIew.frame.origin.x + self.coverPathImageVIew.frame.size.width + 10 * lFitWidth, self.coverPathImageVIew.frame.origin.y, 200 * lFitWidth, 30 * lFitHeight);
   self.turnImageView.frame = CGRectMake(380 * lFitWidth, 40 * lFitHeight, 8 * lFitWidth, 12 * lFitHeight);
    

    self.firstTitleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, 250 * lFitWidth, 20 * lFitHeight);
    self.secondTitleLabel.frame = CGRectMake(self.firstTitleLabel.frame.origin.x, self.firstTitleLabel.frame.origin.y + self.firstTitleLabel.frame.size.height, 310 * lFitWidth, 20 * lFitHeight);
    
    self.titleLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.firstTitleLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.secondTitleLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.firstTitleLabel.alpha = 0.5;
    self.secondTitleLabel.alpha = 0.5;
//    self.coverPathImageVIew.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor blueColor];
//    
//    self.firstTitleLabel.backgroundColor = [UIColor greenColor];
//    self.secondTitleLabel.backgroundColor = [UIColor purpleColor];
    
}
- (void)setModel:(KHJDetailRecommend *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverPathImageVIew sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
    self.firstTitleLabel.text = [NSString stringWithFormat:@"1  %@",model.firstTitle];
  self.secondTitleLabel.text = [NSString stringWithFormat:@"2  %@",[[model.firstKResults objectAtIndex:1] objectForKey:@"title"]];
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
