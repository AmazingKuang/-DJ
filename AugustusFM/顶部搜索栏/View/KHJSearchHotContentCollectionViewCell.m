//
//  KHJSearchHotContentCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSearchHotContentCollectionViewCell.h"
#import "JXLDayAndNightMode.h"
@implementation KHJSearchHotContentCollectionViewCell
- (void)dealloc
{
    [_label release];
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15 * lFitWidth];
        self.label.layer.cornerRadius = 12.5 * lFitHeight;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.layer.masksToBounds = YES;
        self.label.layer.borderColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1].CGColor;
        self.label.layer.borderWidth = 1;
        [self.contentView addSubview:_label];
        [_label release];
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJSearchHotContentCollectionViewCell *cell = (KHJSearchHotContentCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.label.backgroundColor = [UIColor whiteColor];
            cell.label.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJSearchHotContentCollectionViewCell *cell = (KHJSearchHotContentCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.label.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.label.textColor = [UIColor whiteColor];
        }];

        
        
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.offset(0);
    }];
}



@end
