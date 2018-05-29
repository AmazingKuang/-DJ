//
//  KHJMySelfTableCell.m
//  AugustusFM
//
//  Created by dllo on 16/8/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJMySelfTableCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJMySelfTableCell ()

@end

@implementation KHJMySelfTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameImageVIew = [[UIImageView alloc] init];
        [self.contentView addSubview:_nameImageVIew];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        self.turnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_turnImageView];
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJMySelfTableCell *cell = (KHJMySelfTableCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJMySelfTableCell *cell = (KHJMySelfTableCell *)view;
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
    [self.nameImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.equalTo(30);
        make.top.equalTo(self.contentView).offset(5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameImageVIew.right).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];
    [self.turnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.right).offset(-30);
        make.top.equalTo(self.contentView).offset(15);
        make.height.with.equalTo(13);
    }];
//    _nameLabel.backgroundColor = [UIColor redColor];
    _nameLabel.font = [UIFont systemFontOfSize:17 * lFitHeight];
//    _nameImageVIew.backgroundColor = [UIColor greenColor];
    
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
