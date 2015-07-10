//
//  DetailsMode.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailsMode : NSObject

@property (nonatomic,assign) long long Id;//商品id
@property (nonatomic, strong) NSString *detailsName;//商品名称
@property (nonatomic, strong) NSString *detailsActivity;//商品活动
@property (nonatomic, strong) NSString *detailsPrice;//商品价钱
@property (nonatomic, strong) NSString *detailsImgZX;//专项图片
@property (nonatomic, strong) NSString *detailsTxtZX;//专项文字
@property (nonatomic, strong) NSString *detailsSelect;//选择
@property (nonatomic, strong) NSString *detailsAddress;//地址
@property (nonatomic, strong) NSString *detailsPraise;//评价
@property (nonatomic, strong) NSString *detailsPerson;//人数
@end
