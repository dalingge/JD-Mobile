//
//  UserDao.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/24.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "BaseDao.h"
#import "UserModel.h"
@interface UserDao : BaseDao


- (BOOL)insertUser:(UserModel *)entity;

- (UserModel*)selectLogin:(NSString*)phone :(NSString*)pwd;

- (UserModel*)selectAdd:(NSString*)userId ;
@end
