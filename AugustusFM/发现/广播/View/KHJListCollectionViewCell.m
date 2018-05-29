//
//  KHJListCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/17.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJListCollectionViewCell.h"
#import "JXLDayAndNightMode.h"
@implementation KHJListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(35 * lFitWidth, 15 * lFitHeight, 20 * lFitWidth, 10 * lFitHeight)];
        [self.contentView  addSubview:_imageView];
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJListCollectionViewCell *cell = (KHJListCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJListCollectionViewCell *cell = (KHJListCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.textColor = [UIColor whiteColor];
        }];

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.frame = self.contentView.bounds;
    self.nameLabel.textAlignment = 1;
//    self.nameLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
}
- (void)setModel:(KHJTopDownBaseModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.nameLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.nameLabel.text = model.name;
}

@end
