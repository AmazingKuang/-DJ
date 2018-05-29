//
//  KHJTopProgramListCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJListViewModel.h"
@interface KHJTopProgramListCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) KHJListViewModel *model;
@property (nonatomic, assign) BOOL didSelected;
@end
