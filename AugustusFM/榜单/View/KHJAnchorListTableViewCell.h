//
//  KHJAnchorListTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJListViewModel.h"
@interface KHJAnchorListTableViewCell : UITableViewCell
@property (nonatomic, retain) KHJListViewModel *model;

@property (nonatomic, assign) NSInteger number;
@end
