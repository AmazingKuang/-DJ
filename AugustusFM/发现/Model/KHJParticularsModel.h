//
//  KHJParticularsModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJParticularsModel : KHJBaseModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSNumber *playtimes;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, retain) NSString *coverSmall;
@property (nonatomic, retain) NSNumber *comments;
@property (nonatomic, copy) NSString *playUrl64;
@property (nonatomic, copy) NSString *playUrl32;
@property (nonatomic, copy) NSString *playPathAacv164;
@property (nonatomic, copy) NSString *playPathAacv224;
@property (nonatomic,copy) NSNumber *uid;


@property (nonatomic, copy) NSString *tracksCounts;

@property (nonatomic, copy) NSString *tracks;



//@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *footnote;

@property (nonatomic, copy) NSString *coverPathBig;
@property (nonatomic, retain) NSNumber *releasedAt;

@property (nonatomic, retain) NSNumber *specialId;
@property (nonatomic, copy) NSString *coverPath;

@property (nonatomic, copy) NSString *playPath64;

@property (nonatomic, retain) NSNumber *playsCounts;

@property (nonatomic, retain) NSNumber *favoritesCounts;
@property (nonatomic, retain) NSNumber *commentsCounts;



@end
