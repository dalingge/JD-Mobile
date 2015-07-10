//
//  SearchBarView.h
//  jdmobile
//
//  Created by 丁博洋 on 15/6/13.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchBarViewDelegate;

@interface SearchBarView : UIView


@property (nonatomic) NSString *placeholder;



@property (nonatomic, weak) id <SearchBarViewDelegate> delegate;

@end

@protocol SearchBarViewDelegate <NSObject>

@optional

- (void)searchBarAudioButtonClicked:(SearchBarView *)searchBarView;
- (void)searchBarSearchButtonClicked:(SearchBarView *)searchBarView;
@end

@interface RoundedView : UIView
@end