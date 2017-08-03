//
//  ParentsViewController.h
//  Damai
//
//  Created by qianfeng01 on 15-1-20.
//  Copyright (c) 2015年 BSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCDraggableButton.h"
#import "CustomTextField.h"

typedef void (^Refresh)(void);

@interface ParentsViewController : UIViewController

@property (nonatomic) UIWebView *Lodingwebview;

@property (nonatomic,copy) NSString *status;

-(void)lostnet:(UIView *)page loding:(void (^)(NSString *status))loding;

-(void)addTitleViewWithTitle:(NSString *)title;

-(void)addItemWithCustomView:(NSArray *)customViews isLeft:(BOOL)isLeft;

//-(void)addTask:(NSString *)url finished:(SEL)sel;

-(void)initTitleBar;

-(void)wenxintishiTitle:(NSString *)tishi;

-(void)xiaojiadeTishiTitle:(NSString *)tishixinxi;

//- (UIBarButtonItem *)rightBarButtonItem:(NSString *)imagenamed;

//- (UIBarButtonItem *)leftBarButtonItem:(NSString *)imagenamed;

-(void)ShowMBHubWithTitleOnlyWithTitle:(NSString *)title withTime:(float)time;

- (NSString *)generateTradeNO;

-(void)thisIsDuanXinYanZhengWithPhone:(NSString *)phone;

-(void)button :(UIButton *)button  isBold:(BOOL)isBold isFont:(float )fontOrBoldFont;

-(void)label :(UILabel *)label isBold:(BOOL)isBold isFont:(float )fontOrBoldFont;

- (void)loadAvatarInKeyWindow;

-(void)startTimebtn:(UIButton *)btn;

//找车首页导航栏上的俩按钮和一个搜索框
-(void)leftButton:(NSString *)title action:(SEL)action;


-(void)rightButton:(NSString *)title action:(SEL)action;

-(void)textfieldsech:(SEL)action action1:(SEL)TapGestureRecognizer;

@property (nonatomic,retain)UIButton *RightBtn;

@property (nonatomic,retain)UIButton *LeftBtn;

@property (nonatomic,retain)UILabel *labell;

@property (nonatomic,retain)RCDraggableButton *avatar1;

@property (nonatomic,retain)CustomTextField *textField;

-(void)addView:(UIView *)view grade:( int )grade;

//文字行间距
-(void)TextLineSpacing:(CGFloat )flot text:(UILabel *)Hlabel;

//自动适应宽高
-(void)suitableWH:(UILabel *)label X:(CGFloat )X Y:(CGFloat)Y font:(UIFont *)font;

-(void)Refresh_JXY:(UITableView *)TABLEVIEW VOID:(Refresh)VOID;

-(void)AlertController:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionWithTitle:(NSString *)title actionWithTitle2:(NSString *)title2 handler:(void (^ __nullable)(UIAlertAction *action))handler handler2:(void (^ __nullable)(UIAlertAction *action))handler2 handler3:(void (^ __nullable)(UIAlertAction *action))handler3;

@end
