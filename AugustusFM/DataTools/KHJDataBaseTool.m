//
//  KHJDataBaseTool.m
//  AugustusFM
//
//  Created by dllo on 16/8/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDataBaseTool.h"

@implementation KHJDataBaseTool
+ (KHJDataBaseTool *)shareInstance{
    static KHJDataBaseTool *dataBase = nil;
    if (dataBase == nil) {
        dataBase = [[KHJDataBaseTool alloc] init];
        [dataBase openDB];
        [dataBase createTable];
    }
    return dataBase;
}

- (void)openDB{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"file.sqlite"];
    NSLog(@"%@",dbPath);
    int result = sqlite3_open([dbPath UTF8String], &DBPoint);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    }
    else{
        NSLog(@"数据库打开失败");
    }
}
//关闭数据库
- (void)closeDB{
    int result = sqlite3_close(DBPoint);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    }else{
        NSLog(@"数据库关闭失败");
    }
}
- (void)createTable{
    NSString *string = [NSString stringWithFormat:@"create table if not exists music(albumId NSInteger primary key,title text,intro text,coverMiddle text)"];
    int result = sqlite3_exec(DBPoint,[string UTF8String],NULL,NULL,NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }
    
    else{
        NSLog(@"创建表失败");
    }
}
#pragma mark -- 插入数据
- (void)insert:(KHJDetailRecommend *)model{
    NSString *sqliteStr = [NSString stringWithFormat:@"insert into music values('%ld','%@','%@','%@')",model.albumId ,model.title,model.intro,model.coverMiddle];
    int result = sqlite3_exec(DBPoint, [sqliteStr UTF8String], nil, nil, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"添加教程成功");
    }else{
        NSLog(@"添加教程失败%d",result);
    }

}
#pragma mark -- 判断是否收藏
- (BOOL)isCollectedInTableadS:(NSInteger)ads{
    BOOL isCollected = 0;
    //打开数据库
    [self openDB];
    NSString *sqlString = [NSString stringWithFormat:@"select * from music where albumId = '%ld'",ads];
    //创建伴随指针:
    sqlite3_stmt *stmt = NULL;
    //预执行语句:
    int result = sqlite3_prepare(DBPoint, sqlString.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        //        NSLog(@"查询成功");
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            sqlite3_finalize(stmt);
            //            NSLog(@"已在表中");
            return YES;
        }
        sqlite3_finalize(stmt);
        //        NSLog(@"没有在表中");
        return NO;
    }else
    {
        sqlite3_finalize(stmt);
        //        NSLog(@"查询表格失败啊!");
    }
    return isCollected;
}
- (NSMutableArray *)selectAll{
    NSString *sqlStr = @"select * from music";
    NSMutableArray *courseArr = [NSMutableArray array];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(DBPoint, [sqlStr UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        NSLog(@"查询收藏所有表格成功!");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSInteger albumId = sqlite3_column_int64(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *intro = sqlite3_column_text(stmt, 2);
            const unsigned char *coverMiddle = sqlite3_column_text(stmt, 3);
            
            
            NSString *model_title = [NSString stringWithUTF8String:(const char *)title];
            NSString *model_intro = [NSString stringWithUTF8String:(const char *)intro];
            NSString *model_coverMiddle = [NSString stringWithUTF8String:(const char *)coverMiddle];
            
            KHJDetailRecommend *model = [[KHJDetailRecommend alloc] init];
            model.albumId = albumId;
            model.title = model_title;
            model.intro = model_intro;
            model.coverMiddle = model_coverMiddle;
            [courseArr addObject:model];
            
        }
    }else{
        sqlite3_finalize(stmt);
        NSLog(@"查询教程失败");
    }
    sqlite3_finalize(stmt);
    return courseArr;
}
//删除数据
- (void)deleteDataWithModel:(NSInteger)intStr{
    NSString *sqlString = [NSString stringWithFormat:@"delete from music where albumId = '%ld'",intStr];
    //执行sql语句:
    int result = sqlite3_exec(DBPoint, sqlString.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
}
#pragma mark -- 删除全部数据
- (void)removeAllData{
    //打开数据库
//    [self openDB];
    NSString *sqlString = [NSString stringWithFormat:@"delete from music"];
    //执行sql语句:
    int result = sqlite3_exec(DBPoint, sqlString.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
}


@end
