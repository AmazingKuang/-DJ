//
//  KHJ360Model.h
//  AugustusFM
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@interface KHJ360Model : KHJBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSDictionary *author;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, retain) NSDictionary *label;
@property (nonatomic, retain) NSDictionary *cover;
@property (nonatomic, retain) NSDictionary *data;

@end
