//
//  AliMapViewCustomCalloutView.m
//  AliMapKit
//
//  Created by 夏远全 on 16/12/12.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//  自定义气泡

#import "AliMapViewCustomCalloutView.h"

#define kPortraitMargin     10
#define kPortraitWidth      90
#define kPortraitHeight     60

#define kTitleWidth         70
#define kTitleHeight        30

#define kArrorHeight        20

@interface AliMapViewCustomCalloutView ()
@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *telButton;
@end

@implementation AliMapViewCustomCalloutView


//初始化内容
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    
    
//#define kPortraitMargin     10
//#define kPortraitWidth      90
//#define kPortraitHeight     60
//    
//#define kTitleWidth         70
//#define kTitleHeight        70
//    
//#define kArrorHeight        20

    
    // 添加图片，即商户图
    self.portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight)];
    self.portraitView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.portraitView];
    
    // 添加标题，即商户名
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin + kTitleHeight, kTitleWidth, kTitleHeight)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:14];
    self.subtitleLabel.textColor = [UIColor blackColor];
    self.subtitleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.subtitleLabel];
    

    self.telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.telButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.telButton.backgroundColor = [UIColor redColor];
    self.telButton.frame = CGRectMake(kPortraitMargin * 3 + kPortraitWidth+kTitleWidth, 20, 50, 50);
    [self addSubview:self.telButton];
}

-(void)button:(UIButton *)button {
    NSLog(@"111122223333");
}

//接收传递进的参数
-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = [title copy];
}

-(void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = [subtitle copy];
}

-(void)setImage:(UIImage *)image
{
    self.portraitView.image = image;
}

-(void)setTeButtonTitle:(NSString *)teButtonTitle
{
    
    [self.telButton setTitle:[teButtonTitle copy] forState:UIControlStateNormal];
    [self.telButton addTarget: self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        
        CGPoint tempoint = [self convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.bounds, tempoint))
            
        {
            
            view = self;
            
        }
        
    }
    return view;
    
}

//绘制弹出气泡的背景
-(void)drawRect:(CGRect)rect{
    
    //设置阴影
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
   
    //绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1].CGColor);
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    //绘制路径
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    //绘制圆弧
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
    CGContextFillPath(context);
}


@end
