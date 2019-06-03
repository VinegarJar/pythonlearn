//
//  ICEmotionPageView.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/6.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMUIEmotion.h"


#define ICEmotionMaxRows 3
#define ICEmotionMaxCols 8
#define ICEmotionPageSize ((ICEmotionMaxRows * ICEmotionMaxCols) - 1)

@interface ICEmotionPageView : UIView

@property (nonatomic, strong) NSArray *emotions;

@end
