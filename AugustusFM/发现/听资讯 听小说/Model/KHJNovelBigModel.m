//
//  KHJNovelBigModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNovelBigModel.h"
#import "KHJDetailRecommend.h"
@implementation KHJNovelBigModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] initWithDic:dic];
//            NSLog(@"%@", model.title);
            [self.listArray addObject:model];
        }
    }
}


@end
