//
//  UIColor+HexColor.h
//  DFCDrawingBoard
//
//  Created by DaFenQi on 16/9/1.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)hexStringToUIColorWithHex:(NSString *)hexStr;

@end
