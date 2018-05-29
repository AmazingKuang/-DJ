//
//  KHJ360Model.m
//  AugustusFM
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJ360Model.h"

@implementation KHJ360Model
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.duration = [value integerValue];
    }
}
@end
