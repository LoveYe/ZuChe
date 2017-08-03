//
//  CZCountDownView.m
//  countDownDemo
//
//  Created by 孔凡列 on 15/12/9.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import "CZCountDownViewJia.h"
// label数量
#define labelCount 4
#define separateLabelCount 3
#define padding 5
@interface CZCountDownViewJia (){
    // 定时器
   
}
@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// day
@property (nonatomic,strong)UILabel *dayLabel;
// hour
@property (nonatomic,strong)UILabel *hourLabel;
// minues
@property (nonatomic,strong)UILabel *minuesLabel;
// seconds
@property (nonatomic,strong)UILabel *secondsLabel;
@end

@implementation CZCountDownViewJia
// 创建单例
+ (instancetype)shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CZCountDownViewJia alloc] init];
    });
    return instance;
}

+ (instancetype)countDown{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        

        [self addSubview:self.dayLabel];
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < separateLabelCount; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @":";
            separateLabel.textColor = [UIColor redColor];
            separateLabel.textAlignment = NSTextAlignmentCenter;
            separateLabel.backgroundColor = [UIColor whiteColor];
            [self addSubview:separateLabel];
            [self.separateLabelArrM addObject:separateLabel];
        }
    }
    return self;
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    _backgroundImageName = backgroundImageName;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
//    [self bringSubviewToFront:imageView];
}

// 拿到外界传来的时间戳
- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    if (_timestamp != 0) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
}

-(void)timer:(NSTimer*)timerr{
    _timestamp++;
    [self getDetailTimeWithTimestamp:_timestamp];
    if (_timestamp == 0) {
        [_timer invalidate];
        _timer = nil;
        // 执行block回调
        self.timerStopBlock();
    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
//    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    if (day < 10) {
        self.dayLabel.text = [NSString stringWithFormat:@"0%zd",day];
    }else {
         self.dayLabel.text = [NSString stringWithFormat:@"%zd",day];
    }
   
    if (hour < 10) {
        self.hourLabel.text = [NSString stringWithFormat:@"0%zd",hour];
    }else {
        self.hourLabel.text = [NSString stringWithFormat:@"%zd",hour];

    }
    if (minute < 10) {
        self.minuesLabel.text = [NSString stringWithFormat:@"0%zd",minute];
        
    }else {
        self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    }
    if (second < 10) {
        self.secondsLabel.text = [NSString stringWithFormat:@"0%zd",second];
    }else {
        self.secondsLabel.text = [NSString stringWithFormat:@"%zd",second];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 获得view的宽、高
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    // 单个label的宽高
    CGFloat labelW = viewW / labelCount;
    CGFloat labelH = viewH;
    self.dayLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.hourLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    self.minuesLabel.frame = CGRectMake(2 * labelW , 0, labelW, labelH);
    self.secondsLabel.frame = CGRectMake(3 * labelW, 0, labelW, labelH);
    
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        if (index!= 0) {
            UILabel *separateLabel = self.separateLabelArrM[index];
            separateLabel.frame = CGRectMake((labelW - 1) * (index + 1), 0, 5, labelH);
            separateLabel.font = [UIFont systemFontOfSize:15];
        }

    }
    
    self.dayLabel.backgroundColor = [UIColor whiteColor];
    self.hourLabel.backgroundColor = [UIColor whiteColor];
    self.minuesLabel.backgroundColor = [UIColor whiteColor];
    self.secondsLabel.backgroundColor = [UIColor whiteColor];
    
  //  self.dayLabel.font = [UIFont systemFontOfSize:5];
    self.hourLabel.font = [UIFont systemFontOfSize:15];
    self.minuesLabel.font = [UIFont systemFontOfSize:15];
    self.secondsLabel.font = [UIFont systemFontOfSize:15];
    
   // self.dayLabel.textColor = [UIColor redColor];

    self.hourLabel.textColor = [UIColor redColor];
    self.minuesLabel.textColor = [UIColor redColor];
    self.secondsLabel.textColor = [UIColor redColor];
    
    
}


#pragma mark - setter & getter

- (NSMutableArray *)timeLabelArrM{
    if (_timeLabelArrM == nil) {
        _timeLabelArrM = [[NSMutableArray alloc] init];
    }
    return _timeLabelArrM;
}

- (NSMutableArray *)separateLabelArrM{
    if (_separateLabelArrM == nil) {
        _separateLabelArrM = [[NSMutableArray alloc] init];
    }
    return _separateLabelArrM;
}

- (UILabel *)dayLabel{
    if (_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
//        _dayLabel.backgroundColor = [UIColor grayColor];
    }
    return _dayLabel;
}

- (UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
//        _hourLabel.backgroundColor = [UIColor redColor];
    }
    return _hourLabel;
}

- (UILabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[UILabel alloc] init];
        _minuesLabel.textAlignment = NSTextAlignmentCenter;
//        _minuesLabel.backgroundColor = [UIColor orangeColor];
    }
    return _minuesLabel;
}

- (UILabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[UILabel alloc] init];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
//        _secondsLabel.backgroundColor = [UIColor yellowColor];
    }
    return _secondsLabel;
}


@end