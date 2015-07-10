//
//  UIButton+Extension.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/16.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

/**
 *  UIButton文字图片垂直显示
 *
 *  @param image    图片
 *  @param title    文字
 *  @param target   self
 *  @param selector 点击时间
 *
 *  @return 返回button
 */
+ (UIButton*) createButtonWithImage:(NSString *)image Title:(NSString *)title Target:(id)target Selector:(SEL)selector{
    UIButton * button = [UIButton new];
    UIImage *Image = [[UIImage imageWithName:image] scaleImageWithSize:CGSizeMake(35, 35)];
    [button setImage:Image forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:nil] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        button.titleLabel.font =[UIFont systemFontOfSize:14 ];

    }
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    //设置内容垂直或水平显示位置
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 20, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(40,-35, 0, 0);

    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

/**
 *  图片按钮
 *
 *  @param frame        尺寸
 *  @param target       self
 *  @param selector     点击事件
 *  @param image        前景颜色
 *  @param imagePressed 高亮颜色
 *
 *  @return 返回button
 */
+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    UIImage *newPressedImage = [UIImage imageNamed: imagePressed];
    [button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 *  文字按钮
 *
 *  @param frame    尺寸
 *  @param title    标题
 *  @param target   self
 *  @param selector 点击事件
 *
 *  @return 返回button
 */
+ (UIButton *) createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return button;
}


+ (UIButton *) createButtonWithTitle:(NSString *)title Image:(NSString *)image Target:(id)target Selector:(SEL)selector{
    UIButton * button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,16, 0, 0)];
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:nil] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
