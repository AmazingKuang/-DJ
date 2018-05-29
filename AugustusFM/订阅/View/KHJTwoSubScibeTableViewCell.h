//
//  KHJTwoSubScibeTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/8/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJCollectreCommendViewController.h"
@interface KHJTwoSubScibeTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *bigImageView;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, copy) void (^block)(KHJCollectreCommendViewController *);
@end
