//
//  DKSEmojiView.m
//  DKSChatKeyboard
//
//  Created by aDu on 2018/1/4.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "DKSEmojiView.h"
#import "IMUIMoreViewItem.h"
@interface DKSEmojiView ()
@property (nonatomic, strong)  IMUIMoreViewItem*photos;
@property (nonatomic, strong)  IMUIMoreViewItem*camera;
@end



@implementation DKSEmojiView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
   
     _photos= [IMUIMoreViewItem createChatBoxMoreItemWithTitle:@"相册" imageName:@"input_item_photo"];
     [_photos setFrame:CGRectMake(20, 20, 80, 80)];
   
      _camera= [IMUIMoreViewItem createChatBoxMoreItemWithTitle:@"拍照" imageName:@"input_item_camera"];
      [_camera setFrame:CGRectMake(100, 20, 80, 80)];
      [self addSubview:_photos];
      [self addSubview:_camera];
    }
    return self;
}

-(void)photos:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [_photos addTarget:target action:action forControlEvents:controlEvents];
}

-(void)camera:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
   [_camera addTarget:target action:action forControlEvents:controlEvents];
}
  @end
  
