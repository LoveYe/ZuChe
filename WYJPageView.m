//
//  WYJPageView.m
//  ZuChe
//
//  Created by apple  on 2017/3/24.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "WYJPageView.h"

@implementation WYJPageView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    return self;
}
- (void)setSelect:(UIImage *)select{
    
    [self updateDots];
}
- (void)setDeselest:(UIImage *)Deselest{
    
    [self updateDots];
}


- (void)updateDots{
    
    if (self.Deselest || self.select) {
        for (int i = 0; i < [self.subviews count]; i++) {
            
            UIImageView *dot = [self.subviews objectAtIndex:i];
            
            CGSize size;
            size.height = 15;
            size.width = 15;
            [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.height)];
            
            dot.image = self.currentPage == i ? self.Deselest : self.select;
        }
    }
}
- (void)setCurrentPage:(NSInteger)currentPage{
    
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}



















@end
