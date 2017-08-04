//
//  SecScrollView.m
//  ZuChe
//
//  Created by apple  on 2017/2/27.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "SecScrollView.h"
#import <math.h>
#import "Header.h"
#import "MarriedCar.h"

#define width ([UIScreen mainScreen].bounds.size.width)
#define WIDTH (width - width*0.25)
#define SPACE (width * 0.02)

@implementation SecScrollView{
    
    UIScrollView *_scrollView;
    NSArray *_arr;
    
    NSInteger _count;
    
    NSString *type;
    NSArray *_carType;
    NSArray *_buzhou;
    NSArray *_jiage;
    NSArray *_priceArray1;
    NSArray *_priceArray2;
    NSArray *_carID;
    
    UIButton *quanju;
}
- (id)initWithframe:(CGRect)frame ImgArray:(NSArray *)array carType:(NSArray *)carArray buZhou:(NSArray *)buzhouArray jiage:(NSArray *)price chaoshi:(NSArray *)chaoshiArray chaoKM:(NSArray *)chaoKMArray carID:(NSArray *)carIDArray{
    
    _arr = [NSArray array];
    _carType = [NSArray array];
    _buzhou = [NSArray array];
    _jiage = [NSArray array];
    _priceArray1 = [NSArray array];
    _priceArray2 = [NSArray array];
    _carID = [NSArray array];
    
    if (self = [super initWithFrame:frame]) {
        
        _arr = [NSArray arrayWithArray:array];
        _carType = [NSArray arrayWithArray:carArray];
        _buzhou = [NSArray arrayWithArray:buzhouArray];
        _jiage = [NSArray arrayWithArray:price];
        _priceArray1 = [NSArray arrayWithArray:chaoshiArray];
        _priceArray2 = [NSArray arrayWithArray:chaoKMArray];
        _carID = [NSArray arrayWithArray:carIDArray];
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self createScrollView:frame];
    }
    return self;
}

- (void)createScrollView:(CGRect)frame{
    
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
                
                [button setBackgroundImage:[[UIImage imageNamed:_arr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            });
        });
        button.tag = i+1000;
        UIColor *color = Color(7, 187, 177);
        button.layer.masksToBounds = YES;
        button.layer.borderColor = [[UIColor clearColor] CGColor];
        button.layer.borderWidth = 1.5;
        button.transform = CGAffineTransformMakeScale(0.77, 0.77);
        if (i == 0) {
            
            button.selected = YES;
            button.layer.borderColor = [color CGColor];
            button.layer.borderWidth = 1.5;
            button.layer.masksToBounds = YES;
            quanju = button;
            button.transform = CGAffineTransformMakeScale(1.05, 1.05);
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        quanju.layer.masksToBounds = YES;
        [_scrollView addSubview:button];
        
//        UIImageView *black = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(quanju.frame)-WIDTH*0.12, WIDTH*0.4, WIDTH*0.1)];
//        black.backgroundColor = [UIColor blackColor];
//        black.alpha = 0.7;
//        [button addSubview:black];
//        
//        UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.01, WIDTH*0.01, WIDTH*0.23, WIDTH*0.08)];
//        jiage.text = [NSString stringWithFormat:@"¥%@",_jiage[i]];
//        jiage.textColor = [UIColor whiteColor];
//        jiage.textAlignment = NSTextAlignmentLeft;
//        jiage.font = [UIFont systemFontOfSize:20];
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
        CarType.text = _carType[i];
        if (i != 0) {
            
            CarType.alpha = 0.0;
        }
        CarType.tag = 666+i;
        CarType.textAlignment = NSTextAlignmentLeft;
        CarType.textColor = Color(95, 95, 95);
        CarType.font = [UIFont systemFontOfSize:17];
        CarType.adjustsFontSizeToFitWidth = YES;
        [CarType sizeToFit];
        [_scrollView addSubview:CarType];
        
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
        button.transform = CGAffineTransformMakeScale(1.05, 1.05);
    }
    UIButton *button1 = [self viewWithTag:i+1+1000];
    button1.layer.borderColor = [[UIColor clearColor] CGColor];
    button1.transform = CGAffineTransformMakeScale(0.77, 0.77);;
    
    UIButton *button2 = [self viewWithTag:i-1+1000];
    button2.layer.borderColor = [[UIColor clearColor] CGColor];
    button2.transform = CGAffineTransformMakeScale(0.77, 0.77);
    quanju = button;
    
    [self handleTapGR:button];
    
    UILabel *la = [self viewWithTag:666+i];
    UILabel *shuliang = [self viewWithTag:555+i];
    
    [UIView transitionWithView:la duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        la.alpha= 1;
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
    
    UILabel *la = [self viewWithTag:666+i];
    UILabel *la1 = [self viewWithTag:666+i-1];
    UILabel *la2 = [self viewWithTag:666+i+1];
    
    UILabel *shuliang = [self viewWithTag:555+i];
    UILabel *shu1 = [self viewWithTag:555+i-1];
    UILabel *shu2 = [self viewWithTag:555+i+1];
    
    la1.alpha = 0;
    la2.alpha = 0;
    shu1.alpha = 0;
    shu2.alpha = 0;
    shuliang.alpha = 0;
    la.alpha = 0;
    
    float maxNumber = 1.05 -((currentPostion-(width*0.751*i))/1000);
    float minNumber = 0.77 + ((currentPostion-(width*0.751*i))/1000);
    float b = minNumber;
    
    UIButton *button  = (UIButton *)[self viewWithTag:i+1000];
    UIButton *button2 = (UIButton *)[self viewWithTag:i+1+1000];
    UIButton *button3 = (UIButton *)[self viewWithTag:i-1+1000];
    
    
    NSLog(@"----------%f",maxNumber);
    button.transform = CGAffineTransformMakeScale(maxNumber, maxNumber);
    button2.transform = CGAffineTransformMakeScale(b, b);
    button3.transform = CGAffineTransformMakeScale(b, b);;
    quanju = button;
    
}


- (void)handleTapGR:(UIButton *)tap {
    
//    NSLog(@"****%ld",tap.tag);
    
    long i = tap.tag - 1000;
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendtype:price:color:price1:price2:)]) {
        
        MarriedCar *view = [[MarriedCar alloc] init];
        view.gencartype2 = _carType[i];
        view.gencarPrice2 = _jiage[i];
        view.genchejiage1 = _priceArray1[i];
        view.genchejiage2 = _priceArray2[i];
        
        NSString *str = _arr[i];
        if ([str containsString:@"白"]) {
            
            view.gencarColor2 = @"白色";
            [_delegate sendtype:view.gencartype2 price:view.gencarPrice2 color:view.gencarColor2 price1:view.genchejiage1 price2:view.genchejiage2];
        }else{
            
            view.gencarColor2 = @"黑色";
            [_delegate sendtype:view.gencartype2 price:view.gencarPrice2 color:view.gencarColor2 price1:view.genchejiage1 price2:view.genchejiage2];
        }
        
    }
}

- (void)buttonClick:(UIButton *)sender{
    
    long carid = sender.tag - 1000;
    
    if (_pjDelegate && [_pjDelegate respondsToSelector:@selector(openPingjia2:carid2:)]) {
        
        [_pjDelegate openPingjia2:@"2" carid2:[NSString stringWithFormat:@"%@",_carID[carid]]];
    }
}




@end
