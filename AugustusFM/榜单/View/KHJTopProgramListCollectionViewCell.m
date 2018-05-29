//
//  KHJTopProgramListCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTopProgramListCollectionViewCell.h"
#import <Masonry.h>
@implementation KHJTopProgramListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        self.view = [[UIView alloc] init];
        [self.label addSubview:_view];
        [_label release];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).with.offset(10 * lFitWidth);
        make.top.equalTo(self.contentView).with.offset(8 * lFitWidth);
        make.bottom.equalTo(self.contentView).with.offset(-8 * lFitWidth);
    }];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.left).offset(5 * lFitWidth);
        make.right.equalTo(self.label.right).offset(-5 * lFitWidth);
        make.top.equalTo(self.label.bottom).offset(-2);
        make.bottom.equalTo(self.label.bottom);
    }];
    self.label.textAlignment = 1;
    
    self.label.font = [UIFont systemFontOfSize:17 * lFitWidth];
}

- (void)setModel:(KHJListViewModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.label.text  = model.name;
}

-(void)setDidSelected:(BOOL)didSelected{
    if (didSelected == YES) {
        self.label.textColor = [UIColor redColor];
        self.view.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.label.textColor = [UIColor blackColor];
        self.view.backgroundColor = [UIColor whiteColor];

    }
    
}

@end
