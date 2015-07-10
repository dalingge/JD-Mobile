//
//  UserDefaultsUtils.m
//  ZLYDoc
//
//  Created by Ryan on 14-4-1.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "UserDefaultsUtils.h"
#import <SSKeychain.h>
NSString * const kService = @"JDShop";
NSString * const kAccount = @"account";
NSString * const kUserID = @"userID";

NSString * const kUserName = @"name";
NSString * const kCommodity = @"commodity";
NSString * const kShop = @"shop";
NSString * const kRecord = @"record";


@implementation UserDefaultsUtils


+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:kAccount];
    [userDefaults synchronize];
    
    [SSKeychain setPassword:password forService:kService account:account];
}

+ (void)saveOwnID:(NSString *)userID
         userName:(NSString *)userName
        commodity:(int)commodity
             shop:(int)shop
           record:(int)record
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userID forKey:kUserID];
    [userDefaults setObject:userName forKey:kUserName];
    [userDefaults setObject:@(commodity) forKey:kCommodity];
    [userDefaults setObject:@(shop) forKey:kShop];
    [userDefaults setObject:@(record)      forKey:kRecord];
    [userDefaults synchronize];
}
+ (int64_t)getOwnID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userID = [userDefaults objectForKey:kUserID];
    
    if (userID) {return [userID longLongValue];}
    return 0;
}


+ (NSArray *)getOwnAccountAndPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kAccount];
    NSString *password = [SSKeychain passwordForService:kService account:account];
    
    if (account) {return @[account, password];}
    return nil;
}

+ (void)clearCookie
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"sessionCookies"];
}


+(void)saveValue:(id) value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+(BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+(void)print{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    DLog(@"%@",dic);
}

@end
