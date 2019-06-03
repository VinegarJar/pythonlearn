//
//  IMUIEmotionButton.m
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2019/1/16.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "IMUIEmotionButton.h"

@implementation IMUIEmotionButton
- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}


- (void)setup{
  self.titleLabel.font  = [UIFont systemFontOfSize:32.0];
  self.adjustsImageWhenHighlighted = NO;
}

-(void)setEmotion:(IMUIEmotion *)emotion{
    _emotion               = emotion;
    [self setTitle:self.emotion.title forState:UIControlStateNormal];
}

@end
