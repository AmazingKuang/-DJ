//
//  KHJDetailListenModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJDetailListenModel : KHJBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *footnote;

@property (nonatomic, copy) NSString *coverPathBig;
@property (nonatomic, retain) NSNumber *releasedAt;

@property (nonatomic, retain) NSNumber *specialId;
@property (nonatomic, copy) NSString *coverPath;
@end
