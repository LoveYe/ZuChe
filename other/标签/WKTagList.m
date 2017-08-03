//
//  DWTagList.m
//
//  Created by Dominic Wroblewski on 07/07/2012.
//  Copyright (c) 2012 Terracoding LTD. All rights reserved.
//

#import "WKTagList.h"
#import <QuartzCore/QuartzCore.h>
#import "AllPages.pch"
#define CORNER_RADIUS ScreenWidth*0.0125
//行间距
#define LABEL_MARGIN ScreenWidth*0.021875
//列间距
#define BOTTOM_MARGIN ScreenWidth*0.010625
//文字大小
#define FONT_SIZE ScreenWidth*0.0375
//框宽
#define HORIZONTAL_PADDING ScreenWidth*0.015625
//框高
#define VERTICAL_PADDING ScreenWidth*0.009375
//框背景颜色
#define BACKGROUND_COLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:0.00]
//文字颜色
#define TEXT_COLOR [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.00]
//文字阴影
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
//文字偏移
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
//框.边颜色
#define BORDER_COLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:0.00].CGColor
//框.边宽
#define BORDER_WIDTH 0.000

@implementation WKTagList

@synthesize view, textArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
    }
    return self;
}

- (void)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;
    [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    lblBackgroundColor = color;
    [self display];
}

- (void)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    for (NSString *text in textArray) {
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:NSLineBreakByWordWrapping];
        textSize.width += HORIZONTAL_PADDING*2;
        textSize.height += VERTICAL_PADDING*2;
        UILabel *label = nil;
        if (!gotPreviousFrame) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            CGFloat manzu=previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN;
            NSNumber *num=[NSNumber numberWithFloat:manzu];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"manzu" object:num];
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            newRect.size = textSize;
            label = [[UILabel alloc] initWithFrame:newRect];
        }
        previousFrame = label.frame;
        gotPreviousFrame = YES;
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        if (!lblBackgroundColor) {
            [label setBackgroundColor:BACKGROUND_COLOR];
        } else {
            [label setBackgroundColor:lblBackgroundColor];
        }
        [label setTextColor:TEXT_COLOR];
        [label setText:text];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setShadowColor:TEXT_SHADOW_COLOR];
        [label setShadowOffset:TEXT_SHADOW_OFFSET];
        [label.layer setMasksToBounds:YES];
        [label.layer setCornerRadius:CORNER_RADIUS];
        [label.layer setBorderColor:BORDER_COLOR];
        [label.layer setBorderWidth: BORDER_WIDTH];
        [self addSubview:label];
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
}

- (CGSize)fittedSize
{
    return sizeFit;
}

@end
