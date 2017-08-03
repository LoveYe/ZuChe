//
//  WYJAlertView.h
//  ZuChe
//
//  Created by apple  on 2017/4/24.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYJAlertView : UIView

@property (nonatomic , strong) UIView *innerView;
@property (nonatomic, weak)UIViewController *parentVC;

+ (instancetype)defaultPopupView;

@end
