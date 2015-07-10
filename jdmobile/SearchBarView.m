//
//  SearchBarView.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/13.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "SearchBarView.h"

#define kXMargin 8
#define kYMargin 4
#define kIconSize 20

#define kSearchBarHeight 30

@interface SearchBarView ()

@property (nonatomic) UIButton *audioButton;
@property (nonatomic) UIButton *searchButton;

@property (nonatomic) RoundedView *backgroundView;

@end

@implementation SearchBarView

#pragma mark - Initializers

- (void)setDefaults {
    
    NSUInteger boundsWidth = self.bounds.size.width;
    NSUInteger boundsHeight= self.bounds.size.height;
    //Background Rounded White Image
    self.backgroundView = [[RoundedView alloc] initWithFrame:CGRectMake(0, 0, boundsWidth, boundsHeight)];
    [self addSubview:self.backgroundView];
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height)];
    img.image = [UIImage imageNamed:@"HomePageSH_searchBack_bg"];
    
    [self.backgroundView addSubview:img];
    
    self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(kIconSize*2, 0, boundsWidth - kIconSize*4, boundsHeight)];
 
    [self.searchButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIFont *defaultFont = [UIFont fontWithName:@"Avenir Next" size:14];
    self.searchButton.titleLabel.font=defaultFont;
    [self.searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.searchButton setTitle:@"搜索京东商店/店铺" forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(pressedSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    
    //Cancel Button
    self.audioButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kIconSize, kIconSize)];
    [self.audioButton setImage:[UIImage imageWithName:@"audio_nav6_icon"] forState:UIControlStateNormal];
    [self.audioButton setImage:[UIImage imageWithName:@"audio_nav_icon"] forState:UIControlStateHighlighted];
    self.audioButton.contentMode = UIViewContentModeScaleAspectFit;
    self.audioButton.center = CGPointMake(boundsWidth - (kIconSize/2 + kXMargin), CGRectGetMidY(self.bounds));
    [self.audioButton addTarget:self action:@selector(pressedAudio:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.audioButton];
    
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    
    CGRect newFrame = frame;
    frame.size.height = kSearchBarHeight;
    frame = newFrame;
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(10, 20, 300, 32)];
}

- (void)pressedSearch: (id)sender {
    if ([self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
        [self.delegate searchBarSearchButtonClicked:self];
}


- (void)pressedAudio: (id)sender {
    
    if ([self.delegate respondsToSelector:@selector(searchBarAudioButtonClicked:)])
        [self.delegate searchBarAudioButtonClicked:self];
}
@end

@implementation RoundedView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

