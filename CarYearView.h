//
//  CarYearView.h
//  ZuChe
//
//  Created by apple  on 2017/3/7.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LXKColorChoiceDelegate1<NSObject>
-(void)getColorChoiceValues11:(NSString *)values;//获取颜色改变的代理方法
@end

@interface CarYearView : UIView

@property(nonatomic,weak) id<LXKColorChoiceDelegate1>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker1:(CGRect)frame setTitle1:(NSString *)title Arr1:(NSArray *)arr;

@end
