//
//  CartTableViewCell.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/25.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell


- (void)layoutSubviews{
    _cartActivity.layer.borderWidth=0.5f;
    _cartActivity.layer.borderColor=[UIColor grayColor].CGColor;
    _cartActivity.layer.cornerRadius=5;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)subClick:(UIButton *)sender {
        int newNum = [_cartNumber.text intValue] -1;
        if (newNum > 0) {
            _cartNumber.text = [NSString stringWithFormat:@"%i", newNum];
           self.callBack([_cartNumber.text intValue]);
        } else {
            NSLog(@"num can not less than 1");
        }
}
- (IBAction)addClick:(UIButton *)sender {
    
    int newNum = [_cartNumber.text intValue] + 1;
    _cartNumber.text = [NSString stringWithFormat:@"%i", newNum];
    
     self.callBack([_cartNumber.text intValue]);

}




@end
