//
//  KHJSearchModel.h
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJSearchModel : KHJBaseModel
@property (nonatomic, copy) NSString *highlightKeyword;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *imgPath;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *keyword;
@end
