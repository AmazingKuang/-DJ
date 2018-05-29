//
//  KHJTopProvinceCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTopProvinceCollectionViewCell.h"
#import <Masonry.h>
#import "JXLDayAndNightMode.h"
@implementation KHJTopProvinceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        
        [self.contentView addSubview:_label];
        [_label release];
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJTopProvinceCollectionViewCell *cell = (KHJTopProvinceCollectionViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.label.backgroundColor = [UIColor whiteColor];
            cell.label.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJTopProvinceCollectionViewCell *cell = (KHJTopProvinceCollectionViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.label.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.label.textColor = [UIColor whiteColor];
        }];

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView).with.offset(5 * lFitWidth);
        make.top.equalTo(self.contentView).with.offset(8 * lFitWidth);
        make.bottom.equalTo(self.contentView).with.offset(-8 * lFitWidth);
        
    }];
//        self.label.backgroundColor = [UIColor redColor];
    self.label.clipsToBounds = YES;
    self.label.layer.cornerRadius = 12 * lFitHeight;
    self.label.textColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1];
    self.label.font = [UIFont systemFontOfSize:15 * lFitWidth];
    self.label.textAlignment = 1;
    
}
- (void)setModel:(KHJProvinceModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.label.text = model.name;
    
}

-(void)setDidSelected:(BOOL)didSelected{
    if (didSelected == YES) {
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.label.textColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1];
        self.label.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    }
    
}



@end
