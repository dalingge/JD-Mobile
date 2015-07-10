//
//  CategoryMeunModel.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/14.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CategoryMeunModel.h"

@implementation CategoryMeunModel

#pragma mark 根据字典初始化对象
-(CategoryMeunModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.Id=[dic[@"Id"] intValue];
        self.menuName=dic[@"menuName"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(CategoryMeunModel *)statusWithDictionary:(NSDictionary *)dic{
    CategoryMeunModel *categoryMeun=[[CategoryMeunModel alloc]initWithDictionary:dic];
    return categoryMeun;
}
@end
