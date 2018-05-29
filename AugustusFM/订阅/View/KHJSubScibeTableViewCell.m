//
//  KHJSubScibeTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/8/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSubScibeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJSubScibeTableViewCell ()
@property (nonatomic, retain) UIImageView *coverMiddleImageVIew;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *introLabe;

@end

@implementation KHJSubScibeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverMiddleImageVIew = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverMiddleImageVIew];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        self.introLabe = [[UILabel alloc] init];
        [self.contentView addSubview:_introLabe];
        
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJSubScibeTableViewCell *cell = (KHJSubScibeTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.textColor = [UIColor blackColor];
            cell.introLabe.backgroundColor = [UIColor whiteColor];
            cell.introLabe.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJSubScibeTableViewCell *cell = (KHJSubScibeTableViewCell *)view;
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.textColor = [UIColor whiteColor];
            cell.introLabe.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.introLabe.textColor = [UIColor whiteColor];
        }];

        
        
        
        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverMiddleImageVIew.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.nameLabel.frame = CGRectMake(self.coverMiddleImageVIew.frame.origin.x + self.coverMiddleImageVIew.frame.size.width + 5 * lFitWidth, self.coverMiddleImageVIew.frame.origin.y + 5 * lFitHeight, 300 * lFitWidth, 30 * lFitHeight);
    self.introLabe.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5 * lFitHeight, 300 * lFitWidth, 30 * lFitHeight);
    _introLabe.font = [UIFont systemFontOfSize:14];
    
    
//    self.coverMiddleImageVIew.backgroundColor = [UIColor redColor];
//    self.nameLabel.backgroundColor = [UIColor greenColor];
//    self.introLabe.backgroundColor = [UIColor blueColor];
}
- (void)setModel:(KHJDetailRecommend *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
        [self.coverMiddleImageVIew sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"no_network"]];
        self.nameLabel.text = model.title;
        self.introLabe.text = model.intro;
       
    }
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
