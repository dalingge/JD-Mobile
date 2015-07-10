//
//  CartTableViewCell.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/25.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cartRedio;

@property (weak, nonatomic) IBOutlet UIImageView *cartImg;
@property (weak, nonatomic) IBOutlet UILabel *cartTitle;
@property (weak, nonatomic) IBOutlet UILabel *cartPrice;

@property (weak, nonatomic) IBOutlet UIButton *cartAdd;
@property (weak, nonatomic) IBOutlet UITextField *cartNumber;
@property (weak, nonatomic) IBOutlet UIButton *cartSub;

@property (weak, nonatomic) IBOutlet UIButton *cartActivity;

/**
 *  文本框内容改变后的回调
 */
@property (nonatomic, copy) void (^callBack) (int currentNum);

@end
