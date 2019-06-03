//
//  ICEmotionPageView.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/6.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICEmotionPageView.h"
#import "UIView+Extension.h"
#import "IMUIEmotionButton.h"
#import "ZeroMacros.h"

@interface ICEmotionPageView ()

@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UIButton *sendeBtn;
@end

@implementation ICEmotionPageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];      
      self.deleteBtn       =  deleteBtn;
    }
    return self;
}


#pragma mark - Private
-(void)sendeBtnClicked:(UIButton *)deleteBtn{
  
}
- (void)deleteBtnClicked:(UIButton *)deleteBtn{
  
      [[NSNotificationCenter defaultCenter] postNotificationName:@"GXEmotionDidDeleteNotification" object:nil];// 通知出去
}

- (void)setEmotions:(NSArray *)emotions{
  
      NSLog(@"emotions=%@",emotions);
    _emotions                   = emotions;
    NSUInteger count            = emotions.count;
    for (int i = 0; i < count; i ++) {
      IMUIEmotionButton *button = [[IMUIEmotionButton alloc] init];
        [self addSubview:button];
        button.emotion          = emotions[i];
        [button addTarget:self action:@selector(emotionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat inset            = 15;
    NSUInteger count         = self.emotions.count;
    CGFloat btnW             = (self.width - 2*inset)/ICEmotionMaxCols;
    CGFloat btnH             = (self.height - 2*inset)/ICEmotionMaxRows;
    for (int i = 0; i < count; i ++) {
      IMUIEmotionButton *btn = self.subviews[i + 1];//因为已经加了一个deleteBtn了
        btn.width            = btnW;
        btn.height           = btnH;
        btn.x                = inset + (i % ICEmotionMaxCols)*btnW;
        btn.y                = inset + (i / ICEmotionMaxCols)*btnH;
    }
    self.deleteBtn.width     = btnW;
    self.deleteBtn.height    = btnH;
    self.deleteBtn.x         = inset + (count%ICEmotionMaxCols)*btnW;
    self.deleteBtn.y         = inset + (count/ICEmotionMaxCols)*btnH;
  

}


- (void)emotionBtnClicked:(IMUIEmotionButton *)button{
  
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
  userInfo[@"GXSelectEmotionKey"]  = button.titleLabel.text;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"GXEmotionDidSelectNotification" object:nil userInfo:userInfo];
}


@end
