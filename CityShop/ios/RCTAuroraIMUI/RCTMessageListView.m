//
//  RCTMessageListView.m
//  imuiDemo
//
//  Created by oshumini on 2017/5/26.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RCTMessageListView.h"
#import <CoreGraphics/CoreGraphics.h>
#import "RCTInputView.h"
#import "ryp_rn_supplier-Swift.h"
#import "RCTAuroraIMUIModule.h"
#import "ZeroMacros.h"
#import "DKSKeyboardView.h"

@interface RCTMessageListView()<DKSKeyboardDelegate>

@end

@implementation RCTMessageListView

- (instancetype)init{
  self = [super init];
  if (self) {

    
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
  }
  return self;
}



//发送的文案
- (void)textViewContentText:(NSString *)textStr {
    
  DEBUG_NSLog(@"发送的文案");
  if (self.delegate && [self.delegate respondsToSelector:@selector(onSendText:)]) {
    [self.delegate onSendText:textStr];
  }
}

- (void)textViewContentPhotosItem{
  DEBUG_NSLog(@"相册");
  if (self.delegate && [self.delegate respondsToSelector:@selector(onOpenPhotosItem)]) {
    [self.delegate onOpenPhotosItem];
  }
  
}

- (void)textViewContentCameraItem{
  DEBUG_NSLog(@"相机");
  if (self.delegate && [self.delegate respondsToSelector:@selector(onOpenCameraItem)]) {
    [self.delegate onOpenCameraItem];
  }
}

- (RCTMessageModel *)convertMessageDicToModel:(NSDictionary *)message {
  
  NSDictionary* fromUser = [message objectForKey:@"fromUser"];
  NSString* path =[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"/"];
  NSString*avatarPath = [NSString stringWithFormat:@"%@%@%@%@",path,@"/",[fromUser objectForKey:@"avatarPath"],@".png"];
   [fromUser  setValue:avatarPath forKeyPath:@"avatarPath"];
   DEBUG_NSLog(@"avatarPath====>%@",avatarPath);
   DEBUG_NSLog(@"path====>%@",path);

  NSString*msgType = [message objectForKey:@"msgType"];
  if ((msgType&&[msgType isEqualToString:@"custom_text"]) ||(msgType&&[msgType isEqualToString:@"custom"]) ) {
    [message  setValue:@"text" forKeyPath:@"msgType"];
  }
   DEBUG_NSLog(@"message====>%@",message);
  return [[RCTMessageModel alloc] initWithMessageDic: message];
}



- (void)setFrame:(CGRect)frame {
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appendMessages:)
                                                 name:kAppendMessages object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeMessage:)
                                                 name:kRemoveMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeAllMessages:)
                                                 name:kRemoveAllMessages object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(insertMessagesToTop:)
                                                 name:kInsertMessagesToTop object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMessage:)
                                                 name:kUpdateMessge object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollToBottom:)
                                                 name:kScrollToBottom object:nil];

    [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_messageList.messageCollectionView addSubview:self.refreshControl];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      _messageList.messageCollectionView.alwaysBounceVertical = YES;
      
      UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
      
      UITapGestureRecognizer *gestures = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTaps:)];
      
      _messageList.messageCollectionView.backgroundView = [UIView new];
       _messageList.messageCollectionView.userInteractionEnabled = YES;
      _messageList.messageCollectionView.backgroundView.userInteractionEnabled = YES;
      [_messageList.messageCollectionView.backgroundView addGestureRecognizer:gesture];
        [_messageList.messageCollectionView addGestureRecognizer:gestures];
      
    });
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kMessageListDidLoad object: nil];
  
  DKSKeyboardView *keyView = [[DKSKeyboardView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-52-StatusNav_Height, SCREEN_WIDTH, 52)];
  keyView.delegate = self;
  [self addSubview:keyView];
  return self;
}



