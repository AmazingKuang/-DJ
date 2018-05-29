//
//  KHJTopDownBaseModel.m
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJTopDownBaseModel.h"

@implementation KHJTopDownBaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}
@end
