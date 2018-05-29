//
//  KHJSearchContentTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSearchContentTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@implementation KHJSearchContentTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView release];
        
        self.titleLbel = [[UILabel alloc] init];
        self.titleLbel.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1];
        self.titleLbel.font = [UIFont systemFontOfSize:13 * lFitWidth];
        [self.contentView addSubview:_titleLbel];
        [_titleLbel release];
        
        self.categoryLabel = [[UILabel alloc] init];
        self.categoryLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        self.categoryLabel.font = [UIFont systemFontOfSize:11 * lFitWidth];
        self.categoryLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_categoryLabel];
        [_categoryLabel release];
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJSearchContentTableViewCell *cell = (KHJSearchContentTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLbel.backgroundColor = [UIColor whiteColor];
            cell.titleLbel.textColor = [UIColor blackColor];
            cell.categoryLabel.backgroundColor = [UIColor whiteColor];
            cell.categoryLabel.textColor = [UIColor blackColor];

        } nightMode:^(UIView *view) {
            KHJSearchContentTableViewCell *cell = (KHJSearchContentTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLbel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLbel.textColor = [UIColor whiteColor];
            cell.categoryLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.categoryLabel.textColor = [UIColor whiteColor];

        }];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10 * lFitWidth);
        make.top.equalTo(self.contentView).with.offset(8 * lFitHeight);
        make.width.equalTo(34 * lFitWidth);
        make.height.equalTo(34 * lFitHeight);
    }];
    
    [self.titleLbel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.right).with.offset(10 * lFitWidth);
        make.centerY.equalTo(self.leftImageView.centerY).with.offset(0);
        make.width.equalTo(180 * lFitWidth);
        make.height.equalTo(20 * lFitHeight);
    }];
    
    [self.categoryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-15 * lFitWidth);
        make.centerY.equalTo(self.leftImageView.centerY).with.offset(0);
        make.width.equalTo(60 * lFitWidth);
        make.height.equalTo(20 * lFitHeight);
    }];
}

- (void)setModel:(KHJDetailRecommend *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"netsound_default"]];
    self.titleLbel.text = model.keyword;
    self.categoryLabel.text = model.category;
    
    //搜索关键字高亮:
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.titleLbel.text];
    
    NSStringCompareOptions mask = NSCaseInsensitiveSearch | NSNumericSearch;
    
    NSRange range = [self.titleLbel.text rangeOfString:self.searchText options:mask];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    [self.titleLbel setAttributedText:attri];
    [attri release];
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
