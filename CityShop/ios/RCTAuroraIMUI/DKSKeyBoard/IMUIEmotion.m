//
//  IMUIEmotion.m
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2019/1/16.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "IMUIEmotion.h"
#import <objc/runtime.h>
#import "ZeroMacros.h"



@interface IMUIEmotion ()

@end

@implementation IMUIEmotion

- (NSString *)description{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  uint count;
  objc_property_t *properties = class_copyPropertyList([self class], &count);
  for (int i = 0; i < count; i++){
    objc_property_t property = properties[i];
    NSString *name = @(property_getName(property));
    id value = [self valueForKey:name]?:@"nil";
    [dictionary setObject:value forKey:name];
  }
  free(properties);
  return [NSString stringWithFormat:@"<%@:%p> -- %@", [self class], self, dictionary];
}


+(NSArray<IMUIEmotion*>*)parseWithEmojiManager{
  NSMutableArray*arraySource = [[NSMutableArray alloc]init];
  NSString *path  = [ICBundle pathForResource:@"emoji.plist" ofType:nil];
  NSArray*valuesArray= [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"emoticons"];
  for (NSDictionary *dict in valuesArray) {
            IMUIEmotion*model = [[IMUIEmotion alloc]init];
            model.contents = [dict  objectForKey:@"contents"];
            model.id= [dict  objectForKey:@"id"];
            model.code_subunicode= [dict  objectForKey:@"code_subunicode"];
            model.code_unicode= [dict  objectForKey:@"code_unicode"];
            model.code_utf16= [dict  objectForKey:@"code_utf16"];
            model.code_utf8= [dict  objectForKey:@"code_utf8"];
            model.image= [dict  objectForKey:@"image"];
            model.title= [dict  objectForKey:@"title"];
            model.type= [dict  objectForKey:@"type"];
            [arraySource addObject:model];
  }
  return [arraySource copy];
}

@end
