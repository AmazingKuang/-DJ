//
//  KHJDetailListenListCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDetailListenListCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJDetailListenListCell ()
@property (nonatomic, retain) UIImageView *coverPathBigImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIImageView *circleImageView;
@property (nonatomic, retain) UILabel *footnoteLabel;

@end

@implementation KHJDetailListenListCell
- (void)dealloc{
    [_coverPathBigImageView release];
    [_titleLabel release];
    [_subtitleLabel release];
    [_circleImageView release];
    [_footnoteLabel release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverPathBigImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverPathBigImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.subtitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_subtitleLabel];
        
        self.circleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_circleImageView];
        
        self.footnoteLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_footnoteLabel];
        
        [_coverPathBigImageView release];
        [_titleLabel release];
        [_subtitleLabel release];
        [_circleImageView release];
        [_footnoteLabel release];
        
        
        /**
         *  夜间模式
         */
        [self jxl_setDayMode:^(UIView *view) {
            KHJDetailListenListCell *cell = (KHJDetailListenListCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJDetailListenListCell *cell = (KHJDetailListenListCell *)view;
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
    self.coverPathBigImageView.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.coverPathBigImageView.frame.origin.x + self.coverPathBigImageView.frame.size.width + 8 * lFitWidth, self.coverPathBigImageView.frame.origin.y, 300 * lFitWidth, 30  * lFitHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.subtitleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 3 * lFitHeight, 280 * lFitWidth, 20 * lFitHeight);
    self.subtitleLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.subtitleLabel.alpha = 0.5;
    
    self.circleImageView.frame = CGRectMake(self.subtitleLabel.frame.origin.x, self.subtitleLabel.frame.origin.y + self.subtitleLabel.frame.size.height + 10 * lFitHeight, 12 * lFitWidth, 12 * lFitHeight);
    self.footnoteLabel.frame = CGRectMake(self.circleImageView.frame.origin.x + self.circleImageView.frame.size.width + 5 * lFitWidth, self.circleImageView.frame.origin.y - 5 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight);
    self.footnoteLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.footnoteLabel.alpha = 0.5;
    
    
    
//    self.coverPathBigImageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor blueColor];
//    self.subtitleLabel.backgroundColor = [UIColor greenColor];
//    self.circleImageView.backgroundColor = [UIColor grayColor];
//    self.footnoteLabel.backgroundColor = [UIColor purpleColor];
//    
//    
    
}
- (void)setModel:(KHJDetailListenModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverPathBigImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPathBig] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subtitle;
    self.circleImageView.image = [UIImage imageNamed:@"Unknown"];
    self.footnoteLabel.text = model.footnote;
   
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
