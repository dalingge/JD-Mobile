//
//  CommodityInfoCell.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityInfoCell.h"

@implementation CommodityInfoCell


#pragma mark - 懒加载
// 注意，使用懒加载时，调用属性最好用self.,因为第一次调用一定要用self.
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _nameLabel;
}

- (TYAttributedLabel*)activityLabel
{
    if (!_activityLabel) {
        _activityLabel = [[TYAttributedLabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_activityLabel];
        _activityLabel.textColor = [UIColor redColor];
        _activityLabel.numberOfLines = 2;
        _activityLabel.font = [UIFont systemFontOfSize:16];
    }
    return _activityLabel;
}


- (UILabel *)priceyLabel
{
    if (!_priceyLabel) {
        _priceyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_priceyLabel];
        _priceyLabel.textColor = [UIColor redColor];
        _priceyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
    }
    return _priceyLabel;
}

- (UIImageView*)imgZXImageview
{
    if (!_imgZXImageview) {
        _imgZXImageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imgZXImageview];
        
    }
    return _imgZXImageview;
}

- (UILabel *)txtZXLabel
{
    if (!_txtZXLabel) {
        _txtZXLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_txtZXLabel];
        _txtZXLabel.textColor = [UIColor redColor];
        _txtZXLabel.font =[UIFont systemFontOfSize:16];
        
    }
    return _txtZXLabel;
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nameX=10,nameY=10;
    self.nameLabel.frame=CGRectMake(nameX, nameY, self.contentView.frame.size.width-20, 60);
    self.activityLabel.frame=CGRectMake(nameX, 70, self.contentView.frame.size.width-20, 45);
    self.priceyLabel.frame=CGRectMake(nameX, 120, self.contentView.frame.size.width-20, 30);
    self.imgZXImageview.frame=CGRectMake(nameX, 150, 80, 20);
    self.txtZXLabel.frame=CGRectMake(100, 150, 140, 20);
}

#pragma mark - 显示数据
- (void)showInfo:(DetailsMode *)model
{
    
    self.nameLabel.text = model.detailsName;
    TYLinkTextStorage *linkTextStorage = [[TYLinkTextStorage alloc]init];
    linkTextStorage.range = [model.detailsActivity rangeOfString:@"详情尽在iPhone天天618"];
    self.activityLabel.text=model.detailsActivity;
    self.priceyLabel.text=model.detailsPrice;
    self.imgZXImageview.image=[UIImage imageNamed:model.detailsImgZX];
    self.txtZXLabel.text=model.detailsTxtZX;
    [self layoutSubviews];
}

@end
