//
//  KHJPayCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJPayCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@implementation KHJPayCollectionViewCell

- (void)dealloc{
    [_coverMiddleImageView release];
    [_titleLabel release];
    [_trackTitleLabel release];
    [_ircleImageView release];
    [super dealloc];
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverMiddleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverMiddleImageView];
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        self.trackTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_trackTitleLabel];
        self.ircleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_ircleImageView];
        
        [_coverMiddleImageView release];
        [_titleLabel release];
        [_trackTitleLabel release];
        [_ircleImageView release];
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJPayCollectionViewCell *cell = (KHJPayCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.trackTitleLabel.backgroundColor = [UIColor whiteColor];
            cell.trackTitleLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJPayCollectionViewCell *cell = (KHJPayCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.trackTitleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.trackTitleLabel.textColor = [UIColor whiteColor];        }];


    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverMiddleImageView.frame = CGRectMake(5 * lFitWidth, 5 * lFitHeight, self.contentView.bounds.size.width, 110 * lFitHeight);
    self.trackTitleLabel.frame = CGRectMake(self.coverMiddleImageView.frame.origin.x, self.coverMiddleImageView.frame.origin.y + self.coverMiddleImageView.frame.size.height + 8 * lFitHeight, self.coverMiddleImageView.frame.size.width, 40 * lFitHeight);
    self.ircleImageView.frame = CGRectMake(self.trackTitleLabel.frame.origin.x, self.trackTitleLabel.frame.origin.y + self.trackTitleLabel.frame.size.height + 5 * lFitHeight, 15 * lFitWidth, 15 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.ircleImageView.frame.origin.x+ self.ircleImageView.frame.size.width + 5, self.ircleImageView.frame.origin.y - 3, self.trackTitleLabel.frame.size.width - 15 * lFitWidth, 20 * lFitHeight);
    self.titleLabel.alpha = 0.5;
    self.trackTitleLabel.font = [UIFont systemFontOfSize:15 * lFitWidth];
    self.trackTitleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:12 * lFitWidth];
    
    
//        self.coverMiddleImageView.backgroundColor = [UIColor redColor];
//        self.trackTitleLabel.backgroundColor = [UIColor greenColor];
//        self.titleLabel.backgroundColor = [UIColor blueColor];
    
}


- (void)setModel:(KHJDetailRecommend *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.trackTitleLabel.text = model.intro;
    [self.coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
    self.ircleImageView.image = [UIImage imageNamed:@"Unknown"];
    
}
@end
