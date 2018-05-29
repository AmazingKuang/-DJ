//
//  KHJAnchorModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJAnchorModel.h"
#import "KHJsmallAnchorModel.h"
@implementation KHJAnchorModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            KHJsmallAnchorModel *model = [[KHJsmallAnchorModel alloc] initWithDic:dic];
            [self.listArray addObject:model];
        }
    }
}


@end
