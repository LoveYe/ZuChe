//
//  CarColorView.m
//  ZuChe
//
//  Created by apple  on 2017/3/7.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CarColorView.h"
#import "AppDelegate.h"
#import "Header.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface CarColorView() <UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIView *bottomView;//底部view
@property (strong,nonatomic) UIPickerView *datePicker;
@property (strong,nonatomic) UIView*timeSelectView;//时间选择view
@property (strong,nonatomic) NSArray *colorData;//颜色数据

@property (strong,nonatomic) NSString  *colorSelectedString;//选择颜色结果
@property (strong,nonatomic)NSString  *colorStr;//颜色
@property(nonatomic,strong)NSString *firstColor;

@end

@implementation CarColorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.userInteractionEnabled = YES;
    }
    return self;
}
+(instancetype)makeViewWithMaskDatePicker2:(CGRect)frame setTitle2:(NSString *)title Arr2:(NSArray *)arr
{
    CarColorView *mview = [[self alloc]initWithFrame:frame];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:mview];
    //添加底部view添加的window上
    mview.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *3/5, SCREEN_WIDTH, SCREEN_HEIGHT *2/5)];
    mview.bottomView.backgroundColor = [UIColor whiteColor];
    [delegate.window addSubview:mview.bottomView];
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) {
        mview.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT *2/5, SCREEN_WIDTH, SCREEN_HEIGHT *3/5);
    }
    
    //顶部时间选择label
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,SCREEN_WIDTH, 30)];
    timeLab.text = title;
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = Color(65, 65, 65);
    [mview.bottomView addSubview:timeLab];
    
    //添加自定义一个时间选择器
    mview.datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeLab.frame),SCREEN_WIDTH,mview.bottomView.frame.size.height - CGRectGetMaxY(timeLab.frame) - 40)];
    mview.datePicker.backgroundColor = [UIColor whiteColor];
    mview.datePicker.dataSource = mview;
    mview.datePicker.delegate = mview;
    //初始时间选择文字
    mview.colorData = arr;
    mview.colorStr =arr[0];
    mview.firstColor = arr[0];
    [mview.datePicker selectRow:0 inComponent:0 animated:NO];
    [mview.bottomView addSubview:mview.datePicker];
    
    //添加底部button
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(SCREEN_WIDTH/2 - SCREEN_WIDTH*0.3, CGRectGetMaxY(mview.datePicker.frame) , SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.08);
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:mview action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mview.bottomView addSubview:cancelBtn];
    //确定按钮
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.frame = CGRectMake(SCREEN_WIDTH/2 + SCREEN_WIDTH*0.1 , CGRectGetMaxY(mview.datePicker.frame), SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.08);
    [makeSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    UIColor *color = Color(0, 215, 200);
    [makeSureBtn setTitleColor:color forState:UIControlStateNormal];
    [makeSureBtn addTarget:mview action:@selector(makeSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mview.bottomView addSubview:makeSureBtn];
    
    
    return mview;
}
//取消
-(void)cancelBtn:(UIButton *)cancelBtn
{
    [self removeView];
}

-(void)makeSureBtn:(UIButton *)makeSureBtn
{
    //代理传值
    if ([_delegate respondsToSelector:@selector(getColorChoiceValues22:)]) {
        if (!self.colorStr) {
            self.colorStr = self.firstColor;
        }
        [_delegate getColorChoiceValues22:self.colorStr];
    }
    [self removeView];
}
//取消蒙层
-(void)removeView{
    
    [self.bottomView removeFromSuperview];
    [self removeFromSuperview];
}
#pragma mark pickDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //颜色
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.colorStr = self.colorData[row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.colorData.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.colorData[row];
}

@end
