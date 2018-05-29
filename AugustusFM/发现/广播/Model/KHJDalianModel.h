//
//  KHJDalianModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/17.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJDalianModel : KHJBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *programName;
@property (nonatomic, retain) NSString *ts24;
@property (nonatomic, retain) NSNumber *playCount;


@end
