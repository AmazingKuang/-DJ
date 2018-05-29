//
//  KHJheaderView.m
//  AugustusFM
//
//  Created by dllo on 16/7/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJheaderView.h"
#import <UIImageView+WebCache.h>
#import "JXLDayAndNightMode.h"
@interface KHJheaderView ()
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *bigLabel;
@property (nonatomic, retain) UILabel *xiaobianLabel;
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;


@end

@implementation KHJheaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHead];
    }
    return self;
}

- (void)createHead{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * lFitWidth, 10 * lFitHeight, 50 * lFitWidth, 50 * lFitHeight)];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width +10 * lFitWidth, self.imageView.frame.origin.y + 10 * lFitHeight, 300 * lFitWidth, 30 * lFitHeight)];
    
    self.bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10 * lFitHeight, ScreenWidth - 20 * lFitWidth, 120 * lFitHeight)];
    
    self.xiaobianLabel = [[UILabel alloc] initWithFrame:CGRectMake(250 * lFitWidth, self.bigLabel.frame.origin.y + self.bigLabel.frame.size.height + 10 * lFitHeight, 50 * lFitWidth, 20 * lFitHeight)];
    
    
    
    
    
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.xiaobianLabel.frame.origin.x + self.xiaobianLabel.frame.size.width + 5 * lFitWidth, self.xiaobianLabel.frame.origin.y, 20 * lFitWidth, 20 * lFitHeight)];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width + 5, self.headImageView.frame.origin.y, 60 * lFitWidth, 20 * lFitHeight)];
    
    
    self.bigLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.xiaobianLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.nameLabel.font = [UIFont systemFontOfSize:14 * lFitWidth];
    self.bigLabel.alpha = 0.5;
    self.xiaobianLabel.alpha = 0.5;
    self.nameLabel.alpha = 0.5;
    self.bigLabel.numberOfLines = 0;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 10 * lFitHeight;
    
    [self addSubview:_imageView];
    [self addSubview:_titleLabel];
    [self addSubview:_bigLabel];
    [self addSubview:_xiaobianLabel];
    [self addSubview:_headImageView];
    [self addSubview:_nameLabel];
    
    /**
     *  夜间模式
     */
    
    [self jxl_setDayMode:^(UIView *view) {
        // 设置日间模式状态
        view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
    } nightMode:^(UIView *view) {
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _titleLabel.textColor = [UIColor whiteColor];
        _bigLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _bigLabel.textColor = [UIColor whiteColor];
        _xiaobianLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _xiaobianLabel.textColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        _nameLabel.textColor = [UIColor whiteColor];
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图

    }];
    
    
//    self.imageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
//    self.bigLabel.backgroundColor = [UIColor blueColor];
//    self.xiaobianLabel.backgroundColor = [UIColor purpleColor];
//    self.headImageView.backgroundColor = [UIColor brownColor];
//    self.nameLabel.backgroundColor = [UIColor redColor];
//    
   
   //    NSLog(@"%@",)
}
- (void)setDitionary:(NSDictionary *)ditionary{
    if (_ditionary != ditionary) {
        [_ditionary release];
        _ditionary = [ditionary retain];
    }
    self.imageView.image = [UIImage imageNamed:@"findsubject_cover"];
    self.titleLabel.text = [_ditionary objectForKey:@"title"];
    self.bigLabel.text = [_ditionary objectForKey:@"intro"];
    self.xiaobianLabel.text = @"小编:";
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[_ditionary objectForKey:@"smallLogo"]] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nameLabel.text = [_ditionary objectForKey:@"nickname"];

}
@end
