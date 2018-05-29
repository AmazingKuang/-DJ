//
//  KHJFindTopSearchView.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJFindTopSearchView.h"

@implementation KHJFindTopSearchView

- (void)dealloc{
    [_logoLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoLabel = [[UILabel alloc] init];
       self.logoLabel.text = @"动听DJ";
        self.logoLabel.textColor = [UIColor brownColor];
        self.logoLabel.font = [UIFont fontWithName:@"Baskerville" size:22];
        self.logoLabel.textAlignment = 1;
        self.logoLabel.layer.masksToBounds = YES;
        self.logoLabel.layer.cornerRadius = 5;
        [self addSubview:_logoLabel];
        [_logoLabel release];
        
        //初始化搜索按钮:
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchButton setImage:[UIImage imageNamed:@"icon_search_n"] forState:UIControlStateNormal];
        [self.searchButton setImage:[UIImage imageNamed:@"icon_search_h"] forState:UIControlStateHighlighted];
        [self.searchButton addTarget:self action:@selector(didClickedToChangeImage:) forControlEvents:UIControlEventTouchDown];
        [self.searchButton addTarget:self action:@selector(didClickedSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchButton];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(5);
        make.top.mas_equalTo(self.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100 * lFitWidth , 30 * lFitHeight));
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.mas_top).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
}

#pragma mark -- 点击按钮图片变色:
- (void)didClickedToChangeImage:(UIButton *)sender
{
    sender.highlighted = YES;
}

#pragma mark -- 点击搜索按钮方法:
- (void)didClickedSearchButton:(UIButton *)sender
{
    sender.highlighted = NO;
    self.turnToSearchPageBlock();
}

@end
