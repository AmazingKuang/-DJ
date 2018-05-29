//
//  KHJSpreadTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSpreadTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJSpreadTableViewCell ()
@property (nonatomic, retain) UIImageView *coverImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;

@end
@implementation KHJSpreadTableViewCell
- (void)dealloc{
    [_coverImageView release];
    [_nameLabel release];
    [_descriptionLabel release];
    [super dealloc];
}


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        self.descriptionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_descriptionLabel];
        
        [_coverImageView release];
        [_nameLabel release];
        [_descriptionLabel release];
        [self jxl_setDayMode:^(UIView *view) {
            KHJSpreadTableViewCell *cell = (KHJSpreadTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.textColor = [UIColor blackColor];
            cell.descriptionLabel.backgroundColor = [UIColor whiteColor];
            cell.descriptionLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJSpreadTableViewCell *cell = (KHJSpreadTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.textColor = [UIColor whiteColor];
            cell.descriptionLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.descriptionLabel.textColor = [UIColor whiteColor];
        }];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverImageView.frame = CGRectMake(10 * lFitWidth, 5 * lFitHeight, ScreenWidth - 20 * lFitWidth, 100 * lFitHeight);
    self.nameLabel.frame = CGRectMake(self.coverImageView.frame.origin.x, self.coverImageView.frame.origin.y + self.coverImageView.frame.size.height , 200 * lFitWidth , 30 * lFitHeight);
    self.descriptionLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height , 200 * lFitWidth, 20 * lFitHeight);
    self.nameLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.descriptionLabel.alpha = 0.5;
    
    
//    self.coverImageView.backgroundColor = [UIColor redColor];
//    self.nameLabel.backgroundColor = [UIColor blueColor];
//    self.descriptionLabel.backgroundColor = [UIColor greenColor];
//    
}
- (void)setModel:(KHJSpreadModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nameLabel.text = model.name;
    self.descriptionLabel.text = model.des;
    
    
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
