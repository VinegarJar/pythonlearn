//
//  RCTInputViewManager.m
//  imuiDemo
//
//  Created by oshumini on 2017/5/27.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>
#import "RCTInputView.h"
#import "ryp_rn_supplier-Swift.h"
#import <Photos/Photos.h>
#import "RCTAuroraIMUIFileManager.h"
#import "ZeroMacros.h"
#import "DKSKeyboardView.h"
@interface RCTInputViewManager : RCTViewManager

@end

@implementation RCTInputViewManager
RCT_EXPORT_VIEW_PROPERTY(onSizeChange, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFullScreen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRecoverScreen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSendText, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onTakePicture, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onStartRecordVoice, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onCancelRecordVoice, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFinishRecordVoice, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onStartRecordVideo, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFinishRecordVideo, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSendGalleryFiles, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSwitchToMicrophoneMode, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSwitchToGalleryMode, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSwitchToCameraMode, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSwitchToEmojiMode, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onShowKeyboard, RCTBubblingEventBlock)

RCT_EXPORT_MODULE()

- (UIView *)view{
  RCTInputView *inputView=[[RCTInputView alloc]init];
   return  inputView;
}


- (dispatch_queue_t)methodQueue{
  return dispatch_get_main_queue();
}

#pragma mark-RN调用的原生方法
RCT_CUSTOM_VIEW_PROPERTY(inputPadding, NSDictionary, RCTInputView) {
  
}

RCT_CUSTOM_VIEW_PROPERTY(inputTextColor, NSString, RCTInputView) {
  
}

RCT_CUSTOM_VIEW_PROPERTY(inputTextSize, NSNumber, RCTInputView) {
  
}

RCT_CUSTOM_VIEW_PROPERTY(galleryScale, NSNumber, RCTInputView) {
  
}

RCT_CUSTOM_VIEW_PROPERTY(compressionQuality, NSNumber, RCTInputView) {
  
}

RCT_CUSTOM_VIEW_PROPERTY(customLayoutItems, NSDictionary, RCTInputView) {
  
}


#pragma mark-原生调用RN的方法
/**
 * @param[messageText]: 发送的消息字符串
 * @sendTextMessage: 发送消息回调
 **/
- (void)sendTextMessage:(NSString * _Nonnull)messageText {


}

- (void)onSwitchInputToolsBar:(NSString * _Nonnull)toolsBarText{
  
}



- (void)switchToMicrophoneModeWithRecordVoiceBtn:(UIButton * _Nonnull)recordVoiceBtn {}
- (void)startRecordVoice {}
- (void)finishRecordVoice:(NSString * _Nonnull)voicePath durationTime:(double)durationTime {}
- (void)cancelRecordVoice {}
- (void)switchToGalleryModeWithPhotoBtn:(UIButton * _Nonnull)photoBtn {}
- (void)switchToEmojiModeWithCameraBtn:(UIButton * _Nonnull)cameraBtn {}
- (void)textDidChangeWithText:(NSString * _Nonnull)text {}
- (void)switchToCameraModeWithCameraBtn:(UIButton * _Nonnull)cameraBtn {}
- (void)didShootPictureWithPicture:(NSData * _Nonnull)picture {}
- (void)startRecordVideo {}
- (void)finishRecordVideoWithVideoPath:(NSString * _Nonnull)videoPath durationTime:(double)durationTime {}
- (void)keyBoardWillShowWithHeight:(CGFloat)height durationTime:(double)durationTime {}
- (void)cameraFullScreen {}
- (void)cameraRecoverScreen {}




@end
