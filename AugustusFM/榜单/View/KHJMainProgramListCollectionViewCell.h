//
//  KHJMainProgramListCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJspecialDetailViewController.h"
#import "KHJPlayerMusiciViewController.h"
@interface KHJMainProgramListCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, retain) NSMutableArray *firstArray;
@property (nonatomic, retain) NSMutableArray *albumArray;
@property (nonatomic, copy) void(^block)(KHJspecialDetailViewController *);

@property (nonatomic, copy) void (^blk)(KHJPlayerMusiciViewController *);
@end
