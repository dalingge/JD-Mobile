//
//  UIImage+Blur.h
//  网络
//
//  Created by 沐汐 on 14-10-6.
//  Copyright (c) 2014年 沐汐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)


/**
 *  产生一个模糊的图片:
 *
 *  fuzzy:                                  0~68.5f（范围）
 *
 *  density:                                0~5.0f （范围）
 */
-(UIImage *)blurWithFuzzy:(CGFloat)fuzzy density:(CGFloat)density;


@end
