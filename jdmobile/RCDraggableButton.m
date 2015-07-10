//
//  RCDraggableButton.m
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

#import "RCDraggableButton.h"
#define RC_WAITING_KEYWINDOW_AVAILABLE 0.f
#define RC_AUTODOCKING_ANIMATE_DURATION 0.2f
#define RC_DOUBLE_TAP_TIME_INTERVAL 0.36f

@implementation RCDraggableButton
@synthesize draggable = _draggable;
@synthesize autoDocking = _autoDocking;

@synthesize longPressBlock = _longPressBlock;
@synthesize tapBlock = _tapBlock;
@synthesize doubleTapBlock = _doubleTapBlock;

@synthesize draggingBlock = _draggingBlock;
@synthesize dragDoneBlock = _dragDoneBlock;

@synthesize autoDockingBlock = _autoDockingBlock;
@synthesize autoDockingDoneBlock = _autoDockingDoneBlock;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self defaultSetting];
    }
    return self;
}


- (id)initInKeyWindowWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(addButtonToKeyWindow) withObject:nil afterDelay:RC_WAITING_KEYWINDOW_AVAILABLE];
        [self defaultSetting];
    }
    return self;
}

- (id)initInView:(id)view WithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [view addSubview:self];
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
//    [self.layer setCornerRadius:self.frame.size.height / 2];
//    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [self.layer setBorderWidth:0.5];
//    [self.layer setMasksToBounds:YES];
    
    _draggable = YES;
    _autoDocking = YES;
    _singleTapBeenCanceled = NO;
   
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [_longPressGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
    [_longPressGestureRecognizer setAllowableMovement:0];
    [self addGestureRecognizer:_longPressGestureRecognizer];
}

- (void)addButtonToKeyWindow {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - Ges
- (void)gestureRecognizerHandle:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan: {
            if (_longPressBlock) {
                _longPressBlock(self);
            }
        }
            break;
            
        default:
            break;
    }

}

#pragma mark - Blocks
#pragma mark Touch Blocks
- (void)setTapBlock:(void (^)(RCDraggableButton *))tapBlock {
    _tapBlock = tapBlock;
    
    if (_tapBlock) {
        [self addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Touch
- (void)buttonTouched {
    [self performSelector:@selector(executeButtonTouchedBlock) withObject:nil afterDelay:(_doubleTapBlock ? RC_DOUBLE_TAP_TIME_INTERVAL : 0)];
}

- (void)executeButtonTouchedBlock {
    if (!_singleTapBeenCanceled && _tapBlock && !_isDragging) {
        _tapBlock(self);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _isDragging = NO;
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 2) {
        if (_doubleTapBlock) {
            _singleTapBeenCanceled = YES;
            _doubleTapBlock(self);
        }
    } else {
        _singleTapBeenCanceled = NO;
    }
    _beginLocation = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_draggable) {
        _isDragging = YES;
        
        UITouch *touch = [touches anyObject];
        CGPoint currentLocation = [touch locationInView:self];
        
        float offsetX = currentLocation.x - _beginLocation.x;
        float offsetY = currentLocation.y - _beginLocation.y;
        
        self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
        
        CGRect superviewFrame = self.superview.frame;
        CGRect frame = self.frame;
        CGFloat leftLimitX = frame.size.width / 2;
        CGFloat rightLimitX = superviewFrame.size.width - leftLimitX;
        CGFloat topLimitY = frame.size.height / 2;
        CGFloat bottomLimitY = superviewFrame.size.height - topLimitY;
        
        if (self.center.x > rightLimitX) {
            self.center = CGPointMake(rightLimitX, self.center.y);
        }else if (self.center.x <= leftLimitX) {
            self.center = CGPointMake(leftLimitX, self.center.y);
        }
        
        if (self.center.y > bottomLimitY) {
            self.center = CGPointMake(self.center.x, bottomLimitY);
        }else if (self.center.y <= topLimitY){
            self.center = CGPointMake(self.center.x, topLimitY);
        }
        
        if (_draggingBlock) {
            _draggingBlock(self);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
    
    if (_isDragging && _dragDoneBlock) {
        _dragDoneBlock(self);
        _singleTapBeenCanceled = YES;
    }
    
    if (_isDragging && _autoDocking) {
        CGRect superviewFrame = self.superview.frame;
        CGRect frame = self.frame;
        CGFloat middleX = superviewFrame.size.width / 2;

        if (self.center.x >= middleX) {
            [UIView animateWithDuration:RC_AUTODOCKING_ANIMATE_DURATION animations:^{
                self.center = CGPointMake(superviewFrame.size.width - frame.size.width / 2, self.center.y);
                if (_autoDockingBlock) {
                    _autoDockingBlock(self);
                }
            } completion:^(BOOL finished) {
                if (_autoDockingDoneBlock) {
                    _autoDockingDoneBlock(self);
                }
            }];
        } else {
            [UIView animateWithDuration:RC_AUTODOCKING_ANIMATE_DURATION animations:^{
                self.center = CGPointMake(frame.size.width / 2, self.center.y);
                if (_autoDockingBlock) {
                    _autoDockingBlock(self);
                }
            } completion:^(BOOL finished) {
                if (_autoDockingDoneBlock) {
                    _autoDockingDoneBlock(self);
                }
            }];
        }
    }
    
    _isDragging = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isDragging = NO;
    [super touchesCancelled:touches withEvent:event];
}

- (BOOL)isDragging {
    return _isDragging;
}

#pragma mark - version
+ (NSString *)version {
    return RC_DB_VERSION;
}

#pragma mark - remove
+ (void)removeAllFromKeyWindow {
    for (id view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([view isKindOfClass:[RCDraggableButton class]]) {
            [view removeFromSuperview];
        }
    }
}

+ (void)removeAllFromView:(id)superView {
    for (id view in [superView subviews]) {
        if ([view isKindOfClass:[RCDraggableButton class]]) {
            [view removeFromSuperview];
        }
    }
}
@end