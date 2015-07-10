//
//  CartScrollModel.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/17.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CartScrollModel.h"

@implementation CartScrollModel


#pragma mark 带参数的构造函数
-(CartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image{
    if(self=[super init]){
        self.title=titleName;
        self.price=priceName;
        self.image=image;
    }
    return self;
}


#pragma mark 带参数的静态对象初始化方法
+(CartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image{
    CartScrollModel *cartScrollModel=[[CartScrollModel alloc]initWithFirstTitle:titleName andPriceName:priceName andImageNumber:image];
    return cartScrollModel;
}
@end
