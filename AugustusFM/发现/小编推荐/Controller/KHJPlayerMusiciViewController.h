//
//  KHJPlayerMusiciViewController.h
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseViewController.h"
#import "KHJParticularsModel.h"
@interface KHJPlayerMusiciViewController : KHJBaseViewController

@property (nonatomic, retain) KHJParticularsModel *model;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSArray *musicArr;

#pragma mark -- 单例方法,获取唯一的对象

+ (KHJPlayerMusiciViewController *)shareDetailViewController;


@end
