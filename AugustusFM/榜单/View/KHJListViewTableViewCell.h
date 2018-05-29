//
//  KHJListViewTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJDetailRecommend.h"
@interface KHJListViewTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *coverPathImageVIew;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UILabel *firstTitleLabel;

@property (nonatomic, retain) UILabel *secondTitleLabel;

@property (nonatomic, retain) UIImageView *turnImageView;
@property (nonatomic, retain) KHJDetailRecommend *model;

@end
