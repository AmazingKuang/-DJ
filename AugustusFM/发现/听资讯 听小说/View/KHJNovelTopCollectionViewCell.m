//
//  KHJNovelTopCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNovelTopCollectionViewCell.h"
#import <Masonry.h>
#import "GetHeightTools.h"

@implementation KHJNovelTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
    
        [self.contentView addSubview:_label];
        [_label release];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(8);
        make.bottom.equalTo(self.contentView).with.offset(-8);
       
    }];
//    self.label.backgroundColor = [UIColor blueColor];
    self.label.clipsToBounds = YES;
    self.label.layer.cornerRadius = 12;
    self.label.textColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textAlignment = 1;
    
}

- (void)setModel:(KHJIDModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.label.text  = model.keywordName;
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
