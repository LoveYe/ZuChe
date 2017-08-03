//
//  ZmjPickView.m
//  ZmjPickView
//
//  Created by XLiming on 17/1/16.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "ZmjPickView.h"
#import "Header.h"

#define MainBackColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]

@interface ZmjPickView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView   *pickerView;

@property (strong, nonatomic) UIButton       *cancelBtn;

@property (strong, nonatomic) UIButton       *DetermineBtn;

@property (strong, nonatomic) UILabel        *addressLb;

@property (strong, nonatomic) UIView         *darkView;

@property (strong, nonatomic) UIView         *backView;

@property (strong, nonatomic) UIBezierPath   *bezierPath;

@property (strong, nonatomic) CAShapeLayer   *shapeLayer;

@property (strong, nonatomic) NSArray        *shengArray;

@property (strong, nonatomic) NSArray        *shiArray;

@property (strong, nonatomic) NSArray        *xianArray;

@property (strong, nonatomic) NSMutableArray *shiArr;

@property (strong, nonatomic) NSMutableArray *xianArr;

@end

@implementation ZmjPickView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight + 300);
        
        [self initData];
        
        [self initGesture];
    }
    return self;
}

- (void)show {
    
    [self initView];
}

- (void)initView {
    
    [self showInView:[[UIApplication sharedApplication].windows lastObject]];
    
    [self addSubview:self.darkView];
    [self addSubview:self.backView];
    [self.backView addSubview:self.cancelBtn];
    [self.backView addSubview:self.DetermineBtn];
//    [self.backView addSubview:self.addressLb];
    [self.backView addSubview:self.pickerView];
    
    [self bezierPath];
    [self shapeLayer];
    
    _addressLb.text = [NSString stringWithFormat:@"%@%@%@",_shengArray[0][@"name"],
                       _shiArr.count > 0? _shiArr[0][@"name"]:0,
                       _xianArr.count > 0? _xianArr[0][@"name"]:0];
}

- (void)initData {
    
    [self shiArr];
    [self xianArr];
    
    _shengArray = [self JsonObject:@"sheng.json"];
    _shiArray   = [self JsonObject:@"shi.json"];
    _xianArray  = [self JsonObject:@"xian.json"];
    
    NSInteger index = [_shengArray[0][@"id"] integerValue];
    
    [_shiArr removeAllObjects];
    
    for (int i = 0; i < _shiArray.count; i++) {
        
        if ([_shiArray[i][@"parent_id"] integerValue] == index) {
            
            [_shiArr addObject:_shiArray[i]];
        }
    }
    
    index = [_shiArr[0][@"id"] integerValue];
    
    [_xianArr removeAllObjects];
    
    for (int i = 0; i < _xianArray.count; i++) {
        
        if ([_xianArray[i][@"parent_id"] integerValue] == index) {
            
            [_xianArr addObject:_xianArray[i]];
        }
    }
}

- (void)initGesture {

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}

- (void)showInView:(UIView *)view {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGPoint point = self.center;
        point.y      -= 250;
        self.center   = point;
        
    } completion:^(BOOL finished) {
    }];
    
    [view addSubview:self];
}

- (void)dismiss {

    [UIView animateWithDuration:0.3 animations:^{
        
        CGPoint point = self.center;
        point.y      += 250;
        self.center   = point;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

// 返回选择器有几列.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

// 返回每组有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:
            return _shengArray.count;
            break;
            
        case 1:
            return _shiArr.count;
            break;
            
        case 2:
            return _xianArr.count;
            break;
            
        default:
            break;
    }
    return 0;
}

// 返回第component列第row行的内容（标题）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:
            return _shengArray[row][@"name"];
            break;
            
        case 1:
            return _shiArr[row][@"name"];
            break;
            
        case 2:
            return _xianArr[row][@"name"];
            break;
            
        default:
            break;
    }
    return nil;
}

