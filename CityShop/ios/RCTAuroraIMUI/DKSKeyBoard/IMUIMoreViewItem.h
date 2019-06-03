//
//  IMUIMoreViewItem.h
//  ryp_rn_supplier
//
//  Created by ryp-app01 on 2019/1/17.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMUIMoreViewItem : UIView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;


- (void)addTarget:(id)target action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents;

/**
 *  创建一个IMUIMoreViewItem
 *  @param title     item的标题
 *  @param imageName item的图片
 *  @return item
 */
+ (IMUIMoreViewItem*)createChatBoxMoreItemWithTitle:(NSString *)title
                                                imageName:(NSString *)imageName;
@end
