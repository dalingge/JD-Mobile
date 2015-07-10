//
//  Image3ViewCell.m
//  jdmobile
//
//  Created by 丁博洋 on 15/7/1.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "Image3ViewCell.h"

@implementation Image3ViewCell

#pragma mark - 懒加载
// 注意，使用懒加载时，调用属性最好用self.,因为第一次调用一定要用self.
- (UIImageView *)ImageView
{
    if (!_ImageView) {
        _ImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_ImageView];
    }
    return _ImageView;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.ImageView.frame = CGRectMake(0, 0, self.size.width, 500);
    
}

#pragma mark - 显示数据
- (void)showInfo:(Model *)model
{
    self.ImageView.image = [UIImage imageNamed:model.imageName3];
    
    [self layoutSubviews];
}

@end
