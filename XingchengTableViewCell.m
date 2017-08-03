//
//  XingchengTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/2/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "XingchengTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"



@implementation XingchengTableViewCell {
    UIView *_bottomView;
    UIImageView *_imageView;
    UILabel *_carIdLable;
    UILabel *_yearLable;
    UILabel *_timeLable;
    UIButton *_receiveButton;
    UIButton *_refuseButton;
    
    
    UILabel *_whereLable;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self  customTables];
        
    }
    return self;
}
-(void)customTables {
    
    
    _bottomView = [UIView new];
    [self.contentView addSubview:_bottomView];
    _imageView = [UIImageView new];
    [_bottomView addSubview:_imageView];
    _carIdLable = [UILabel new];
    [_bottomView addSubview:_carIdLable];
    _yearLable = [UILabel new];
    [_bottomView addSubview:_yearLable];
    _timeLable = [UILabel new];
    [_bottomView addSubview:_timeLable];
    
    _receiveButton = [UIButton new];
    [self.contentView addSubview:_receiveButton];
    _refuseButton = [UIButton new];
    [self.contentView addSubview:_refuseButton];
    
    _stopWatch = [[WB_Stopwatch alloc] initWithLabel:_stopWatch andTimerType:WBTypeTimer];
    [self.contentView addSubview:_stopWatch];
    
    _whereLable = [UILabel new];
    [self.contentView addSubview:_whereLable];
    
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self reallCell];
}

-(void)reallCell {
    
  
    
    NSString *cartuString = [NSString stringWithFormat:@"%@%@",@"http://wx.leisurecarlease.com",_dict[@"cartu1"]];
    
    BOOL let =  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:cartuString]];
    
    if (let) {
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:cartuString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
    }else {
        
        _imageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
        
    }

    _stopWatch.textColor = Color(255, 70, 90);
    _stopWatch.textAlignment = NSTextAlignmentCenter;
    [_stopWatch setTimeFormat:@"mm:ss"];
    // ************************ 时间是后台获取的 ***********************************
    [_stopWatch setCountDownTime:900];
    [_stopWatch start];
    
    _carIdLable.text = [NSString stringWithFormat:@"%@",_dict[@"plate"]];
    _carIdLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _carIdLable.textAlignment = NSTextAlignmentCenter;
    _carIdLable.textColor = [UIColor whiteColor];
    
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil ];
//    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
//    
//    [calendar setTimeZone: timeZone];
//    
//    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
//    
//    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:currentDate];
//    
//    NSLog(@"%@",[weekdays objectAtIndex:theComponents.weekday]) ;
//    
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    _yearLable.text =[NSString stringWithFormat:@"%@",_dict[@"ntime"]];
    _yearLable.textColor = [UIColor whiteColor];
    _yearLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLable.text =  [NSString stringWithFormat:@"%@",_dict[@"ytime"]];
    _timeLable.textColor = [UIColor whiteColor];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    [_refuseButton setBackgroundImage:[UIImage imageNamed:@"拒.png"] forState:UIControlStateNormal];
    [_refuseButton addTarget:self action:@selector(refuseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_receiveButton addTarget:self action:@selector(receiveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_receiveButton setBackgroundImage:[UIImage imageNamed:@"接.png"] forState:UIControlStateNormal];
    
    _whereLable.text = _dict[@"address"];
    _whereLable.textAlignment = NSTextAlignmentRight;
    _whereLable.textColor = [UIColor whiteColor];
    _whereLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
}
- (void)receiveButtonClick:(UIButton *)sender{
    
    NSLog(@"接单啦++++++++++++");
}
- (void)refuseButtonClick:(UIButton *)sender{
    
    NSLog(@"拒单了------------");
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _bottomView.frame =CGRectMake(ScreenWidth*0.06, ScreenWidth*0.01, ScreenWidth*0.88, ScreenWidth*0.58);
    
    _imageView.frame = CGRectMake(0, 0, _bottomView.frame.size.width, _bottomView.frame.size.height);
    
    _carIdLable.frame = CGRectMake(ScreenWidth/2-ScreenWidth*0.26, ScreenWidth*0.18-ScreenWidth*0.04, ScreenWidth*0.4, ScreenWidth*0.08);
    
    _yearLable.frame = CGRectMake(ScreenWidth/2-ScreenWidth*0.26, ScreenWidth*0.28-ScreenWidth*0.04, ScreenWidth*0.4, ScreenWidth*0.08);
    
    _timeLable.frame = CGRectMake(ScreenWidth/2-ScreenWidth*0.36, CGRectGetMaxY(_yearLable.frame)+ScreenWidth*0.02, ScreenWidth*0.6, ScreenWidth*0.08);
    ;
    _refuseButton.frame = CGRectMake(ScreenWidth*0.1, ScreenWidth*0.05, ScreenWidth*0.1, ScreenWidth*0.1);
    _receiveButton.frame = CGRectMake(ScreenWidth*0.8, ScreenWidth*0.05, ScreenWidth*0.1, ScreenWidth*0.1);
    
    _stopWatch.frame = CGRectMake(ScreenWidth*0.8, CGRectGetMaxY(_receiveButton.frame)+ScreenWidth*0.02, ScreenWidth*0.1, ScreenWidth*0.06);
    _whereLable.frame = CGRectMake(ScreenWidth*0.06, ScreenWidth*0.5, ScreenWidth*0.88, ScreenWidth*0.08);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
