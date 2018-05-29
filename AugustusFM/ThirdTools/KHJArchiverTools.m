//
//  KHJArchiverTools.m
//  AugustusFM
//
//  Created by dllo on 16/7/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJArchiverTools.h"

@implementation KHJArchiverTools
+ (void)archiverObject:(id)object ByKey:(NSString *)key WithPath:(NSString *)path{
    //初始化存储对象信息的data
    NSMutableData *data = [NSMutableData data];
    //创建归档工具对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //开始归档
    [archiver encodeObject:object forKey:key];
    //结束归档
    [archiver finishEncoding];
    //写入本地
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *destPath = [[[[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"default"] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"]stringByAppendingPathComponent:path];
//    NSLog(@"%@",destPath);

    [data writeToFile:destPath atomically:YES];
}

//反归档
+ (id)unarchiverObjectByKey:(NSString *)key WithPath:(NSString *)path{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *destPath = [[[[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"default"] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"]stringByAppendingPathComponent:path];
    NSData *data = [NSData dataWithContentsOfFile:destPath];
//    NSLog(@"%@",destPath);
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //接收反归档对象
    id object = [unarchiver decodeObjectForKey:key];
    return object;
}



@end
