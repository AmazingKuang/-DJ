//
//  KHJNovelMainCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJspecialDetailViewController.h"
#import <MJRefresh.h>
@protocol KHJNovelMainCollectionViewCellDelegate <NSObject>

- (void)getdelegateData:(NSInteger)page;


@end

@interface KHJNovelMainCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UITableView *tableView;


@property (nonatomic, retain) NSMutableArray *listArray;

@property (nonatomic, copy) void (^block)(KHJspecialDetailViewController *kspecial);

@property (nonatomic, assign) id <KHJNovelMainCollectionViewCellDelegate>delegate;
@end
