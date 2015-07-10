//
//  MultilevelMenu.h
//  MultilevelMenu
//
//  Created by gitBurning on 15/3/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLeftWidth 100

@interface MultilevelMenu : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic,readonly) NSArray * allData;


@property(copy,nonatomic,readonly) id block;


@property(assign,nonatomic) BOOL isRecordLastScroll;

@property(assign,nonatomic,readonly) NSInteger selectIndex;

/**
 *  为了 不修改原来的，因此增加了一个属性，选中指定 行数
 */
@property(assign,nonatomic) NSInteger needToScorllerIndex;
/**
 *  颜色属性配置
 */

/**
 *  左边背景颜色
 */
@property(strong,nonatomic) UIColor * leftBgColor;
/**
 *  左边点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftSelectColor;
/**
 *  左边点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftSelectBgColor;

/**
 *  左边未点中文字颜色
 */

@property(strong,nonatomic) UIColor * leftUnSelectColor;
/**
 *  左边未点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectBgColor;
/**
 *  tablew 的分割线
 */
@property(strong,nonatomic) UIColor * leftSeparatorColor;

-(id)initWithFrame:(CGRect)frame WithData:(NSArray*)data withSelectIndex:(void(^)(NSInteger left,NSInteger right,id info))selectIndex;

@end