// 设置row字体，颜色
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel            = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel                 = [[UILabel alloc] init];
        pickerLabel.textAlignment   = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font            = [UIFont systemFontOfSize:16.0];
    }
    
    pickerLabel.text                = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:{

            NSInteger index = [_shengArray[row][@"id"] integerValue];

            [_shiArr removeAllObjects];
            
            for (int i = 0; i < _shiArray.count; i++) {
                
                if ([_shiArray[i][@"parent_id"] integerValue] == index) {

                    [_shiArr addObject:_shiArray[i]];
                }
            }
            [_pickerView selectRow:0 inComponent:1 animated:NO];
            [_pickerView reloadComponent:1];
            
            index = [_shiArr[0][@"id"] integerValue];
            
            [_xianArr removeAllObjects];
            
            for (int i = 0; i < _xianArray.count; i++) {
                
                if ([_xianArray[i][@"parent_id"] integerValue] == index) {
                    
                    [_xianArr addObject:_xianArray[i]];
                }
            }
            [_pickerView selectRow:0 inComponent:2 animated:NO];
            [_pickerView reloadComponent:2];
        }
            break;
            
        case 1:{
            
            NSInteger index = [_shiArr[row][@"id"] integerValue];

            [_xianArr removeAllObjects];
            
            for (int i = 0; i < _xianArray.count; i++) {
                
                if ([_xianArray[i][@"parent_id"] integerValue] == index) {
                    
                    [_xianArr addObject:_xianArray[i]];
                }
            }
            [_pickerView selectRow:0 inComponent:2 animated:NO];
            [_pickerView reloadComponent:2];
        }
            break;
            
        default:
            break;
    }
    
    NSInteger shengRow = [_pickerView selectedRowInComponent:0];
    NSInteger shiRow   = [_pickerView selectedRowInComponent:1];
    NSInteger xianRow  = [_pickerView selectedRowInComponent:2];
    
    _addressLb.text = [NSString stringWithFormat:@"%@%@%@",_shengArray[shengRow][@"name"],
                       _shiArr.count > 0? _shiArr[shiRow][@"name"]:0,
                       _xianArr.count > 0? _xianArr[xianRow][@"name"]:0];
    ;
}

- (id)JsonObject:(NSString *)jsonStr {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData   = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject      = [NSJSONSerialization JSONObjectWithData:jsonData
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    return JsonObject;
}

- (UIView *)darkView {
    if (!_darkView) {
        _darkView                 = [[UIView alloc]init];
        _darkView.frame           = self.frame;
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha           = 0.3;
    }
    return _darkView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = _backView.bounds;
        _shapeLayer.path = _bezierPath.CGPath;
        _backView.layer.mask = _shapeLayer;
    }
    return _shapeLayer;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView                 = [[UIPickerView alloc]init];
        _pickerView.frame           = CGRectMake(0, 50, ScreenWidth, 200);
        _pickerView.delegate        = self;
        _pickerView.dataSource      = self;
        _pickerView.backgroundColor = MainBackColor;
    }
    return _pickerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 50, 50);
        UIColor *color = Color(65, 65, 65);
        [_cancelBtn setTitleColor:color forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)DetermineBtn {
    if (!_DetermineBtn) {
        _DetermineBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _DetermineBtn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
        [_DetermineBtn setTitle:@"确定" forState:UIControlStateNormal];
        UIColor *color = Color(0, 215, 200);
        [_DetermineBtn setTitleColor:color forState:UIControlStateNormal];
        [_DetermineBtn addTarget:self action:@selector(determineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DetermineBtn;
}

- (UILabel *)addressLb {
    if (!_addressLb) {
        _addressLb = [[UILabel alloc]init];
        _addressLb.frame = CGRectMake(50, 0, ScreenWidth - 100, 50);
        _addressLb.textAlignment = NSTextAlignmentCenter;
        _addressLb.font = [UIFont systemFontOfSize:16.0];
        _addressLb.textColor = Color(65, 65, 65);
    }
    return _addressLb;
}

- (void)determineBtnAction:(UIButton *)button {
    
    NSInteger shengRow = [_pickerView selectedRowInComponent:0];
    NSInteger shiRow   = [_pickerView selectedRowInComponent:1];
    NSInteger xianRow  = [_pickerView selectedRowInComponent:2];
    
    if (self.determineBtnBlock) {
        self.determineBtnBlock([_shengArray[shengRow][@"id"] integerValue],
                               _shiArr.count > 0?  [_shiArr[shiRow][@"id"] integerValue]:0,
                               _xianArr.count > 0? [_xianArr[xianRow][@"id"] integerValue]:0,
                               _shengArray[shengRow][@"name"],
                               _shiArr.count > 0?  _shiArr[shiRow][@"name"]:@"",
                               _xianArr.count > 0? _xianArr[xianRow][@"name"]:@"");
    }
    
    [self dismiss];
}

- (NSMutableArray *)shiArr {
    if (!_shiArr) {
        _shiArr  = [[NSMutableArray array]init];
    }
    return _shiArr;
}

- (NSMutableArray *)xianArr {
    if (!_xianArr) {
        _xianArr = [[NSMutableArray array]init];
    }
    return _xianArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
