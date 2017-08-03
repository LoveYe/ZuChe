//
//  WYJAlertView.m
//  ZuChe
//
//  Created by apple  on 2017/4/24.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "WYJAlertView.h"

@implementation WYJAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = frame;
        [self addSubview:_innerView];
    }
    return self;
}

+ (instancetype)defaultPopupView{
    
    return [[WYJAlertView alloc]initWithFrame:CGRectMake(0, 0, 195, 210)];
}


@end
