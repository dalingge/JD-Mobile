//
//  MasonyUtil.m
//  MasonyTest
//
//  Created by lovelydd on 15/6/8.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "MasonyUtil.h"

@implementation MasonyUtil

+ (void)centerView:(UIView *)view size:(CGSize)size {
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view.superview);
        make.size.mas_equalTo(size);
    }];
}

+ (void)view:(UIView *)view EdgeInset:(UIEdgeInsets)edgeInsets {
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(view.superview).with.insets(edgeInsets);
    }];
}

+ (void)equalSpacingView:(NSArray *)views
               viewWidth:(CGFloat)width
              viewHeight:(CGFloat)height
          superViewWidth:(CGFloat)superViewWidth{
    
    //每个视图之间的距离
    CGFloat padding = (superViewWidth -  width * views.count) / (views.count - 1);
    
    for (int i = 0; i < views.count; i++) {
        
        UIView *firstView   = views[0];
        UIView *lastView    = views[views.count-1];
        UIView *currentView = views[i];
        
        

        if (i == 0) {
          
            UIView *nextView = views[i + 1];
            [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(currentView.superview.mas_centerY);
                make.left.equalTo(currentView.superview.mas_left);
                make.right.equalTo(nextView.mas_left).with.offset(-padding);
                make.height.mas_equalTo(height);
                make.width.equalTo(nextView);
            }];
            
        } else if (i == views.count-1){
            
            UIView *previousView = views[i - 1];
            [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(lastView.superview.mas_centerY);
                make.left.equalTo(previousView.mas_right).with.offset(padding);
                make.right.equalTo(lastView.superview.mas_right);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView);
            }];
            
        }
        
        else {
            

            UIView *previousView = views[i - 1];
            UIView *nextView = views[i+1];
            [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(currentView.superview.mas_centerY);
                make.left.equalTo(previousView.mas_right).with.offset(padding);
                make.right.equalTo(nextView.mas_left).with.offset(-padding);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView);
            }];
            
            if (i + 1 == views.count) {
                
                [nextView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(nextView.superview.mas_centerY);
                    make.left.equalTo(currentView.mas_right).with.offset(padding);
                    make.right.equalTo(nextView.superview.mas_right);
                    make.height.mas_equalTo(width);
                    make.width.equalTo(previousView);
                }];
                
                return;
            }

            
        }
    }
    
}
@end
