//
//  KHJDetailRecommend.h
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJDetailRecommend : KHJBaseModel

@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, copy) NSNumber *playsCounts;
@property (nonatomic, retain) NSNumber *tracks;
@property (nonatomic, retain) NSString *coverSmall;
@property (nonatomic, assign) NSInteger albumId;


@property (nonatomic,copy) NSString *trackTitle;
@property (nonatomic, copy) NSString *coverPath;



//@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *firstTitle;
//@property (nonatomic, retain) NSString *coverPath;

@property (nonatomic, retain) NSMutableArray *firstKResults;

@property (nonatomic, retain) NSString *str;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, retain) NSNumber *followersCounts;

@property (nonatomic, copy) NSString *middleLogo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *personDescribe;

@property (nonatomic, copy) NSString *name;

@property (nonatomic,copy) NSString *contentType;
@property (nonatomic, copy) NSString *highlightKeyword;

//@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *imgPath;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, retain) NSString *recReason;
@end
