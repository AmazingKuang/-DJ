//
//  KHJDalianModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/17.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDalianModel.h"

@implementation KHJDalianModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"playUrl"]) {
        self.ts24 = [value objectForKey:@"ts24"];
    }
}
@end
