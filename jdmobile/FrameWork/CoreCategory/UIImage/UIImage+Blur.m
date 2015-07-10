//
//  UIImage+Blur.m
//  网络
//
//  Created by 沐汐 on 14-10-6.
//  Copyright (c) 2014年 沐汐. All rights reserved.
//

#import "UIImage+Blur.h"
#import "UIImage+Cut.h"
#import "UIImage+ImageEffects.h"

@implementation UIImage (Blur)

-(UIImage *)blurWithFuzzy:(CGFloat)fuzzy density:(CGFloat)density{
    
    //执行模糊
    UIImage *image=[self applyBlurWithRadius:fuzzy tintColor:nil saturationDeltaFactor:density maskImage:nil];
    
    //返回
    return image;
    
}


@end