//键盘出现
- (void)keyboardWillShowChange:(CGFloat)minY {
  
  [UIView animateWithDuration:0.25 animations:^{
    self.messageList.messageCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-52-minY);
    [self.messageList.messageCollectionView reloadData];
    [self.messageList scrollToBottomWith: YES];
  }];
  
}

//键盘关闭
- (void)keyboardWillHideChange:(CGFloat)minY {
  [UIView animateWithDuration:0.25 animations:^{
    self.messageList.messageCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    [self.messageList.messageCollectionView reloadData];
    [self.messageList scrollToBottomWith: YES];
  }];
}

//键盘出现和关闭y坐标
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {
  
}



- (void)handTaps:(UITapGestureRecognizer*)gesture {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardHide" object:nil];
}

- (void)handTap:(UITapGestureRecognizer*)gesture {
  if(!_onTouchMsgList) { return; }
  _onTouchMsgList(@{});
  [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardHide" object:nil];
}

- (void)setIsAllowPullToRefresh:(BOOL)isAllow {
  if (isAllow) {
    [_messageList.messageCollectionView addSubview: self.refreshControl];
  } else {
    [self.refreshControl removeFromSuperview];
  }
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
  NSLog(@"start refresh");
  [self performSelector:@selector(endRefresh:) withObject:refreshControl afterDelay:0.5f];
}

- (void)endRefresh:(UIRefreshControl *)refreshControl
{
  [refreshControl endRefreshing];
  if (_delegate != nil) {
    [_delegate onPullToRefreshMessageList];
  }
  NSLog(@"end refresh");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if (object == self && [keyPath isEqualToString:@"bounds"]) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self.messageList.messageCollectionView reloadData];
      [self.messageList scrollToBottomWith: NO];
    });
  }
}

- (void)appendMessages:(NSNotification *) notification {
  NSArray *messages = [[notification object] copy];
  
  for (NSDictionary *message in messages) {
    if([message[@"msgType"] isEqual: @"event"]) {
      MessageEventModel *event = [[MessageEventModel alloc] initWithMessageDic:message];
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageList appendMessageWith: event];
      });
    } else {
      RCTMessageModel * messageModel = [self convertMessageDicToModel:message];
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageList appendMessageWith: messageModel];
      });
    }
  }
}

- (void)removeMessage:(NSNotification *) notification {
  NSString *messageId = [[notification object] copy];
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.messageList removeMessageWith: messageId];
  });
}

- (void)removeAllMessages:(NSNotification *) notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.messageList removeAllMessages];
  });
}

- (void)insertMessagesToTop:(NSNotification *) notification {
  NSArray *messages = [[notification object] copy];
  
  NSMutableArray *messageModels = @[].mutableCopy;
  for (NSDictionary *message in messages) {
    if([message[@"msgType"] isEqual: @"event"]) {
      MessageEventModel *event = [[MessageEventModel alloc] initWithMessageDic:message];
      [messageModels addObject: event];
    } else {
      RCTMessageModel * messageModel = [self convertMessageDicToModel:message];
      [messageModels addObject: messageModel];
    }
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.messageList insertMessagesWith:messageModels];
  });
}


- (void)updateMessage:(NSNotification *) notification {
  NSDictionary *message = [notification object];
  DEBUG_NSLog(@"updateMessage=====%@",message);
  
  
  if([message[@"msgType"] isEqual: @"event"]) {
    MessageEventModel *event = [[MessageEventModel alloc] initWithMessageDic:message];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.messageList updateMessageWith: event];
    });
  } else {
    RCTMessageModel * messageModel = [self convertMessageDicToModel:message];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.messageList updateMessageWith: messageModel];
    });
  }
}

- (void)scrollToBottom:(NSNotification *) notification {
  BOOL animate = [[notification object] copy];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.messageList scrollToBottomWith:animate];
  });
}

- (void)awakeFromNib {
  [super awakeFromNib];

}


- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver: self];
  [self removeObserver:self forKeyPath:@"bounds"];
  
}


@end
