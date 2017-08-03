//
//  TimeSelectView.m
//  ZuChe
//
//  Created by apple  on 2017/4/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "TimeSelectView.h"
#import "AppDelegate.h"
#import "Header.h"


@interface TimeSelectView()<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    NSString *allUser;
    NSString *user1;
    NSString *user2;
}

@property(nonatomic,strong)UIView *bottomView;//底部view
@property (strong,nonatomic) UIPickerView *datePicker;
@property (strong,nonatomic) UIView*timeSelectView;//时间选择view
@property (strong,nonatomic) NSArray *colorData;//颜色数据
@property (strong,nonatomic) NSArray *colorData2;

@property (strong,nonatomic) NSString  *colorSelectedString;//选择颜色结果
@property (strong,nonatomic)NSString  *colorStr;//颜色
@property (strong , nonatomic)NSString *colorSre2;
@property(nonatomic,strong)NSString *firstColor;
@property (nonatomic , strong)NSString *firstColor2;

@end

@implementation TimeSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.userInteractionEnabled = YES;
    }
    return self;
}
+(instancetype)makeViewWithMaskDatePicker3:(CGRect)frame setTitle3:(NSString *)title Arr3:(NSArray *)arr Arr4:(NSArray *)arr4
{
    TimeSelectView *mview = [[self alloc]initWithFrame:frame];
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
//    timeLab.backgroundColor = [UIColor redColor];
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
    // 设置的是第二列选择的文字
    mview.colorData2 = arr4;
    mview.colorSre2 = arr4[0];
    
    mview.firstColor2 = arr4[0];
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

-(void)makeSureBtn:(UIButton *)makeSureBtn{
    
    //代理传值
//    if ([self.colorStr isEqualToString:@""] && [self.colorSre2 isEqualToString:@""]) {
//        
//        allUser = @"5小时/50公里";
//    }
    if ([allUser isEqualToString:@""]) {
        
        allUser = @"5小时/50公里";
    }
    if ([_delegate respondsToSelector:@selector(getColorChoiceValues333:)]) {
        
        [_delegate getColorChoiceValues333:allUser];
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
    //返回 列
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //选中状态
    if (component == 0) {
        
        self.colorStr = self.colorData[row];
        
    }if (component == 1) {
        
        self.colorSre2 = self.colorData2[row];
    }
    
    allUser = [NSString stringWithFormat:@"%@小时/%@公里",self.colorStr,self.colorSre2];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        
        return 6;
    }else
        return 51;
//self.colorData.count
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
//    allUser = [NSString stringWithFormat:@"%@公里/%@小时",self.colorData2[row],self.colorData[row]];
//    return [NSString stringWithFormat:@"%@公里/%@小时",self.colorData2[row],self.colorData[row]];
    
    if (component == 0) {
        
        return [NSString stringWithFormat:@"%@小时",self.colorData[row]];
    }if (component == 1) {
        return [NSString stringWithFormat:@"%@公里",self.colorData2[row]];
    }
    return nil;
//    allUser = [NSString stringWithFormat:@"%@公里/%@小时",self.colorData2[row],self.colorData[row]];
}

@end
