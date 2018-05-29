//
//  KHJmoreRankTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJDalianModel.h"
@interface KHJmoreRankTableViewCell : UITableViewCell
@property (nonatomic, retain) KHJDalianModel *model;
@property (nonatomic, retain) UIImageView *soundImageView;
@property (nonatomic, assign) NSInteger labelinter;
@end
