//
//  UIImage+Extension.h
//  
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage*) imageWithName:(NSString *) imageName;
+ (UIImage*) resizableImageWithName:(NSString *)imageName;
- (UIImage*) scaleImageWithSize:(CGSize)size;
@end
