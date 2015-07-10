//
//  Database.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/24.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

/**
 *  Database operate delegate
 */
@protocol DatabaseDelegate <NSObject>

@optional
//- (BOOL)insert:(BaseEntity *)entity;
//- (BOOL)update:(BaseEntity *)entity;
//- (BOOL)remove:(BaseEntity *)entity;
//- (BOOL)removeClientEntityWithId:(NSString *)id;
//- (BaseEntity *)queryById:(NSString *) entityId;
- (NSMutableArray *)queryAll;
- (NSMutableArray *)queryAllOrderByName;
- (NSMutableArray *)queryAllOrderByTime;
- (void)closeDB;
- (BOOL)removeAll;

@required
- (void)createTable:(NSString *)sql;

@end


@interface Database : NSObject

@property(nonatomic,strong) FMDatabase *database;

//管理类单例
+ (Database *)sharedInstance;

//获取数据库连接对象
- (FMDatabase *)openDatabase;

//删除所有表的数据
- (void)removeAllData;

//关闭数据库
- (void)closeDB;

//删除数据库文件
- (BOOL)deleteDatabase;

//判断指定表是否存在
- (BOOL)isTableExists:(NSString *)tableName;

@end
