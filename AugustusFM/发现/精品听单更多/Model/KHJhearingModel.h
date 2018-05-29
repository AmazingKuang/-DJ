//
//  KHJhearingModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJhearingModel : KHJBaseModel

@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, retain) NSNumber *playsCounts;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSNumber *favoritesCounts;
@property (nonatomic, retain) NSNumber *commentsCounts;



@end
