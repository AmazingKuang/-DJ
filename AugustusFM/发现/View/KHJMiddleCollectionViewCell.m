//
//  KHJMiddleCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJMiddleCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJMiddleCollectionViewCell ()
//定义图片
@property (nonatomic, retain)UIImageView *coverPathImageView;
//定义label的名称
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation KHJMiddleCollectionViewCell
- (void)dealloc{
    [_coverPathImageView release];
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverPathImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverPathImageView];
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJMiddleCollectionViewCell *cell = (KHJMiddleCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJMiddleCollectionViewCell *cell = (KHJMiddleCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
        
        }];

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverPathImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 25 * lFitHeight);
//    self.coverPathImageView.layer.masksToBounds = YES;
//    self.coverPathImageView.layer.cornerRadius = 40;
    self.titleLabel.frame = CGRectMake(0, self.coverPathImageView.frame.origin.y + self.coverPathImageView.frame.size.height + 5 * lFitHeight , self.contentView.bounds.size.width, 20 * lFitHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:15 * lFitHeight];
    self.titleLabel.textAlignment = 1;
//    self.coverPathImageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
}
- (void)setModel:(KHJDetailRecommend *)model{
    if (_model != model) {
       [_model release];
        _model = [model retain];
    }
    [self.coverPathImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
}

@end
