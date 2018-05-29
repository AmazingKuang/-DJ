//
//  KHJClassificationTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJNovelDetailViewController.h"
@interface KHJClassificationTableViewCell : UITableViewCell

@property (nonatomic, retain) NSMutableArray *array;

//个数
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, copy) void (^block) (KHJNovelDetailViewController *kndvc);


@end
