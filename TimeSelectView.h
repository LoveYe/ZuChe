//
//  TimeSelectView.h
//  ZuChe
//
//  Created by apple  on 2017/4/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  LXKColorChoiceDelegate3<NSObject>
-(void)getColorChoiceValues333:(NSString *)values ;//获取颜色改变的代理方法
@end

@interface TimeSelectView : UIView

@property(nonatomic,weak) id<LXKColorChoiceDelegate3>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker3:(CGRect)frame setTitle3:(NSString *)title Arr3:(NSArray *)arr Arr4:(NSArray *)arr4;

@end
