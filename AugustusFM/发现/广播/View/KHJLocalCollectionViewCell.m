//
//  KHJLocalCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJLocalCollectionViewCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJLocalCollectionViewCell ()

@end

@implementation KHJLocalCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.localimageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_localimageView];
        
        
        self.locaLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_locaLabel];
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJLocalCollectionViewCell *cell = (KHJLocalCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.locaLabel.backgroundColor = [UIColor whiteColor];
            cell.locaLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJLocalCollectionViewCell *cell = (KHJLocalCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.locaLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.locaLabel.textColor = [UIColor whiteColor];
        }];
        

        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.localimageView.frame = CGRectMake(15 * lFitWidth, 5 * lFitHeight, 40 * lFitWidth, 40 * lFitHeight);
    self.locaLabel.frame = CGRectMake(8 * lFitWidth, 50 * lFitHeight, 50 *lFitWidth, 30 * lFitHeight);
    self.locaLabel.font = [UIFont systemFontOfSize:15 * lFitWidth];
    self.locaLabel.textAlignment = 1;
//    self.localimageView.backgroundColor = [UIColor redColor];
//    self.locaLabel.backgroundColor = [UIColor blueColor];
}


@end
