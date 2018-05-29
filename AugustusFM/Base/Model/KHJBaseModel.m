//
//  KHJBaseModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseModel.h"

@implementation KHJBaseModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (void)setNilValueForKey:(NSString *)key{
    
}


@end
