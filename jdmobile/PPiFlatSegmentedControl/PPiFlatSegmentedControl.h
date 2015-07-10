//
//  PPiFlatSegmentedControl.h
//  PPiFlatSegmentedControl
//
//  Created by Pedro Piñera Buendía on 12/08/13.
//  Copyright (c) 2013 PPinera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIButton+PPiAwesome.h"

typedef void(^selectionBlock)(NSUInteger segmentIndex);

@interface PPiFlatSegmentedControl : UIView

/**
 *	PROPERTIES
 * textFont: Font of text inside segments
 * textColor: Color of text inside segments
 * selectedTextColor: Color of text inside segments ( selected state )
 * color: Background color of full segmentControl
 * selectedColor: Background color for segment in selected state
 * borderWidth: Width of the border line around segments and control
 * borderColor: Color "" ""
 */

@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic,strong) NSDictionary *textAttributes;
@property (nonatomic,strong) NSDictionary *selectedTextAttributes;
@property (nonatomic) IconPosition iconPosition;

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items iconPosition:(IconPosition)position andSelectionBlock:(selectionBlock)block;
-(void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment;
-(BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index;
-(void)setTitle:(id)title forSegmentAtIndex:(NSUInteger)index;
-(void)setSelectedTextAttributes:(NSDictionary*)attributes;


@end
