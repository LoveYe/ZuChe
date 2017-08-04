//
//  MyScrollView.m
//  ScrollViewTest1
//
//  Created by 吕中威 on 16/8/9.
//  Copyright © 2016年 吕中威. All rights reserved.
//

#import "MyScrollView.h"
#import <math.h>
#import "Header.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "MarriedCar.h"
#import "CarTypePingjia.h"

//#define SPACE 5
//#define WIDTH ([UIScreen mainScreen].bounds.size.width - 80)

#define width1 ([UIScreen mainScreen].bounds.size.width)
#define WIDTH (width1 - width1*0.25)
#define SPACE (width1 * 0.02)

@implementation MyScrollView{
    
    UIScrollView *_scrollView;
    NSArray *_arr;
    
    NSInteger _count;
    
    
    CGRect *qqq;
    UIButton *quanju;
    
    NSString *type;
    NSArray *_carType;
    NSArray *_buzhou;
    NSArray *_jiage;
    NSArray *_chaoshi;
    NSArray *_chaoKM;
    NSArray *_carID;
    
    float _huadong;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (id)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr carType:(NSArray *)carArray buZhou:(NSArray *)buzhouArray jiage:(NSArray *)price chaoshi:(NSArray *)chaoshiArray chaoKM:(NSArray *)chaoKMArray carID:(NSArray *)carIDArray{
    
    if (self = [super initWithFrame:frame]) {
        
        _huadong = 0.0;
        _arr = [NSArray arrayWithArray:imageArr];
        _carType = [NSArray arrayWithArray:carArray];
        _buzhou = [NSArray arrayWithArray:buzhouArray];
        _jiage = [NSArray arrayWithArray:price];
        _chaoshi = [NSArray arrayWithArray:chaoshiArray];
        _chaoKM = [NSArray arrayWithArray:chaoKMArray];
        _carID = [NSArray arrayWithArray:carIDArray];
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        [self createScrollView:frame];
        
//        UIButton *button = [self viewWithTag:1000];
//        [button addTarget:self action:@selector(handleTapGR:) forControlEvents:UIControlEventTouchUpInside];
//        [self handleTapGR:button];
    }
    return self;
}

- (void)createScrollView:(CGRect)frame{
    
    qqq = &frame;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 0, WIDTH, frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.clipsToBounds = NO;
    _scrollView.bounces = NO;
    
    for (int i = 0; i < _arr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake((i * WIDTH)+SPACE, 0, WIDTH*1.04 - SPACE * 2, frame.size.height);
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [button setBackgroundImage:[UIImage imageNamed:_arr[i]] forState:UIControlStateNormal];
            });
        });
        UIColor *color = Color(7, 187, 177);
        button.layer.borderWidth = 1.5;
        button.layer.borderColor = [[UIColor clearColor] CGColor];
        button.tag = i+1000;
        button.layer.masksToBounds = YES;
        button.transform = CGAffineTransformMakeScale(0.77, 0.77);
        if (i == 0) {
            
            button.layer.borderColor = [color CGColor];
            button.layer.borderWidth = 1.5;
            quanju = button;
            button.layer.masksToBounds = YES;
            button.selected = YES;
            [self handleTapGR:quanju.tag];
            button.transform = CGAffineTransformMakeScale(1.05, 1.05);
        }
        quanju.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(carDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        
//        UIImageView *black = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(quanju.frame)-WIDTH*0.12, WIDTH*0.4, WIDTH*0.1)];
//        black.backgroundColor = [UIColor blackColor];
//        black.alpha = 0.7;
//        [button addSubview:black];
//        
//        
//        UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.01, WIDTH*0.01, WIDTH*0.23, WIDTH*0.08)];
//        jiage.text = [NSString stringWithFormat:@"¥%@",_jiage[i]];
//        jiage.textColor = [UIColor whiteColor];
//        [jiage sizeToFit];
//        jiage.textAlignment = NSTextAlignmentLeft;
//        jiage.font = [UIFont systemFontOfSize:17];
//        [black addSubview:jiage];
//        
//        UILabel *shang = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.21, WIDTH*0.005, WIDTH*0.19, WIDTH*0.05)];
//        shang.textAlignment = NSTextAlignmentCenter;
//        shang.textColor = [UIColor whiteColor];
//        shang.text = @"5小时";
//        shang.font = [UIFont systemFontOfSize:10];
//        [black addSubview:shang];
//        
//        UILabel *xia = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.21, WIDTH*0.055, WIDTH*0.19, WIDTH*0.05)];
//        xia.text = @"50公里";
//        xia.textAlignment = NSTextAlignmentCenter;
//        xia.textColor = [UIColor whiteColor];
//        xia.font = [UIFont systemFontOfSize:10];
//        [black addSubview:xia];
        
        UILabel *CarType = [[UILabel alloc] initWithFrame:CGRectMake((i * WIDTH)+SPACE-WIDTH*0.03, CGRectGetMaxY(quanju.frame)+WIDTH*0.01, WIDTH *0.5, WIDTH*0.08)];
        if (i != 0) {
            CarType.alpha = 0.0;
        }
        CarType.tag = 666+i;
        CarType.text = _carType[i];
        CarType.textAlignment = NSTextAlignmentLeft;
        CarType.textColor = Color(95, 95, 95);
        CarType.adjustsFontSizeToFitWidth = YES;
        [CarType sizeToFit];
        
        CarType.font = [UIFont systemFontOfSize:17];
        [_scrollView addSubview:CarType];
        
//        UIImageView *carCount = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*0.7+i*WIDTH, CGRectGetMaxY(quanju.frame)+WIDTH*0.02, WIDTH*0.05, WIDTH*0.05)];
//        carCount.image = [UIImage imageNamed:@"邀请.png"];
//        [_scrollView addSubview: carCount];
        
        
        UILabel *shuliang = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.69+i*WIDTH, CGRectGetMaxY(quanju.frame)+WIDTH*0.01, WIDTH*0.35, WIDTH*0.08)];
        shuliang.textColor = Color(125, 125, 125);
        if(i != 0){
            
            shuliang.alpha = 0.0;
        }
        shuliang.tag = 555+i;
        shuliang.font = [UIFont systemFontOfSize:15];
        
        shuliang.text = [NSString stringWithFormat:@"%@+ 人预定",_buzhou[i]];
        [shuliang sizeToFit];
        shuliang.adjustsFontSizeToFitWidth = YES;
        shuliang.textAlignment = NSTextAlignmentRight;
        [_scrollView addSubview:shuliang];
    }
    _scrollView.contentSize = CGSizeMake(WIDTH * _arr.count , frame.size.height);
