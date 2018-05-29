//
//  KHJRecommendCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJDetailRecommend.h"
#import "KHJspecialDetailViewController.h"
@interface KHJRecommendCell : UITableViewCell
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, copy) void(^block) (KHJspecialDetailViewController *khjspecialController);

@end
