//
//  KHJListCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/17.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJTopDownBaseModel.h"
@interface KHJListCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UILabel *nameLabel;

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) KHJTopDownBaseModel *model;
@end
