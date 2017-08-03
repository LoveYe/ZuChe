//
//  AllPointsViewController.h
//  CarHead
//
//  Created by MacBookXcZl on 2017/5/17.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
// 既采用自定义气泡，也使用自定义的大头针标记

#import "AliMapViewCustomPinAnnotationView.h"

@interface AliMapViewCustomPinAnnotationView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation AliMapViewCustomPinAnnotationView

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
                self.calloutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
                self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                      -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
                self.calloutView.backgroundColor = [UIColor whiteColor];
            }
            // 添加标题，即商户名
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 80, 40)];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            self.titleLabel.textColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.text = [_name copy];
            // self.titleLabel.backgroundColor = [UIColor redColor];
            [self.calloutView addSubview:self.titleLabel];
            [self addSubview:self.calloutView];
        }
        else
        {
            [self.calloutView removeFromSuperview];
        }
        [super setSelected:selected animated:animated];
        
        // self.backgroundColor = [UIColor clearColor];
}
@end
