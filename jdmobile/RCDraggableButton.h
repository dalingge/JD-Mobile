//
//  RCDraggableButton.h
//  RCDraggableButton
//
//  Created by Looping (www.looping@gmail.com) on 14-2-8.
//  Copyright (c) 2014 RidgeCorn (https://github.com/RidgeCorn).
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#define RC_DB_VERSION @"0.2"

@interface RCDraggableButton : UIButton {
    BOOL _isDragging;
    BOOL _singleTapBeenCanceled;
    CGPoint _beginLocation;
    UILongPressGestureRecognizer *_longPressGestureRecognizer;
}
@property (nonatomic) BOOL draggable;
@property (nonatomic) BOOL autoDocking;

@property (nonatomic, copy) void(^longPressBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^tapBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^doubleTapBlock)(RCDraggableButton *button);

@property (nonatomic, copy) void(^draggingBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^dragDoneBlock)(RCDraggableButton *button);

@property (nonatomic, copy) void(^autoDockingBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^autoDockingDoneBlock)(RCDraggableButton *button);

- (id)initInKeyWindowWithFrame:(CGRect)frame;
- (id)initInView:(id)view WithFrame:(CGRect)frame;

- (BOOL)isDragging;

+ (NSString *)version;

+ (void)removeAllFromKeyWindow;
+ (void)removeAllFromView:(id)superView;

@end
