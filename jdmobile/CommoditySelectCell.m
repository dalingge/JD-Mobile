//
//  CommoditySelectCell.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommoditySelectCell.h"

@implementation CommoditySelectCell

#pragma mark - 显示数据
- (void)showInfo:(DetailsMode *)model
{
    
    self.selectLatel.text = model.detailsSelect;
    [self layoutSubviews];
}

@end
