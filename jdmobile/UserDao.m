//
//  UserDao.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/24.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "UserDao.h"

@implementation UserDao

- (BOOL)insertUser:(UserModel *)entity{
    
   

    [self createTable:USER_TABLE_SQL];
    
    FMResultSet* rs =[[[Database sharedInstance] openDatabase]executeQuery:@"SELECT count(*) as countNum FROM user WHERE user_phone=?"
                                                      withArgumentsInArray:@[entity.userPhone]];
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];

        DLog(@"%i",(int)count);
        if (count > 0) {
            return NO;
        }
    }
    
    
    NSString *sql = @"INSERT INTO user (user_id,user_phone,user_pwd,time,user_name,commodity,shop,record) VALUES(?,?,?,?,?,?,?,?)";
    BOOL is_insert = [[[Database sharedInstance] openDatabase] executeUpdate:sql
                                                        withArgumentsInArray:@[entity.userId,
                                                                               entity.userPhone,
                                                                               entity.userPwd,
                                                                               entity.time,
                                                                               entity.userName,
                                                                               entity.commodity,
                                                                               entity.shop,
                                                                               entity.record
                                                                               ]
                      ];
    
    return  is_insert;
}

- (UserModel*)selectLogin:(NSString*)phone :(NSString*)pwd{
    
    FMResultSet* rs =[[[Database sharedInstance] openDatabase]executeQuery:@"SELECT * FROM user WHERE user_phone=? and user_pwd=?"
                                                      withArgumentsInArray:@[phone,pwd]];
    UserModel * um=[[UserModel alloc]init];
    if ([rs next]) {
        um.userId =[rs stringForColumn:@"user_id"];
        um.userName= [rs stringForColumn:@"user_name"];
        um.time=[rs stringForColumn:@"time"];
        um.commodity=[NSNumber numberWithInteger:[rs intForColumn:@"commodity"]];
        um.shop=[NSNumber numberWithInteger:[rs intForColumn:@"shop"]];
        um.record=[NSNumber numberWithInteger:[rs intForColumn:@"record"]];

    }else{
        um=nil;
    }
    return um;
}

- (UserModel*)selectAdd:(NSString*)userId{
    FMResultSet* rs =[[[Database sharedInstance] openDatabase]executeQuery:@"SELECT * FROM user WHERE user_id=?"
                                                      withArgumentsInArray:@[userId]];
    UserModel * um=[[UserModel alloc]init];
    if ([rs next]) {
        um.userName= [rs stringForColumn:@"user_name"];
        um.commodity=[NSNumber numberWithInteger:[rs intForColumn:@"commodity"]];
        um.shop=[NSNumber numberWithInteger:[rs intForColumn:@"shop"]];
        um.record=[NSNumber numberWithInteger:[rs intForColumn:@"record"]];
        
    }else{
        um=nil;
    }
    return um;
}
@end
