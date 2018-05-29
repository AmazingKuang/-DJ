//
//  KHJTwoSubScibeTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/8/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTwoSubScibeTableViewCell.h"

@implementation KHJTwoSubScibeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bigImageView = [[UIImageView alloc] init];
        [self addSubview:_bigImageView];
        
            }
    return self;
}
- (void)layoutSubviews{
    self.bigImageView.frame = CGRectMake(0, 0, ScreenWidth, 350 * lFitHeight);
}
- (void)didClickedButton{
    KHJCollectreCommendViewController *vc = [[KHJCollectreCommendViewController alloc] init];
    self.block(vc);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
