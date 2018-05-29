//
//  KHJNoDataSearchView.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNoDataSearchView.h"

@implementation KHJNoDataSearchView

- (void)dealloc
{
    [_noDataSearchImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化提示图:
        self.noDataSearchImageView = [[UIImageView alloc] init];
        self.noDataSearchImageView.image = [UIImage imageNamed:@"noData_search"];//340*370
        [self addSubview:_noDataSearchImageView];
        [_noDataSearchImageView release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.noDataSearchImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).with.offset(0);
        make.centerY.equalTo(self.centerY).with.offset(0);
        make.width.equalTo(170 * lFitWidth);
        make.height.equalTo(185 * lFitHeight);
    }];
}

@end
