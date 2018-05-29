//
//  KHJDalianTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/17.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDalianTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJDalianTableViewCell ()
@property (nonatomic, retain) UIImageView *coverSmallImageView;

@property (nonatomic, retain) UILabel *nameLabel;

@property (nonatomic, retain) UILabel *programNameLabel;

@property (nonatomic, retain) UIImageView *turnImageView;


@property (nonatomic, retain) UILabel *playCountLabel;




@property (nonatomic, retain) UIView *lineImageView;

@end
@implementation KHJDalianTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverSmallImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        self.programNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_programNameLabel];
        
        self.turnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_turnImageView];
        
        self.playCountLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_playCountLabel];
        
        
        self.soundImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_soundImageView];
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJDalianTableViewCell *cell = (KHJDalianTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.backgroundColor = [UIColor whiteColor];
            cell.nameLabel.textColor = [UIColor blackColor];
            cell.programNameLabel.backgroundColor = [UIColor whiteColor];
            cell.programNameLabel.textColor = [UIColor blackColor];
            cell.playCountLabel.backgroundColor = [UIColor whiteColor];
            cell.playCountLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJDalianTableViewCell *cell = (KHJDalianTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.nameLabel.textColor = [UIColor whiteColor];
            cell.programNameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.programNameLabel.textColor = [UIColor whiteColor];
            cell.playCountLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.playCountLabel.textColor = [UIColor whiteColor];
        }];

       
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverSmallImageView.frame = CGRectMake(5 * lFitWidth, 5 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);

    self.nameLabel.frame = CGRectMake(self.coverSmallImageView.frame.origin.x + self.coverSmallImageView.frame.size.width + 5 * lFitWidth, self.coverSmallImageView.frame.origin.y, 300 * lFitWidth, 30 * lFitHeight);
    
    self.programNameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5, 200 * lFitWidth, 30 * lFitHeight);
    self.turnImageView.frame = CGRectMake(self.programNameLabel.frame.origin.x, self.programNameLabel.frame.origin.y + self.programNameLabel.frame.size.height + 6 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight);
    self.playCountLabel.frame = CGRectMake(self.turnImageView.frame.origin.x + self.turnImageView.frame.size.width + 5 * lFitWidth, self.turnImageView.frame.origin.y - 4 * lFitHeight, 100 * lFitWidth, 20 * lFitHeight);
    self.soundImageView.frame = CGRectMake(self.programNameLabel.frame.origin.x + self.programNameLabel.frame.size.width + 80 * lFitWidth, self.programNameLabel.frame.origin.y, 25 * lFitWidth, 25 * lFitWidth);
    
    
    self.nameLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.playCountLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    
    self.programNameLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.programNameLabel.alpha = 0.5;
    
    
//    self.coverSmallImageView.backgroundColor = [UIColor redColor];
//    self.nameLabel.backgroundColor = [UIColor blueColor];
//    self.programNameLabel.backgroundColor = [UIColor greenColor];
//    self.turnImageView.backgroundColor = [UIColor purpleColor];
//    self.playCountLabel.backgroundColor = [UIColor brownColor];
    
}

- (void)setModel:(KHJDalianModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    [self.coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nameLabel.text = model.name;
    if (model.programName == nil) {
        self.programNameLabel.text = @"暂无播放节目";
    }
    else{
    self.programNameLabel.text = [NSString stringWithFormat:@"正在直播: %@",model.programName];
    }
    self.playCountLabel.text = [NSString stringWithFormat:@"%.2lf万人",[model.playCount floatValue]/ 10000];
    self.turnImageView.image = [UIImage imageNamed:@"sound_playtimes"];
    
    self.soundImageView.image = [UIImage imageNamed:@"sound_playbtn"];
    
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
