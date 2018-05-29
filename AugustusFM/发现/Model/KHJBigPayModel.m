//
//  KHJBigPayModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBigPayModel.h"
#import "KHJDetailRecommend.h"
@implementation KHJBigPayModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dic];
            [self.listArray addObject:model];
        }
    }
    
    
    if ([key isEqualToString:@"id"]) {
        self.idd = value;
    }
    
}
@end
