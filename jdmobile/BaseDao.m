//
//  BaseDao.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/24.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "BaseDao.h"

@implementation BaseDao

- (void)createTable:(NSString *)sql
{
    FMDatabase *db = [[Database sharedInstance] openDatabase];
    if (![db executeUpdate:sql]) {
        DLog(@"Create table failed");
    }
    [db close];
}
@end
