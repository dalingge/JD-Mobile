//
//  UIImage+Cut.m
//  mohu
//
//  Created by 沐汐 on 14-10-6.
//  Copyright (c) 2014年 沐汐. All rights reserved.
//

#import "UIImage+Cut.h"

@implementation UIImage (Cut)




#pragma mark  直接截屏
+(UIImage *)cutScreen{
    return [self cutFromView:[UIApplication sharedApplication].keyWindow];
}


+(UIImage *)cutFromView:(UIView *)view{
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, 1, 0);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //在新建的图形上下文中渲染view的layer
    [view.layer renderInContext:context];
    
    [[UIColor clearColor] setFill];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;

}



-(UIImage *)cutWithFrame:(CGRect)frame{
    
    //创建CGImage
    CGImageRef cgimage = CGImageCreateWithImageInRect(self.CGImage, frame);
    
    //创建image
    UIImage *newImage=[UIImage imageWithCGImage:cgimage];
    
    //释放CGImage
    CGImageRelease(cgimage);
    
    return newImage;
    
    
}



@end
