//
//  CellConfig.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *   本类相当于将tableView中cell所需的基本信息存储下来，以便放到数组中管理
 *   改变不同类型cell的顺序、增删时，极为方便，只需改变VC中数据源数组即可，无需在多个tableView代理方法中逐个修改
 */
@interface CellConfig : NSObject

/// cell类名
@property (nonatomic, strong) NSString *className;

/// 标题 - 如“我的订单”，对不同种cell进行不同设置时，通过 其对应的 cellConfig.title 进行判断
@property (nonatomic, strong) NSString *title;

/// 显示数据模型的方法
@property (nonatomic, assign) SEL showInfoMethod;

/// cell高度
@property (nonatomic, assign) CGFloat heightOfCell;

/// 预留属性detail
@property (nonatomic, strong) NSString *detail;

/// 预留属性remark
@property (nonatomic, strong) NSString *remark;
//
@property (nonatomic, assign) BOOL cellType;

/**
 * @brief 便利构造器
 *
 * @param className:类名
 * @param title:标题，可用做cell直观的区分
 * @param showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:)
 * @param heightOfCell:此类cell的高度
 *
 *
 */

+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
                               cellType:(BOOL) cellType;

/// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel
                             cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
