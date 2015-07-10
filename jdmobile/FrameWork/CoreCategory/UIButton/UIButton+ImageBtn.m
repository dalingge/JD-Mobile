//
//  UIButton+ImageBtn.m
//  4s
//
//  Created by muxi on 15/3/11.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "UIButton+ImageBtn.h"
#import "UIImage+TintColor.h"

@implementation UIButton (ImageBtn)


/**
 *  快速生成一个含有图片的按钮：默认按钮在大小和图片一样大
 *
 *  @param imageName        图片名
 *  @param highlightedColor 按钮高亮的时候的颜色
 *
 *  @return 按钮
 */
+(UIButton *)buttonWithImageName:(NSString *)imageName highlightedColor:(UIColor *)highlightedColor{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *imageForNarmal=[UIImage imageNamed:imageName];
    UIImage *imageForhighlighted=[imageForNarmal tintColor:highlightedColor level:1.0f];
    
    //设置不同状态下的图片
    [btn setImage:imageForNarmal forState:UIControlStateNormal];
    [btn setImage:imageForhighlighted forState:UIControlStateHighlighted];
    
    btn.frame=(CGRect){CGPointZero,imageForNarmal.size};
    
    return btn;
}





@end
