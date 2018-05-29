//
//  KHJNovelTopCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJIDModel.h"
@interface KHJNovelTopCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UILabel *label;

@property (nonatomic, assign) BOOL didSelected;
@property (nonatomic, retain) KHJIDModel *model;
@end
