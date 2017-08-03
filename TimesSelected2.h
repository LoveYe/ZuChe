//
//  TimesSelected2.h
//  ZuChe
//
//  Created by apple  on 2017/4/17.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LXKColorChoiceDelegate4<NSObject>
-(void)getColorChoiceValues444:(NSString *)values ;//获取颜色改变的代理方法
@end

@interface TimesSelected2 : UIView

@property(nonatomic,weak) id<LXKColorChoiceDelegate4>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker4:(CGRect)frame setTitle4:(NSString *)title Arr4:(NSArray *)arr Arr4:(NSArray *)arr4;

@end
