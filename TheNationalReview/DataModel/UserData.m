//
//  UserData.m
//  TheNationalReview
//
//  Created by qianfeng on 15/3/28.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "UserData.h"

@implementation UserData
{
    FMDatabase *_database;
    NSLock *_lock;
}

-(void)dealloc {
    [_database release];
    [_lock release];
    [super dealloc];
}
- (id)initWithDatabasePath:(NSString *)path {
    if (self = [super init]) {
        _database = [[FMDatabase alloc] initWithPath:path];
        BOOL ret = [_database open];
        if (!ret) {
            perror("OPEN DATABASE");
        }
        _lock = [[NSLock alloc] init];
    }
    
    return self;
}
- (void)createDatabaseWithTableName:(NSString *)tableName withPrimaryKey:(NSString *)primaryKeyName andPrimaryKeyType:(NSString *)PrimaryKeyType andOtherKey:(NSDictionary *)otherDict
{
    [_lock lock];
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ( %@ %@ PRIMARY KEY",tableName, primaryKeyName, PrimaryKeyType];
    for (NSString *key in otherDict) {
        [sql appendFormat:@",%@ %@",key, otherDict[key]];
        
    }
    [sql appendFormat:@");"];
    BOOL ret = [_database executeUpdate:sql];
    if (!ret) {
        perror("CREATE TABLE");
    }
    [sql release];
    [_lock unlock];
}
- (void)insertRecordIntoTable:(NSString *)tabelName withDictionary:(NSDictionary *)dict {
    [_lock lock];
    NSArray *keyArray = [dict allKeys];
    NSArray *valueArray = [dict allValues];
    NSString *keyStr = [keyArray componentsJoinedByString:@","];
    NSMutableString *valueString = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < [keyArray count]; i++) {
        if (i != [keyArray count] - 1) {
            [valueString appendString:@" ? ,"];
        } else {
            [valueString appendString:@" ? "];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tabelName, keyStr, valueString];
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:valueArray];
    if (!ret) {
        perror("INSERT INTO TABLE");
    }
    [_lock unlock];
}
/**拼接字典为字符串  删除, 修改数据时需要用到*/
- (NSString *)dictionaryToString:(NSDictionary *)whereDict {
    NSMutableArray *whereArray = [[NSMutableArray alloc] init];
    if (whereDict == nil) {
        return @"";
    } else {
        for (NSString *key in whereDict) {
            [whereArray addObject:[NSString stringWithFormat:@"%@ = ?",key]];
        }
        NSString *retString = [whereArray componentsJoinedByString:@" AND "];
        return retString;
    }
}
- (void)deleteRecordInTable:(NSString *)tabelName withWhereDictionary:(NSDictionary *)whereDict {
    [_lock lock];
    // 如果传回的表单名为空则返回
    if (tabelName == nil) {
        return;
    }
    NSMutableString *sql = nil;
    NSString *whereString = [self dictionaryToString:whereDict];
    sql = [NSMutableString stringWithFormat:@"DELETE FROM %@ WHERE %@ ;",tabelName, whereString];
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:whereDict.allValues];
    if (!ret) {
        perror("DELEATE TABLE");
    }
    [_lock unlock];
}
- (void)updateRecordInTable:(NSString *)tableName withUpdataDictionary:(NSDictionary *)updataDict andWhereDict:(NSDictionary *)whereDict{
    [_lock lock];
    NSString *sql = nil;
    // 将键值对转换为=号的键值对
    NSMutableArray *updataArray =[[NSMutableArray alloc] init];
    for (NSString *key in updataDict) {
        [updataArray addObject:[NSString stringWithFormat:@"%@ = ?",key]];
    }
    NSString *updataStr = [updataArray componentsJoinedByString:@","];
    NSString *whereStr = [self dictionaryToString:whereDict];
    NSMutableArray *valeArray = [[NSMutableArray alloc] initWithArray:updataDict.allValues];
    [valeArray addObjectsFromArray:whereDict.allValues];
    if ([updataStr length] == 0) {
        return;
    }
    sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ ;", tableName, updataStr, whereStr];
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:valeArray];
    if (!ret) {
        perror("UPDATE TABLE");
    }
    [_lock unlock];
}
- (FMResultSet *)select:(NSArray *)columNames fromTable:(NSString *)tableName whereDict:(NSDictionary *)whereDict {
    [_lock lock];
    NSMutableString *sql = nil;
    NSString *whereString = [self dictionaryToString:whereDict];
    NSString *columstring = nil;
    if (columNames == nil) {
        columstring = @"*";
        
    } else {
        columstring = [columNames componentsJoinedByString:@","];
    }
    if (whereString.length == 0) {
        sql = [NSMutableString stringWithFormat:@"SELECT %@ FROM %@", columstring, tableName];
        FMResultSet *set = [_database executeQuery:sql];
        [_lock unlock];
        return set;
    } else {
        sql = [NSMutableString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@",columstring, tableName, whereString];
    }
    FMResultSet *set = [_database executeQuery:sql withArgumentsInArray:whereDict.allValues];
    [_lock unlock];
    return set;
}

@end
