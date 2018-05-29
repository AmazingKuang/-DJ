//
//  KHJContentIntroTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJContentIntroTableViewCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJContentIntroTableViewCell ()
@end

@implementation KHJContentIntroTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        
        self.introLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_introLabel];
        
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJContentIntroTableViewCell *cell = (KHJContentIntroTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.contentLabel.backgroundColor = [UIColor whiteColor];
            cell.contentLabel.textColor = [UIColor blackColor];
            cell.introLabel.backgroundColor = [UIColor whiteColor];
            cell.introLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJContentIntroTableViewCell *cell = (KHJContentIntroTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.contentLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.contentLabel.textColor = [UIColor whiteColor];
            cell.introLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.introLabel.textColor = [UIColor whiteColor];
        }];
   
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight , 100 * lFitWidth, 30 * lFitHeight);
    self.introLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 5 * lFitHeight, 380 * lFitWidth, 60 * lFitHeight);
    self.introLabel.font = [UIFont systemFontOfSize:15 * lFitWidth];
    self.introLabel.numberOfLines = 0;
    self.contentLabel.text = @"内容简介";
    self.contentLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
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
