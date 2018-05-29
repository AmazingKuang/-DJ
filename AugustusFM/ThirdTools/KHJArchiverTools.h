//
//  KHJArchiverTools.h
//  AugustusFM
//
//  Created by dllo on 16/7/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHJArchiverTools : NSObject
//归挡工具方法
+ (void)archiverObject:(id)object
                 ByKey:(NSString *)key
              WithPath:(NSString *)path;
//反归档
+ (id)unarchiverObjectByKey:(NSString *)key
                     WithPath:(NSString *)path;



@end
