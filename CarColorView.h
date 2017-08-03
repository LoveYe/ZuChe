//
//  CarColorView.h
//  ZuChe
//
//  Created by apple  on 2017/3/7.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LXKColorChoiceDelegate2<NSObject>
-(void)getColorChoiceValues22:(NSString *)values;//获取颜色改变的代理方法
@end

@interface CarColorView : UIView

@property(nonatomic,weak) id<LXKColorChoiceDelegate2>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker2:(CGRect)frame setTitle2:(NSString *)title Arr2:(NSArray *)arr;

@end
