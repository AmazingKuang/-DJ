//
//  KHJBigRecommengModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBigRecommengModel.h"
#import "KHJRecommengModel.h"
@implementation KHJBigRecommengModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            KHJRecommengModel *model = [[KHJRecommengModel alloc] initWithDic:dic];
            [self.listArray addObject:model];
        }
    }
}

@end
