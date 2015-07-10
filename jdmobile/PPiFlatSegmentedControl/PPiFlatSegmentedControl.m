//
//  PPiFlatSwitch.m
//  PPiFlatSwitch
//
//  Created by Pedro Piñera Buendía on 12/08/13.
//  Copyright (c) 2013 PPinera. All rights reserved.
//

#import "PPiFlatSegmentedControl.h"
#define segment_corner 3.0

@interface PPiFlatSegmentedControl()
@property (nonatomic,strong) NSMutableArray *segments;
@property (nonatomic) NSUInteger currentSelected;
@property (nonatomic,strong) NSMutableArray *separators;
@property (nonatomic,copy) selectionBlock selBlock;
@end


@implementation PPiFlatSegmentedControl
/**
 *	Method for initialize PPiFlatSegmentedControl
 *
 *	@param	frame	CGRect for segmented frame
 *	@param	items	List of NSString items for each segment
 *	@param	block	Block called when the user has selected another segment
 *
 *	@return	Instantiation of PPiFlatSegmentedControl
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray*)items iconPosition:(IconPosition)position andSelectionBlock:(selectionBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        //Selection block
        _selBlock=block;
        
        //Background Color
        self.backgroundColor=[UIColor clearColor];
        
        //Generating segments
        float buttonWith=frame.size.width/items.count;
        int i=0;
        for(NSDictionary *item in items){
            NSString *text=item[@"text"];
            NSString *icon=item[@"icon"];

            UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(buttonWith*i, 0, buttonWith, frame.size.height) text:text icon:icon textAttributes:nil andIconPosition:position];

            [button addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            //Adding to self view
            [self.segments addObject:button];
            [self addSubview:button];
            
            
            //Adding separator
            if(i!=0){
                UIView *separatorView=[[UIView alloc] initWithFrame:CGRectMake(i*buttonWith, 0, self.borderWidth, frame.size.height)];
                [self addSubview:separatorView];
                [self.separators addObject:separatorView];
            }
            
            i++;
        }
        
        //Applying corners
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=segment_corner;
        
        //Default selected 0
        _currentSelected=0;
    }
    return self;
}
#pragma mark - Lazy instantiations
-(NSMutableArray*)segments{
    if(!_segments)_segments=[[NSMutableArray alloc] init];
    return _segments;
}
-(NSMutableArray*)separators{
    if(!_separators)_separators=[[NSMutableArray alloc] init];
    return _separators;
}
#pragma mark - Actions
-(void)segmentSelected:(id)sender{
    if(sender){
        NSUInteger selectedIndex=[self.segments indexOfObject:sender];
        [self setEnabled:YES forSegmentAtIndex:selectedIndex];
        
        //Calling block
        if(self.selBlock){
            self.selBlock(selectedIndex);
        }
    }
}
#pragma mark - Getters
/**
 *	Returns if a specified segment is selected
 *
 *	@param	index	Index of segment to check
 *
 *	@return	BOOL selected
 */
-(BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index{
    return (index==self.currentSelected);
}

#pragma mark - Setters
-(void)updateSegmentsFormat{
    //Setting border color
    if(self.borderColor){
        self.layer.borderWidth=self.borderWidth;
        self.layer.borderColor=self.borderColor.CGColor;
    }else{
        self.layer.borderWidth=0;
    }
    
    //Updating segments color
    for(UIView *separator in self.separators){
        separator.backgroundColor=self.borderColor;
        separator.frame=CGRectMake(separator.frame.origin.x, separator.frame.origin.y,self.borderWidth , separator.frame.size.height);
    }
    
    //Modifying buttons with current State
    for (UIButton *segment in self.segments){
        //Setting icon Position
        if(self.iconPosition)
            [segment setIconPosition:self.iconPosition];
        
        //Setting format depending on if it's selected or not
        if([self.segments indexOfObject:segment]==self.currentSelected){
            //Selected-one
            if(self.selectedColor)[segment setBackgroundColor:self.selectedColor forUIControlState:UIControlStateNormal];
            if(self.selectedTextAttributes)
                [segment setTextAttributes:self.selectedTextAttributes forUIControlState:UIControlStateNormal];
        }else{
            //Non selected
            if(self.color)[segment setBackgroundColor:self.color forUIControlState:UIControlStateNormal];
            if(self.textAttributes)
                [segment setTextAttributes:self.textAttributes forUIControlState:UIControlStateNormal];
        }
        segment.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}
-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor=selectedColor;
    [self updateSegmentsFormat];
}
-(void)setColor:(UIColor *)color{
    _color=color;
    [self updateSegmentsFormat];
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth=borderWidth;
    [self updateSegmentsFormat];
}
-(void)setIconPosition:(IconPosition)iconPosition{
    _iconPosition=iconPosition;
    [self updateSegmentsFormat];
}
/**
 *	Using this method name of a specified segmend can be changed
 *
 *	@param	title	Title to be applied to the segment
 *	@param	index	Index of the segment that has to be modified
 */

-(void)setTitle:(id)title forSegmentAtIndex:(NSUInteger)index{
    //Getting the Segment
    if(index<self.segments.count){
        UIButton *segment=self.segments[index];
        if([title isKindOfClass:[NSString class]]){
            [segment setButtonText:title];
        }else if ([title isKindOfClass:[NSAttributedString class]]){
            [segment setButtonText:title];
        }
    }
}
-(void)setBorderColor:(UIColor *)borderColor{
    //Setting boerder color to all view
    _borderColor=borderColor;
    [self updateSegmentsFormat];
}
/**
 *	Method for select/unselect a segment
 *
 *	@param	enabled	BOOL if the given segment has to be enabled/disabled ( currently disable option is not enabled )
 *	@param	segment	Segment to be selected/unselected
 */
-(void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment{
    if(enabled){
        self.currentSelected=segment;
        [self updateSegmentsFormat];
    }
}
-(void)setTextAttributes:(NSDictionary *)textAttributes{
    _textAttributes=textAttributes;
    [self updateSegmentsFormat];
}
-(void)setSelectedTextAttributes:(NSDictionary *)selectedTextAttributes{
    _selectedTextAttributes=selectedTextAttributes;
    [self updateSegmentsFormat];
}
@end

