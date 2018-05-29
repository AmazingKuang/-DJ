//
//  KHJSpreadModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJSpreadModel.h"

@implementation KHJSpreadModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.des = value;
    }
}

@end
