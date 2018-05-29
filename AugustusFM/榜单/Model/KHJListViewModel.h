//
//  KHJListViewModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJListViewModel : KHJBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *firstTitle;
@property (nonatomic, retain) NSString *coverPath;

@property (nonatomic, retain) NSMutableArray *firstKResults;

@property (nonatomic, retain) NSString *str;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, retain) NSNumber *followersCounts;

@property (nonatomic, copy) NSString *middleLogo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *personDescribe;

@property (nonatomic, copy) NSString *name;

@property (nonatomic,copy) NSString *contentType;

@end
