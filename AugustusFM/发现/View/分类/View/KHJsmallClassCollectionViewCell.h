//
//  KHJsmallClassCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJBigPayModel.h"
@interface KHJsmallClassCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UIImageView *coverPathImageView;
@property (nonatomic, retain) UILabel *titleLabel;



@property (nonatomic, retain) KHJBigPayModel *model;

@end
