//
//  DKTextField.m
//  DKTextField
//
//  Created by 张奥 on 14-10-31.
//  Copyright (c) 2014年 DKHS. All rights reserved.
//

#import "DKTextField.h"

#import "DKTextField.h"

@interface DKTextField ()
@property (nonatomic, copy) NSString *password;
@property (nonatomic, weak) id beginEditingObserver;
@property (nonatomic, weak) id endEditingObserver;
@end

@implementation DKTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.password = @"";
    
    __weak DKTextField *weakSelf = self;
    
    self.beginEditingObserver = [[NSNotificationCenter defaultCenter]
                                 addObserverForName:UITextFieldTextDidBeginEditingNotification
                                 object:nil
                                 queue:nil
                                 usingBlock:^(NSNotification *note) {
                                     if (weakSelf == note.object && weakSelf.isSecureTextEntry) {
                                         weakSelf.text = @"";
                                         [weakSelf insertText:weakSelf.password];
                                     }
                                 }];
    
    self.endEditingObserver = [[NSNotificationCenter defaultCenter]
                               addObserverForName:UITextFieldTextDidEndEditingNotification
                               object:nil
                               queue:nil
                               usingBlock:^(NSNotification *note) {
                                   if (weakSelf == note.object) {
                                       weakSelf.password = weakSelf.text;
                                   }
                               }];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    BOOL isFirstResponder = self.isFirstResponder;
    [self resignFirstResponder];
    [super setSecureTextEntry:secureTextEntry];
    if (isFirstResponder) {
        [self becomeFirstResponder];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.beginEditingObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.endEditingObserver];
}

@end
