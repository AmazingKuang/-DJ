//
//  KHJsmallClassCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJsmallClassCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJsmallClassCollectionViewCell ()
@end

@implementation KHJsmallClassCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverPathImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverPathImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJsmallClassCollectionViewCell *cell = (KHJsmallClassCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJsmallClassCollectionViewCell *cell = (KHJsmallClassCollectionViewCell *)view;
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
        }];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverPathImageView.frame = CGRectMake(30 * lFitWidth, 5 * lFitHeight, 32 * lFitWidth, 32 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.coverPathImageView.frame.origin.x + self.coverPathImageView.frame.size.width + 10 * lFitWidth, 5 * lFitHeight, 80 * lFitWidth, 30 * lFitHeight);
    
//    self.coverPathImageView.backgroundColor = [UIColor greenColor];
//    self.titleLabel.backgroundColor = [UIColor blueColor];
    
}
- (void)setModel:(KHJBigPayModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.titleLabel.text = model.title;
    self.titleLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    [self.coverPathImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"no_network"]];
    
}
@end
