//
//  HeadTitleView.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/6/12.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "HeadTitleView.h"

@implementation HeadTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
}
@end
