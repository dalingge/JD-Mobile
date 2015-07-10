//
//  DBYScrollView.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/17.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DBYScrollViewDataSource;
@protocol DBYScrollViewDelegate;
@interface DBYScrollView : UIView
@property (assign,nonatomic) NSInteger currentPage;
@property (assign,nonatomic) BOOL scrollEnabled;//default is YES
@property (assign,nonatomic) BOOL cycleEnabled;//是否可循环滚动，default is YES
@property (weak,nonatomic) id<DBYScrollViewDataSource> dataSource;
@property (weak,nonatomic) id<DBYScrollViewDelegate> delegate;

-(id)dequeueReusableView;//重用池中取出一个控件
-(void)reloadData;
@end

@protocol DBYScrollViewDataSource<NSObject>
/*!
 *	@brief	获取数据源，要注意的是，使用dequeueReusableView进行获取，如果返回为nil，则再进行创建，类似tableView早前的数据获取方式。
 *
 *	@param 	pageIndex 	第几页
 *
 *	@return	要展示的控件
 */
-(UIView*)viewForDBYScrollView:(DBYScrollView*)adScrollView atPage:(NSInteger)pageIndex;
-(NSUInteger)numberOfViewsForDBYScrollView:(DBYScrollView*)adScrollView;
@end

@protocol DBYScrollViewDelegate<NSObject>
-(void)adScrollView:(DBYScrollView*)adScrollView didClickedAtPage:(NSInteger)pageIndex;
-(void)adScrollView:(DBYScrollView*)adScrollView didScrollToPage:(NSInteger)pageIndex;
@end
