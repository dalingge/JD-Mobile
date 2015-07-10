//
//  Image3ViewCell.h
//  jdmobile
//
//  Created by 丁博洋 on 15/7/1.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface Image3ViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *ImageView;
/// 根据数据模型来显示内容
- (void)showInfo:(Model *)model;

@end
