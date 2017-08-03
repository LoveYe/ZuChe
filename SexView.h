//
//  SexView.h
//  ZuChe
//
//  Created by apple  on 2017/3/7.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LXKColorChoiceDelegate3<NSObject>
-(void)getColorChoiceValues33:(NSString *)values;//获取颜色改变的代理方法
@end

@interface SexView : UIView

@property(nonatomic,weak) id<LXKColorChoiceDelegate3>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker3:(CGRect)frame setTitle3:(NSString *)title Arr3:(NSArray *)arr;

@end
