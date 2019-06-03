//
//  IMUIEmotion.h
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2019/1/16.
//  Copyright © 2019年 Facebook. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface IMUIEmotion : NSObject
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code_subunicode;
@property (nonatomic, copy) NSString *code_unicode;
@property (nonatomic, copy) NSString *code_utf16;
@property (nonatomic, copy) NSString *code_utf8;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;

+(NSArray<IMUIEmotion*>*)parseWithEmojiManager;
@end
