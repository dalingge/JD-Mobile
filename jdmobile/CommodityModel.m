//
//  CommodityModel.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/22.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityModel.h"

@implementation CommodityModel


#pragma mark 根据字典初始化商品对象
-(CommodityModel *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        self.Id=[dic[@"Id"] longLongValue];
        self.commodityImageUrl=dic[@"commodityImageUrl"];
        self.commodityName=dic[@"commodityName"];
        self.commodityPrice=dic[@"commodityPrice"];
        self.commodityZX=dic[@"commodityZX"];
        self.commodityPraise=dic[@"commodityPraise"];
        self.commodityPerson=dic[@"commodityPerson"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(CommodityModel *)commodityWithDictionary:(NSDictionary *)dic{
    CommodityModel *commodity=[[CommodityModel alloc]initWithDictionary:dic];
    return commodity;
}

-(NSString *)praise{
    return [NSString stringWithFormat:@"好评%@ %@人",_commodityPraise,_commodityPerson];
}

@end
