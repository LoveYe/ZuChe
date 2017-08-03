//
//  AllTanchuView.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/7/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "AllTanchuView.h"
#import "Header.h"


static id _instance;
@implementation AllTanchuView

+ (instancetype)sharedView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        
    });
    return _instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
       // [self addSubview:self.bottomView];
    }
    return self;
}

//- (void)chaoguowubaimi{
//    
//   // UIView *bigView = [[UIView alloc] initWithFrame:frame];
//      self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
//        self.tag = 1019;
////    [self addSubview:bigView];
////    
//    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
//    _alertView.backgroundColor = [UIColor whiteColor];
//    _alertView.alpha = 1.0;
//    
//    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
//    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
//        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    [self addSubview:_alertView];
//    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
//    image.image = [UIImage imageNamed:@"白背景.png"];
//    //    image.backgroundColor = [UIColor redColor];
//    [_alertView addSubview:image];
//    
//    image.userInteractionEnabled = YES;
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
//    label.text = @"距离集合地点超过500米";
//    label.textColor = Color(107, 107, 107);
//    label.textAlignment = NSTextAlignmentCenter;
//    label.adjustsFontSizeToFitWidth = YES;
//    label.font = [UIFont fontWithName:@"ArialMT" size:18];
//    [image addSubview:label];
//    
//    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.7, 0.5)];
//    xian.backgroundColor = Color(217, 217, 217);
//    [image addSubview:xian];
//    
//    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
//    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.8, ScreenWidth*0.08);
//    [queding setTitle:@"确定" forState:UIControlStateNormal];
//    [queding addTarget:self action:@selector(removeChaoguo) forControlEvents:UIControlEventTouchUpInside];
//    UIColor *color = Color(7, 187, 177);
//    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
//    [queding setTitleColor:color forState:UIControlStateNormal];
//    [image addSubview:queding];
//}
//-(void)removeChaoguo {
//    
//    [self removeFromSuperview];
//}
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//
//    
//}



@end
