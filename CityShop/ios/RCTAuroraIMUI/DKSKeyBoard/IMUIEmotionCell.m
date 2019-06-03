//
//  IMUIEmotionCell.m
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2019/1/16.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "IMUIEmotionCell.h"
#import "UIView+Extension.h"
#import "ICEmotionPageView.h"
@interface  IMUIEmotionCell ()<UIScrollViewDelegate>
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIPageControl *pageControl;
@property (nonatomic, weak) UIButton     *sendBtn;
@property (nonatomic, weak) UIView *toolView;
@end

@implementation IMUIEmotionCell

- (id) initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
    [self scrollView];
    [self pageControl];
    [self toolView];
  }
  return self;
}


- (void)pageControlClicked:(UIPageControl *)pageControl
{
  
}

-(void)layoutSubviews{
  [super layoutSubviews];
  self.pageControl.width          = self.width;
  self.pageControl.height         = 10;
  self.pageControl.x              = 0;
  self.pageControl.y              = self.height - self.pageControl.height-5;
  self.scrollView.width           = self.width;
  self.scrollView.height          = self.pageControl.y;
  self.scrollView.x               =self.scrollView.y = 0;
// self.toolView.frame    = CGRectMake(0, self.height-40, self.width, 40);
  NSUInteger count                = self.scrollView.subviews.count;
  for (int i = 0; i < count; i ++) {
    ICEmotionPageView *pageView = self.scrollView.subviews[i];
    pageView.width              = self.scrollView.width;
    pageView.height             = self.scrollView.height;
    pageView.y                  = 0;
    pageView.x                  = i * pageView.width;
  }
  self.scrollView.contentSize     = CGSizeMake(count*self.scrollView.width, 0);
}

- (void)setEmotions:(NSArray *)emotions
{
  _emotions = emotions;
  
  [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  NSUInteger count = (emotions.count + ICEmotionPageSize - 1)/ ICEmotionPageSize;
  self.pageControl.numberOfPages  = count;
  for (int i = 0; i < count; i ++) {
    ICEmotionPageView *pageView = [[ICEmotionPageView alloc] init];
    NSRange range;
    range.location              = i * ICEmotionPageSize;
    NSUInteger left             = emotions.count - range.location;//剩余
    if (left >= ICEmotionPageSize) {
      range.length            = ICEmotionPageSize;
    } else {
      range.length            = left;
    }
    pageView.emotions           = [emotions subarrayWithRange:range];
    [self.scrollView addSubview:pageView];
  }
  [self setNeedsLayout];
  
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  double pageNum   = scrollView.contentOffset.x/scrollView.width;
  self.pageControl.currentPage  = (int)(pageNum+0.5);
}

#pragma mark - Getter and Setter

- (UIScrollView *)scrollView
{
  if (nil == _scrollView) {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _scrollView = scrollView;
  }
  return _scrollView;
}

- (UIPageControl *)pageControl{
  if (nil == _pageControl) {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    _pageControl = pageControl;
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.userInteractionEnabled = NO;
  }
  return _pageControl;
}

-(UIView*)toolView{
  if (!_toolView) {
    UIView*toolView = [[UIView alloc] init];
    [self addSubview:toolView];
    _toolView = toolView;
    _toolView.backgroundColor = [UIColor redColor];
  }
  return _toolView;
}


- (UIButton *)sendBtn
{
  if (!_sendBtn) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1.0]];
    [self addSubview:btn];
    _sendBtn = btn;
   // [btn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _sendBtn;
}
@end
