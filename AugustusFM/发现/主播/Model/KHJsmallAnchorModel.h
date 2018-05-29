//
//  KHJsmallAnchorModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJsmallAnchorModel : KHJBaseModel
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *smallLogo;
@property (nonatomic, copy) NSString *personDescribe;
@property (nonatomic, retain) NSNumber *tracksCounts;
@property (nonatomic, retain) NSNumber *followersCounts;
@property (nonatomic, retain) NSNumber *uid;

@end
