//
//  UIImage+TintColor.m
//  新浪微博2014MJ版
//
//  Created by muxi on 14/11/11.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "UIImage+TintColor.h"
#import "UIImage+RTTint.h"

@implementation UIImage (TintColor)


/**
 *  图片着色
 */
-(UIImage *)tintColor:(UIColor *)color level:(CGFloat)level{
    
    UIImage *image=[self rt_tintedImageWithColor:color level:level];
    
    return image;
}




@end
