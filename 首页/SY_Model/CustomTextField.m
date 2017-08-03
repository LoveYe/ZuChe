//
//  CustomTextField.m
//  ZuChe
//
//  Created by J.X.Y on 15/12/30.
//  Copyright © 2015年 佐途. All rights reserved.
//
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define Height(H) (H)/320.0*ScreenWidth
#import "CustomTextField.h"

@implementation CustomTextField

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(Height(10), Height(6), bounds.size.width-Height(30), bounds.size.height);//更好理解些
    return inset;
}
//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [[UIColor lightGrayColor] setFill];
    self.backgroundColor=[UIColor colorWithRed:81/255 green:81/255 blue:81/255 alpha:0.4f];
    self.tintColor = [UIColor blackColor];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:ScreenWidth*0.040625]];
}

@end
