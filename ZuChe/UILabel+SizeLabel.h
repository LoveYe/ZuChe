//
//  UILabel+SizeLabel.h
//  Meiquer
//
//  Created by Bin WU on 14-12-22.
//  Copyright (c) 2014年 Bin WU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeLabel)

+ (CGFloat)width:(NSString *)contentString heightOfFatherView:(CGFloat)height textFont:(UIFont *)font;

+ (CGFloat)height:(NSString *)contentString widthOfFatherView:(CGFloat)width textFont:(UIFont *)font;

@end
