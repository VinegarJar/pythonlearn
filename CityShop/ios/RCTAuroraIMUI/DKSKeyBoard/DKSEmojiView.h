//
//  DKSEmojiView.h
//  DKSChatKeyboard
//
//  Created by aDu on 2018/1/4.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKSEmojiView : UIView
- (void)photos:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)camera:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
