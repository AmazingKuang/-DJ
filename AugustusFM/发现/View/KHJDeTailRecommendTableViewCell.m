//
//  KHJDeTailRecommendTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDeTailRecommendTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJDeTailRecommendTableViewCell ()

@property (nonatomic, retain) UIImageView *coverMiddleImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *introLabel;
//三角符号
@property (nonatomic, retain) UIImageView *turnImageView;

@property (nonatomic, retain) UILabel *playsCountsLabel;

//集数图片
@property (nonatomic, retain) UIImageView *trackImageView;
@property (nonatomic, retain) UILabel *tracksLabel;

//右边箭头图片
@property (nonatomic, retain) UIImageView *rightImageView;

@end


@implementation KHJDeTailRecommendTableViewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.coverMiddleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverMiddleImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.introLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_introLabel];
        
        self.playsCountsLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_playsCountsLabel];
        
        self.turnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_turnImageView];
        
        self.tracksLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_tracksLabel];
        
        self.trackImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_trackImageView];
        
        self.rightImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImageView];
        
        
        [_coverMiddleImageView release];
        [_titleLabel release];
        [_introLabel release];
        [_playsCountsLabel release];
        [_turnImageView release];
        [_trackImageView release];
        [_tracksLabel release];
        
        
        [self jxl_setDayMode:^(UIView *view) {
            KHJDeTailRecommendTableViewCell *cell = (KHJDeTailRecommendTableViewCell *)view;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.introLabel.backgroundColor = [UIColor whiteColor];
            cell.introLabel.textColor = [UIColor blackColor];
            cell.tracksLabel.backgroundColor = [UIColor whiteColor];
            cell.tracksLabel.textColor = [UIColor blackColor];
            cell.playsCountsLabel.backgroundColor = [UIColor whiteColor];
            cell.playsCountsLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            KHJDeTailRecommendTableViewCell *cell = (KHJDeTailRecommendTableViewCell *)view;
            //            cell.backgroundColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.introLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.introLabel.textColor = [UIColor whiteColor];
            cell.tracksLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.tracksLabel.textColor = [UIColor whiteColor];
            cell.playsCountsLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            cell.playsCountsLabel.textColor = [UIColor whiteColor];
        }];
       
    }
    return self;
}
- (CGFloat)cellOffset
{
    /*
     - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
     将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
     这里用来获取self在window上的位置
     */
    CGRect toWindow = [self convertRect:self.bounds toView:self.window];
    
    //获取父视图的中心
    CGPoint windowCenter = self.superview.center;
    
    //cell在y轴上的位移  CGRectGetMidY之前讲过,获取中心Y值
    CGFloat cellOffsetY = CGRectGetMidY(toWindow) - windowCenter.y;
    
    //位移比例
    CGFloat offsetDig = 2 * cellOffsetY / self.superview.frame.size.height ;
    
    //要补偿的位移
    CGFloat offset =  -offsetDig * 90/2;
    
    //让pictureViewY轴方向位移offset
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    self.coverMiddleImageView.transform = transY;
    
    return offset;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.coverMiddleImageView.frame = CGRectMake(5 * lFitWidth, 5 * lFitHeight, 80 * lFitWidth, 80 * lFitWidth);
    self.introLabel.frame = CGRectMake(self.coverMiddleImageView.frame.origin.x + self.coverMiddleImageView.frame.size.width + 10 * lFitWidth, self.coverMiddleImageView.frame.origin.y, 230 * lFitWidth, 30 * lFitHeight);
    self.titleLabel.frame = CGRectMake(self.introLabel.frame.origin.x, self.introLabel.frame.origin.y + self.introLabel.frame.size.height, 270 * lFitWidth, 20 * lFitHeight);
    self.turnImageView.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 7 * lFitHeight, 8 * lFitWidth, 8 * lFitHeight);
    self.playsCountsLabel.frame = CGRectMake(self.turnImageView.frame.origin.x + self.turnImageView.frame.size.width + 5 * lFitWidth, self.turnImageView.frame.origin.y - 7 * lFitHeight, 80 * lFitWidth, 20 * lFitHeight);
    
    self.trackImageView.frame = CGRectMake(self.playsCountsLabel.frame.origin.x + self.playsCountsLabel.frame.size.width + 10 * lFitWidth, self.playsCountsLabel.frame.origin.y + 5 * lFitHeight, 10 * lFitWidth, 10 * lFitHeight);
    self.tracksLabel.frame = CGRectMake(self.trackImageView.frame.origin.x + self.trackImageView.frame.size.width + 5 * lFitWidth, self.trackImageView.frame.origin.y - 5 * lFitHeight, 60 * lFitHeight, 20 * lFitWidth);
    
    self.rightImageView.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 20 * lFitWidth, self.titleLabel.frame.origin.y, 8 * lFitWidth, 10 * lFitHeight);
    self.introLabel.font = [UIFont systemFontOfSize:17 * lFitWidth];
    self.titleLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.titleLabel.alpha = 0.5;
    self.playsCountsLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.playsCountsLabel.alpha = 0.5;
    self.rightImageView.alpha = 0.5;
    self.tracksLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.tracksLabel.alpha = 0.5;
    
    
//    self.rightImageView.backgroundColor = [UIColor yellowColor];
//    self.coverMiddleImageView.backgroundColor = [UIColor redColor];
//    self.introLabel.backgroundColor = [UIColor blueColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
//    self.turnImageView.backgroundColor =[UIColor purpleColor];
//    self.playsCountsLabel.backgroundColor = [UIColor brownColor];
//    self.trackImageView.backgroundColor = [UIColor cyanColor];
//    self.tracksLabel.backgroundColor = [UIColor grayColor];
//    
    
    
    
}
- (void)setModel:(KHJDetailRecommend *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
   
    [self.coverMiddleImageView sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"no_network"]];
    if (model.intro == nil) {
        self.titleLabel.text = [NSString stringWithFormat:@"根据<<%@>>推荐",model.nickname];

    }
    else{
    self.titleLabel.text = model.intro;
    }
    
    self.introLabel.text = model.title;
    self.turnImageView.image = [UIImage imageNamed:@"sound_playtimes"];
    self.playsCountsLabel.text = [NSString stringWithFormat:@"%.2lf万",[model.playsCounts floatValue] / 100000];
    self.rightImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
    self.trackImageView.image = [UIImage imageNamed:@"Unknown"];
    self.tracksLabel.text = [NSString stringWithFormat:@"%ld集",[model.tracks integerValue]];
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
