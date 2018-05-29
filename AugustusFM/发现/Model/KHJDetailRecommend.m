//
//  KHJDetailRecommend.m
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDetailRecommend.h"

@implementation KHJDetailRecommend
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"properties"]) {
        self.albumId = [[value objectForKey:@"albumId"] integerValue];
        self.key = [value objectForKey:@"key"];
        self.contentType = [value objectForKey:@"contentType"];
    }
    if ([key isEqualToString:@"id"]) {
        self.albumId = [value integerValue];
    }
}

@end