//      NSLog(@"_scrollView.偏移量---%f",_scrollView.contentSize.width);
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    
    
    [self addSubview:_scrollView];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view  = [super hitTest:point withEvent:event];
    
    if ([view isEqual:self]) {
        
        for (UIView *subview in _scrollView.subviews) {
            
            CGPoint offset = CGPointMake(point.x - _scrollView.frame.origin.x + _scrollView.contentOffset.x - subview.frame.origin.x,
                                         point.y - _scrollView.frame.origin.y + _scrollView.contentOffset.y - subview.frame.origin.y);
            
            if ((view = [subview hitTest:offset withEvent:event])){
                
                return view;
            }
        }
        return [_scrollView hitTest:point withEvent:event];
    }
    return view;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat currentPostion = _scrollView.contentOffset.x;
    int i = currentPostion/WIDTH;
    
    UIColor *color = Color(7, 187, 177);
    UIButton *button = (UIButton *)[self viewWithTag:i+1000];
    button.layer.borderColor = [color CGColor];
    button.layer.borderWidth = 1.5;
    if (quanju != button) {
        
        quanju.layer.borderColor = [[UIColor clearColor] CGColor];;
        button.selected = YES;
        quanju.selected = NO;
        button.transform = CGAffineTransformMakeScale(1.05, 1.05);;
    }
    quanju = button;
    
    UIButton *button1 = [self viewWithTag:i+1+1000];
    button1.transform = CGAffineTransformMakeScale(0.77, 0.77);;
    
    UIButton *button2 = [self viewWithTag:i-1+1000];
    button2.transform = CGAffineTransformMakeScale(0.77, 0.77);
    
    [self handleTapGR:button.tag];
    
    UILabel *la = [self viewWithTag:666+i];
    UILabel *shuliang = [self viewWithTag:555+i];
    
    [UIView transitionWithView:la duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        la.alpha= 1;
        //shuliang.alpha =1 ;
    } completion:^(BOOL finished) {
        
    }];
    [UIView transitionWithView:shuliang duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        shuliang.alpha =1 ;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat currentPostion = _scrollView.contentOffset.x;
    int i = currentPostion/WIDTH;

    float maxNumber = 1.05 -((currentPostion-(width1*0.751*i))/1000);
    
    UILabel *la = [self viewWithTag:666+i];
    UILabel *la1 = [self viewWithTag:666+i-1];
    UILabel *la2 = [self viewWithTag:666+i+1];
    
    UILabel *shuliang = [self viewWithTag:555+i];
    UILabel *shu1 = [self viewWithTag:555+i-1];
    UILabel *shu2 = [self viewWithTag:555+i+1];
    
    la.alpha = 0;
    la1.alpha = 0;
    la2.alpha = 0;
    shuliang.alpha = 0;
    shu1.alpha = 0;
    shu2.alpha = 0;
    
    
    float minNumber = 0.77 + ((currentPostion-(width1*0.751*i))/1000);
    float b = minNumber;
//    if (b <= 0.77) {
//        b = 0.77;
//    }
//    if (maxNumber >= 1.05) {
//        
//        maxNumber = 1.05;
//    }
    
    UIButton *button  = (UIButton *)[self viewWithTag:i+1000];
    UIButton *button2 = (UIButton *)[self viewWithTag:i+1+1000];
    UIButton *button3 = (UIButton *)[self viewWithTag:i-1+1000];
    
    
//    NSLog(@"----------%f",maxNumber);
    button.transform = CGAffineTransformMakeScale(maxNumber, maxNumber);
    button2.transform = CGAffineTransformMakeScale(b, b);
    button3.transform = CGAffineTransformMakeScale(b, b);;
    quanju = button;
}

- (void)handleTapGR:(NSInteger)tap  {
    
    if (_delegate &&[_delegate respondsToSelector:@selector(sendstr:)]) {
        
        MarriedCar *view = [[MarriedCar alloc] init];
        NSString *str = [NSString stringWithFormat:@"%d",(int)(tap-1000)];
        view.cartype = [NSString stringWithFormat:@"%d",(int)(tap-1000)];
        [_delegate sendstr:str];
    }
}
- (void)carDetailInfo:(UIButton *)sender{
    
//    NSLog(@"%d",(int)sender.tag);
    long carid = sender.tag - 1000;
    if (_pjDelegate && [_pjDelegate respondsToSelector:@selector(openPingjia:carid:)]) {
        
        [_pjDelegate openPingjia:@"1" carid:[NSString stringWithFormat:@"%@",_carID[carid]]];
    }
}


@end
