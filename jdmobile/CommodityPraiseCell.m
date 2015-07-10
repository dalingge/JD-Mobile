//
//  CommodityPraiseCell.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityPraiseCell.h"

@implementation CommodityPraiseCell

#pragma mark - 显示数据
- (void)showInfo:(DetailsMode *)model
{
    
    self.praiseLabel.text = model.detailsPraise;
    self.personLabel.text = model.detailsPerson;
    [self layoutSubviews];
}

@end
