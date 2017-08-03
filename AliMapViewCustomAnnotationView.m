//
//  AllPointsViewController.h
//  CarHead
//
//  Created by MacBookXcZl on 2017/5/17.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
// 既采用自定义气泡，也使用自定义的大头针标记

#import "AliMapViewCustomAnnotationView.h"

#define kCalloutWidth       300
#define kCalloutHeight      80

#define kPortraitMargin     10
#define kPortraitWidth      90
#define kPortraitHeight     60

#define kTitleWidth         70
#define kTitleHeight        20

#define kArrorHeight        20



@interface AliMapViewCustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *telButton;
@property (nonnull,copy)NSString *needXingString;
@end


@implementation AliMapViewCustomAnnotationView

//重写选中方法setSelected。选中时新建并添加calloutView，传入数据；非选中时删除calloutView
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
        if (self.selected == selected)
        {
            return;
        }
        
        if (selected)
        {
            if (self.calloutView == nil)
            {
                self.calloutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
                self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                      -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
                self.calloutView.backgroundColor = [UIColor whiteColor];
            }
            
            self.portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight)];
            self.portraitView.backgroundColor = [UIColor whiteColor];
            [self.calloutView addSubview:self.portraitView];
            
            // 添加标题，即商户名
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 3 + kPortraitWidth, kPortraitMargin, kTitleWidth, kTitleHeight)];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.titleLabel.textColor =  [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];
            NSString *s = [self.annotation.subtitle componentsSeparatedByString:@"·"][0];
            s = [s substringWithRange:NSMakeRange(0, 1)];
            self.titleLabel.text = [NSString stringWithFormat:@"%@师傅",s];
            // self.titleLabel.backgroundColor = [UIColor redColor];
            [self.calloutView addSubview:self.titleLabel];
            
            //        // 添加副标题，即商户地址
                    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 3 + kPortraitWidth, 50, kTitleWidth, kTitleHeight)];
            self.subtitleLabel.adjustsFontSizeToFitWidth = YES;
                    self.subtitleLabel.font = [UIFont systemFontOfSize:17];
            NSString *s1 = [self.annotation.subtitle componentsSeparatedByString:@"·"][1];
                    self.subtitleLabel.textColor =  [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1];
                    self.subtitleLabel.text = s1;
                   // self.subtitleLabel.backgroundColor = [UIColor redColor];
                    [self.calloutView addSubview:self.subtitleLabel];

            self.telButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.telButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //  self.telButton.backgroundColor = [UIColor redColor];
            [self.telButton addTarget: self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            self.telButton.frame = CGRectMake(230, 15, 50, 50);
            
            [self.calloutView addSubview:self.telButton];
            
            
            [self addSubview:self.calloutView];
        }
        else
        {
             [self.calloutView removeFromSuperview];
             [self.portraitView removeFromSuperview];
             [self.subtitleLabel removeFromSuperview];
             [self.titleLabel removeFromSuperview];
             [self.telButton removeFromSuperview];
        }
    
        [super setSelected:selected animated:animated];

}

-(void)setXingString:(NSString *)xingString {
    self.needXingString = xingString;
}

-(void)setTuImage:(UIImage *)tuImage {
    self.portraitView.image = tuImage;
}
-(void)setTelImage:(UIImage *)telImage {
     [self.telButton setBackgroundImage:telImage forState:UIControlStateNormal];
}
-(void)click:(UIButton *)button {
    NSLog(@"caonima");
    [self.calloutView removeFromSuperview];
    [self.portraitView removeFromSuperview];
    [self.subtitleLabel removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.telButton removeFromSuperview];
    [self callPhone:self.annotation.title];
}
-(void)callPhone:(NSString *)phoneNum {
    
    if (phoneNum.length == 0) {
        
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        
        CGPoint tempoint = [self.telButton convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.telButton.bounds, tempoint))
            
        {
            
            view = self.telButton;
            
        }
        
    }
    
    return view;
    
}

@end
