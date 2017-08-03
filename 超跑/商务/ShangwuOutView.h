//
//  ShangwuOutView.h
//  ZuChe
//
//  Created by apple  on 2017/6/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ShangwuOutDelegate<NSObject>
-(void)getChaochuChoice:(NSString *)values ;//获取颜色改变的代理方法
@end

@interface ShangwuOutView : UIView

@property (nonatomic , weak)id <ShangwuOutDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker:(CGRect)frame setTitle:(NSString *)title Arr1:(NSArray *)arr Arr2:(NSArray *)arr4;

@end
