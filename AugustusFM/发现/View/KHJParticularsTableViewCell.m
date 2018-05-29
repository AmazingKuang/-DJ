//
//  KHJParticularsTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJParticularsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJParticularsTableViewCell ()
@property (nonatomic, retain) UIImageView *coverMiddleImageView;

@property (nonatomic, retain) UILabel *titleLabel;
//三角符号
@property (nonatomic, retain) UIImageView *triangleImageView;

@property (nonatomic, retain) UILabel *playtimesLabel;

@property (nonatomic, retain) UILabel *commentsLabel;
//图片

//时间图片
@property (nonatomic, retain) UIImageView *timeImageView;

@property (nonatomic, retain) UILabel *durationLabel;

@property (nonatomic, retain) UIImageView *commmenImageView;
//下载
@property (nonatomic, retain) UIImageView *downloadImageView;

@end


@implementation KHJParticularsTableViewCell
- (void)dealloc{
    [_coverMiddleImageView release];
    [_titleLabel release];
    [_triangleImageView release];
    [_playtimesLabel release];
    [_commentsLabel release];
    [_timeImageView release];
    [_durationLabel release];
    [_commmenImageView release];
    [_downloadImageView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverMiddleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverMiddleImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.triangleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_triangleImageView];
        
        self.playtimesLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_playtimesLabel];
        
        self.commentsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_commentsLabel];
        
        
        self.commmenImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_commmenImageView];
        
        
        self.timeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_timeImageView];
        
        self.durationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_durationLabel];
        
        self.downloadImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_downloadImageView];
        
        
        /**
         *  夜间模式
         */
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJParticularsTableViewCell *cell = (KHJParticularsTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
//            cell.textLabel.backgroundColor = [UIColor whiteColor];
//            cell.textLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJParticularsTableViewCell *cell = (KHJParticularsTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.playtimesLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.playtimesLabel.textColor = [UIColor whiteColor];
            cell.commentsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.commentsLabel.textColor = [UIColor whiteColor];
            cell.durationLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.durationLabel.textColor = [UIColor whiteColor];

        }];

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverMiddleImageView.frame = CGRectMake(10 * lFitWidth, 10 * lFitHeight, 80 * lFitWidth, 80 * lFitHeight);
    self.coverMiddleImageView.layer.masksToBounds = YES;
    self.coverMiddleImageView.layer.cornerRadius = 40 * lFitHeight;
    self.titleLabel.frame = CGRectMake(self.coverMiddleImageView.frame.origin.x + self.coverMiddleImageView.frame.size.width + 10 * lFitWidth, self.coverMiddleImageView.frame.origin.y, 280 * lFitWidth, 60 * lFitHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:16 * lFitWidth];
    self.titleLabel.numberOfLines = 0;
    self.triangleImageView.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight);
    self.triangleImageView.alpha = 0.5;
    self.playtimesLabel.frame = CGRectMake(self.triangleImageView.frame.origin.x + self.triangleImageView.frame.size.width + 5 * lFitWidth, self.triangleImageView.frame.origin.y - 5 * lFitHeight, 60 * lFitWidth, 20 * lFitHeight);
    self.playtimesLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.playtimesLabel.alpha = 0.5;
    
    self.timeImageView.frame = CGRectMake(self.playtimesLabel.frame.origin.x + self.playtimesLabel.frame.size.width + 20 * lFitWidth, self.playtimesLabel.frame.origin.y + 5 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight);
    self.timeImageView.alpha = 0.5;
    
    self.durationLabel.frame = CGRectMake(self.timeImageView.frame.origin.x +self.timeImageView.frame.size.width +5 * lFitWidth, self.timeImageView.frame.origin.y - 5 * lFitHeight, 60 * lFitWidth, 20 * lFitHeight);
    self.durationLabel.alpha = 0.5;
    
    
    self.commmenImageView.frame = CGRectMake(self.durationLabel.frame.origin.x + self.durationLabel.frame.size.width + 20 * lFitWidth, self.durationLabel.frame.origin.y + 5 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight) ;
    self.commentsLabel.frame = CGRectMake(self.commmenImageView.frame.origin.x + self.commmenImageView.frame.size.width + 5 * lFitHeight, self.commmenImageView.frame.origin.y - 5 * lFitHeight, 50 * lFitWidth, 20 * lFitHeight);
    self.commentsLabel.alpha = 0.5;
    self.commentsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    
    self.downloadImageView.frame = CGRectMake(self.commentsLabel.frame.origin.x + self.commentsLabel.frame.size.width + 10 * lFitWidth, self.commentsLabel.frame.origin.y - 5 * lFitHeight, 35 * lFitWidth, 35 * lFitHeight);
//    self.downloadImageView.image = [UIImage imageNamed:@"np_more_down"];
 
//  
//    self.coverMiddleImageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor redColor];
//
//    self.playtimesLabel.backgroundColor = [UIColor blueColor];
//
//    self.triangleImageView.backgroundColor = [UIColor purpleColor];
//    self.timeImageView.backgroundColor = [UIColor greenColor];
//    self.durationLabel.backgroundColor = [UIColor brownColor];
//    self.commmenImageView.backgroundColor = [UIColor yellowColor];
//    self.downloadImageView.backgroundColor = [UIColor redColor];

    
}
- (void)setModel:(KHJParticularsModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.titleLabel.text = model.title;
    self.triangleImageView.image = [UIImage imageNamed:@"sound_playtimes"];
    if ([model.playtimes integerValue] < 10000) {
         self.playtimesLabel.text = [NSString stringWithFormat:@"%ld",[model.playtimes integerValue]];
    }
    else{
    self.playtimesLabel.text = [NSString stringWithFormat:@"%.f万",[model.playtimes floatValue] / 10000];
    }
    self.timeImageView.image = [UIImage imageNamed:@"Unknown"];
    self.durationLabel.text = [NSString stringWithFormat:@"%.2f",[model.duration floatValue] / 60];
    if (![model.comments isEqual:@0]) {
        self.commmenImageView.image = [UIImage imageNamed:@"sound_comments-1"];
        self.commentsLabel.text = [NSString stringWithFormat:@"%ld",[model.comments integerValue]];
    }
    else{
        self.commmenImageView.hidden = YES;
        self.commentsLabel.hidden = YES;
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
