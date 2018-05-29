//
//  KHJAnchorTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJAnchorModel.h"
#import "KHJSecondAnchorDetailViewController.h"
@interface KHJAnchorTableViewCell : UITableViewCell

@property (nonatomic, retain) KHJAnchorModel *model;

@property (nonatomic, copy) void (^block)(KHJSecondAnchorDetailViewController *);

@end
