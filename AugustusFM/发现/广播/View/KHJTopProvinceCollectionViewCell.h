//
//  KHJTopProvinceCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJProvinceModel.h"
@interface KHJTopProvinceCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UILabel *label;

@property (nonatomic, assign) BOOL didSelected;

@property (nonatomic, retain) KHJProvinceModel *model;
@end
