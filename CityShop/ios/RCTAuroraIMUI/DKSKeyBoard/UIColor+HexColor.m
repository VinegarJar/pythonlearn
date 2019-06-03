//
//  UIColor+HexColor.m
//  DFCDrawingBoard
//
//  Created by DaFenQi on 16/9/1.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)hexStringToUIColorWithHex:(NSString *)hexStr {
    unsigned int red,green,blue;
    NSRange range = NSMakeRange(1, 2);
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
}

@end
