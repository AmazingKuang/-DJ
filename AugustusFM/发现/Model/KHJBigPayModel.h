//
//  KHJBigPayModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJBigPayModel : KHJBaseModel

@property (nonatomic, assign) NSNumber *categoryId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, retain) NSMutableArray *listArray;

@property (nonatomic, retain) NSString *coverPath;
@property (nonatomic, retain) NSNumber *idd;
@end
