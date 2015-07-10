//
//  CommoditySectionCell.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommoditySectionCell.h"

@implementation CommoditySectionCell

- (void)layoutSubviews
{
    _serviceBtn.layer.borderWidth=0.5;
    _serviceBtn.layer.cornerRadius=5;
    _serviceBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _shopBtn.layer.borderWidth=0.5;
    _shopBtn.layer.cornerRadius=5;
    _shopBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
}
@end
