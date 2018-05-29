//
//  KHJAnchorModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJAnchorModel : KHJBaseModel

@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSNumber *uid;
@end
