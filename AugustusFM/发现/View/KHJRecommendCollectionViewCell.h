//
//  KHJRecommendCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJDetailRecommend.h"
@interface KHJRecommendCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *coverMiddleImageView;
@property (nonatomic, retain) UILabel *trackTitleLabel;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *ircleImageView;


@property (nonatomic, retain) KHJDetailRecommend *model;

@end
