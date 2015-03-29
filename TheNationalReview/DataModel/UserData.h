//
//  UserData.h
//  TheNationalReview
//
//  Created by qianfeng on 15/3/28.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@protocol  UserDataDelegate<NSObject>


@end
@interface UserData : NSObject

// 第一次注册时 调用 创建本地数据库
- (id)initWithDatabasePath:(NSString *)path;
// 第一次注册时调用创建表 参数表名  主键名 类型  其他键
- (void)createDatabaseWithTableName:(NSString *)tableName withPrimaryKey:(NSString *)primaryKeyName andPrimaryKeyType:(NSString *)PrimaryKeyType andOtherKey:(NSDictionary *)otherDict;
// 注册用户
- (void)insertRecordIntoTable:(NSString *)tabelName withDictionary:(NSDictionary *)dict;
//删除用户
- (void)deleteRecordInTable:(NSString *)tabelName withWhereDictionary:(NSDictionary *)whereDict;
// 更新数据
- (void)updateRecordInTable:(NSString *)tableName withUpdataDictionary:(NSDictionary *)updataDict andWhereDict:(NSDictionary *)whereDict;
//匹配本地用户
- (FMResultSet *)select:(NSArray *)columNames fromTable:(NSString *)tableName whereDict:(NSDictionary *)whereDict;
@end
