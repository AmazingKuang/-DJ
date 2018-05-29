//
//  KHJDataBaseTool.h
//  AugustusFM
//
//  Created by dllo on 16/8/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "KHJDetailRecommend.h"
@interface KHJDataBaseTool : NSObject
{
    sqlite3 *DBPoint;
}
//单列
+ (KHJDataBaseTool *)shareInstance;
//打开数据库
- (void)openDB;
//关闭数据库
- (void)closeDB;
//插入数据
- (void)insert:(KHJDetailRecommend *)model;
//创建表
- (void)createTable;
//查询所有
- (NSArray *)selectAll;
//是否收藏
- (BOOL)isCollectedInTableadS:(NSInteger)albumId;
//删除数据
- (void)deleteDataWithModel:(NSInteger)intStr;
//删除全部数据
- (void)removeAllData;

@end
