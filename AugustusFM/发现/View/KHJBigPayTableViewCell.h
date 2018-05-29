//
//  KHJBigPayTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJBigPayModel.h"

#import "KHJspecialDetailViewController.h"
@interface KHJBigPayTableViewCell : UITableViewCell

@property (nonatomic, retain) KHJBigPayModel *model;
@property (nonatomic, copy) void (^block) (KHJspecialDetailViewController *kvc);




@end
