//
//  KHJNovelRecommendCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJspecialDetailViewController.h"
@interface KHJNovelRecommendCollectionViewCell : UICollectionViewCell


@property (nonatomic, retain) NSMutableArray *topscrollviewArray;

@property (nonatomic, retain) NSMutableArray *mainArray;
@property (nonatomic, copy) void (^block)(KHJspecialDetailViewController *ksv);


@end
