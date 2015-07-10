//
//  DBYScorllView.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/17.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYScrollView.h"
#import "CorePageControl.h"
#import "UIImage+Color.h"

/** pageControl的size */
#define PPTPagecontrolCurrentSize CGSizeMake(30,3)
#define PPTPagecontrolNormalSize CGSizeMake(28,2)
/** pageControl的普通颜色 */
#define PPTPagecontrolNormalColor rgba(174,174,174,1)
/** pageControl的选中 */
#define PPTPagecontrolCurrentColor rgba(225,69,69,1)
@interface DBYScrollView ()<UIScrollViewDelegate>{
    NSMutableSet *_reusableViewSet;
    NSMutableDictionary *_onShowViewDictionary;
    UIScrollView *_scrollView;
    NSInteger _totalPageNumber;
    NSInteger _positionIndex;
    CorePageControl*_pageControl;
}

@end
@implementation DBYScrollView

-(id)init{
    return [self initWithFrame:CGRectZero];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _reusableViewSet = [[NSMutableSet alloc]initWithCapacity:4];
        _onShowViewDictionary = [[NSMutableDictionary alloc]initWithCapacity:3];
        _cycleEnabled = true;
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
        [self addSubview:_scrollView];
        _pageControl=[[CorePageControl alloc] initWithFrame:CGRectMake(0, self.size.height-10, 375, 5)];
        //禁用交互
        _pageControl.userInteractionEnabled = NO;
        //普通图片
        _pageControl.pageIndicatorImage = [UIImage imageFromContextWithColor:PPTPagecontrolNormalColor size:PPTPagecontrolNormalSize];
        //当前图片
        _pageControl.currentPageIndicatorImage = [UIImage imageFromContextWithColor:PPTPagecontrolCurrentColor size:PPTPagecontrolCurrentSize];
        
        //居中
        _pageControl.alignment= SMPageControlAlignmentCenter;
        [self addSubview:_pageControl];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_scrollView addGestureRecognizer:gesture];
    }
    return self;
}

-(void)layoutSubviews{
    _scrollView.frame = self.bounds;
    _pageControl.numberOfPages=_totalPageNumber;
    [self reloadData];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)setScrollEnabled:(BOOL)scrollEnabled{
    _scrollView.scrollEnabled = scrollEnabled;
}

-(BOOL)scrollEnabled{
    return _scrollView.scrollEnabled;
}

-(void)handleTap:(UITapGestureRecognizer*)gesture{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(adScrollView:didClickedAtPage:)]) {
        [self.delegate adScrollView:self didClickedAtPage:_currentPage];
    }
}

-(id)dequeueReusableView{
    id obj = [_reusableViewSet anyObject];
    if (obj) {
        [_reusableViewSet removeObject:obj];
    }
    return obj;
}

-(void)reloadData{
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:@selector(numberOfViewsForDBYScrollView:)]) {
            _totalPageNumber = [self.dataSource numberOfViewsForDBYScrollView:self];
            
            
        }
    }
    [_onShowViewDictionary removeAllObjects];
    
    if (_cycleEnabled) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*2000*_totalPageNumber, 0);
        _positionIndex = 1000*_totalPageNumber+self.currentPage;
        [_scrollView setContentOffset:CGPointMake(_positionIndex*_scrollView.frame.size.width, 0) animated:false];
    }else{
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_totalPageNumber, 0);
        _positionIndex = self.currentPage;
        [_scrollView setContentOffset:CGPointMake(_positionIndex*_scrollView.frame.size.width, 0) animated:false];
    }
    
    if (_totalPageNumber>0) {
        [self setPageToPositionIndex:_positionIndex];
    }
}

-(void)setPageToPositionIndex:(NSInteger)positionIndex{
    [self prepareViewAtPositionIndex:positionIndex];
    [self prepareViewAtPositionIndex:positionIndex-1];
    [self prepareViewAtPositionIndex:positionIndex+1];
    
    
    NSArray *allKeyArray = _onShowViewDictionary.allKeys;
    for (NSInteger i=allKeyArray.count-1;i>=0;i--) {
        NSNumber *key = [allKeyArray objectAtIndex:i];
        NSInteger index = [key integerValue];
        UIView *view = [_onShowViewDictionary objectForKey:key];
        if (ABS(index-positionIndex)>1) {
            view.hidden = true;
            [_reusableViewSet addObject:view];
            [_onShowViewDictionary removeObjectForKey:key];
        }else{
            view.hidden = false;
        }
    }
}

-(NSInteger)pageFromPositionIndex:(NSInteger)positionIndex{
    if (_totalPageNumber==0) {
        return 0;
    }
    NSInteger showIndex = positionIndex;
    if (positionIndex>0) {
        showIndex = positionIndex%_totalPageNumber;
    }else if(positionIndex<0){
        showIndex = positionIndex%_totalPageNumber+_totalPageNumber;
    }
    
    
    return showIndex;
}

-(void)prepareViewAtPositionIndex:(NSInteger)positionIndex{
    if (!_cycleEnabled) {
        if (positionIndex<0||positionIndex>_totalPageNumber-1) {
            return;
        }
    }
    NSInteger showIndex = [self pageFromPositionIndex:positionIndex];
    UIView *view = [_onShowViewDictionary objectForKey:@(positionIndex)];
    if (!view&&self.dataSource&&[self.dataSource respondsToSelector:@selector(viewForDBYScrollView:atPage:)]) {
        view = [self.dataSource viewForDBYScrollView:self atPage:showIndex];
        [_scrollView addSubview:view];
        [_onShowViewDictionary setObject:view forKey:@(positionIndex)];
    }
    view.frame = CGRectMake(positionIndex*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    view.hidden = false;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_totalPageNumber==0) {
         _pageControl.currentPage=_currentPage;
        return;
    }
    CGFloat pageWidth = _scrollView.frame.size.width;
    NSInteger page = (_scrollView.contentOffset.x/pageWidth) + 0.5;
    if (page!=_positionIndex) {
        if (!_cycleEnabled) {
            if (page<0||page>_totalPageNumber-1) {
                return;
            }
        }
        _positionIndex = page;
        _currentPage = [self pageFromPositionIndex:_positionIndex];
        _pageControl.currentPage=_currentPage;
        NSLog(@"%i",(int)page);
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(adScrollView:didScrollToPage:)]) {
            [self.delegate adScrollView:self didScrollToPage:_currentPage];
        }
        
        [self setPageToPositionIndex:_positionIndex];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

@end
