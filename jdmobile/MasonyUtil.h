//
//  MasonyUtil.h
//  MasonyTest
//
//  Created by lovelydd on 15/6/8.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"
@interface MasonyUtil : NSObject


//居中显示
+ (void)centerView:(UIView *)view size:(CGSize)size;


//含有边距
+ (void)view:(UIView *)view EdgeInset:(UIEdgeInsets)edgeInsets;


//view的数目大于两个
+ (void)equalSpacingView:(NSArray *)views
               viewWidth:(CGFloat)width
              viewHeight:(CGFloat)height
          superViewWidth:(CGFloat)superViewWidth;
@end
