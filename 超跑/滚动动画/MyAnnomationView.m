//
//  MyAnnomationView.m
//  Dmeo
//
//  Created by Liyn on 2017/7/3.
//  Copyright © 2017年 WYJdemo. All rights reserved.
//

#import "MyAnnomationView.h"

@interface MyAnnomationView()
@property (nonatomic, assign) BOOL isBig;
@end
@implementation MyAnnomationView

-(instancetype)initWithFrame:(CGRect)frame typeString:(NSString *)typeString{
    if (self = [super initWithFrame:frame]) {
        self.typeString = typeString;
        self.image = [UIImage imageNamed:@"圈.png"];
        self.isBig = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)transForm{
    if (self.isBig) {
        
        return;
    }else
        [self becomeBig];
}

-(void)becomeBig{
    self.isBig = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    self.transform = CGAffineTransformMakeScale(1.6, 1.6);
    [UIView commitAnimations];
    
}
-(void)becomeLittle{
    self.isBig = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
    
}


@end
