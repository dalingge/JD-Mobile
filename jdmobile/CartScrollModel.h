//
//  CartScrollModel.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/17.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartScrollModel : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * image;

#pragma mark 带参数的构造函数
-(CartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image;



#pragma mark 带参数的静态对象初始化方法
+(CartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image;
@end
