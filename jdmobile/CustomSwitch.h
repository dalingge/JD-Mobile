//
//  CustomSwitch.h
//  CustomUISwitch
//
//  Created by Sukie Zhao on 13-6-8.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomSwitchStatus)
{
    CustomSwitchStatusOn = 0,//开启
    CustomSwitchStatusOff = 1//关闭
};

typedef NS_ENUM(NSUInteger, CustomSwitchArrange)
{
    CustomSwitchArrangeONLeftOFFRight = 0,//左边是开启,右边是关闭，默认
    CustomSwitchArrangeOFFLeftONRight = 1//左边是关闭，右边是开启
};

@protocol CustomSwitchDelegate <NSObject>

-(void)customSwitchSetStatus:(CustomSwitchStatus)status;
@end

@interface CustomSwitch : UIControl
{
    UIImage *_onImage;
    UIImage *_offImage;
    id<CustomSwitchDelegate> _delegate;
    CustomSwitchArrange _arrange;
    
}
@property(nonatomic,retain) UIImage *onImage;
@property(nonatomic,retain) UIImage *offImage;
@property(nonatomic,retain) IBOutlet id<CustomSwitchDelegate> delegate;
@property(nonatomic) CustomSwitchArrange arrange;
@property(nonatomic) CustomSwitchStatus status;
@end