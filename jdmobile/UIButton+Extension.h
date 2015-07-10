//
//  UIButton+Extension.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/16.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)



+ (UIButton*) createButtonWithImage:(NSString *)image Title:(NSString *)title Target:(id)target Selector:(SEL)selector;



+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed;


+ (UIButton *) createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector;

+ (UIButton *) createButtonWithTitle:(NSString *)title Image:(NSString *)image Target:(id)target Selector:(SEL)selector;


@end
