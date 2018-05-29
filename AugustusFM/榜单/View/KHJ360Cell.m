//
//  KHJ360Cell.m
//  AugustusFM
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJ360Cell.h"
#import <UIImageView+WebCache.h>



@implementation KHJ360Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.feedImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_feedImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        
        self.categoryLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_categoryLabel];
        
        self.namelabel = [[UILabel alloc] init];
        [self.contentView addSubview:_namelabel];
        
        self.duraTionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_duraTionLabel];
        
        self.topLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_topLabel];
        
       
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.feedImageView.frame = CGRectMake(0, 0, ScreenWidth, 220);
    self.titleLabel.frame = CGRectMake(50, 100, 300, 30);
    self.categoryLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + 80, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 20);
    self.titleLabel.textAlignment = 1;
    self.titleLabel.font = [UIFont systemFontOfSize:19];
    self.duraTionLabel.frame = CGRectMake(self.categoryLabel.frame.origin.x + self.categoryLabel.frame.size.width, self.categoryLabel.frame.origin.y, 150, 20);
    self.namelabel.frame = CGRectMake(self.categoryLabel.frame.origin.x - 20, self.duraTionLabel.frame.origin.y + self.duraTionLabel.frame.size.height + 5, 150, 20);
    
    self.topLabel.frame = CGRectMake(ScreenWidth - 80, 10, 60, 20);
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.categoryLabel.textColor = [UIColor whiteColor];
    self.duraTionLabel.textColor = [UIColor whiteColor];
    self.namelabel.textColor = [UIColor whiteColor];
    self.topLabel.textColor = [UIColor whiteColor];
    self.categoryLabel.font = [UIFont systemFontOfSize:15];
    self.categoryLabel.textAlignment = 1;
    self.namelabel.textAlignment = 1;
    self.duraTionLabel.font = [UIFont systemFontOfSize:15];
    self.topLabel.font = [UIFont systemFontOfSize:14];
//    self.feedImageView.image = [UIImage imageNamed:@"1F63787E7F1949EDEB659FF4ACE4DB04"];
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.categoryLabel.backgroundColor = [UIColor grayColor];
//    self.duraTionLabel.backgroundColor = [UIColor redColor];
//    self.namelabel.backgroundColor = [UIColor greenColor];
//    self.topLabel.backgroundColor = [UIColor purpleColor];
//
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedgesture:)];
    [self addGestureRecognizer:gesture];
    
}
- (void)didClickedgesture:(UILongPressGestureRecognizer *)getsure{
    if (getsure.state == UIGestureRecognizerStateEnded) {
        [self.namelabel setHidden:NO];
        [self.titleLabel setHidden:NO];
        [self.topLabel setHidden:NO];
        [self.categoryLabel setHidden:NO];
        [self.duraTionLabel setHidden:NO];
        self.alpha = 1;

    }else{
        [self.namelabel setHidden:YES];
        [self.titleLabel setHidden:YES];
        [self.topLabel setHidden:YES];
        [self.categoryLabel setHidden:YES];
        [self.duraTionLabel setHidden:YES];
        self.alpha = 0.8;
    }
    
    
    
    
}
- (NSString *)TimeBy:(NSInteger)number
{
    
    NSTimeInterval time = number + 28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate *detaildate= [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    return [dateFormatter stringFromDate:detaildate];
    
}

- (void)setModel:(KHJ360Model *)model{
    if (_model != model) {
        [_model release];
      _model = [model retain];
    }
    [self.feedImageView sd_setImageWithURL:[NSURL URLWithString:[[model.data objectForKey:@"cover"] objectForKey:@"feed"]]];
    self.titleLabel.text = [model.data objectForKey:@"title"];
    self.categoryLabel.text = [model.data objectForKey:@"category"];
    self.duraTionLabel.text = [NSString stringWithFormat:@"/  0%.2f",[[model.data objectForKey:@"duration"] floatValue] / 60];
//    if ([[model.data objectForKey:@"author"] isEqual:nil]) {
//        self.namelabel.text = [[model.data objectForKey:@"author"] objectForKey:@"name"];
//    }
    self.topLabel.text = [[model.data objectForKey:@"label"] objectForKey:@"text"];
    
}


@end
