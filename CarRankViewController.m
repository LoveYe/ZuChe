//
//  ViewController.m
//  CzdjPage
//
//  Created by MacBookXcZl on 2017/5/4.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "CarRankViewController.h"
#import "JHRadarChart.h"
#import "HttpManager.h"
#import "ZCUserData.h"
#import "UIImageView+WebCache.h"

@interface CarRankViewController () {
    
    NSInteger flag;
    UIScrollView *_scrollerView;
    NSMutableDictionary *_dict;
}

@end

@implementation CarRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车主资料";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    flag = 0;
    
    _dict = [NSMutableDictionary new];
    
    UIButton *goback = [UIButton buttonWithType:UIButtonTypeCustom];
    goback.frame = CGRectMake(0, 0, 25, 25);
    [goback setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [goback addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:goback];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
   
    [self initData];
}

-(void)initData {
    
    [HttpManager postData:@{@"userid":[ZCUserData share].userId} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=chezhu_center" success:^(NSDictionary *fanhuicanshu) {
      
        [_dict addEntriesFromDictionary:fanhuicanshu];
        
        [self creatViews];
        
        _scrollerView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.width*0.72+self.view.frame.size.width*2/3+200);
        
        } Error:^(NSString *cuowuxingxi) {
        
            
    }];
}

- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatViews {
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    _scrollerView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:_scrollerView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.width*2/3)];
    if ([_dict[@"thumb"] isKindOfClass:[NSNull class]]) {
        
    }else {
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dict[@"thumb"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    
    [_scrollerView addSubview:image];
    
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, (self.view.frame.size.width*2/3-200)/2,200, 200)];
    //image1.backgroundColor  =[UIColor redColor];
    image1.image = [UIImage imageNamed:@"六边形(1).png"];
    
    [image addSubview:image1];
    
    JHRadarChart *radarChart = [[JHRadarChart alloc] initWithFrame:CGRectMake(0, 0,197 , 200 )];
    // radarChart.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    /*       Each point of the description text, according to the number of the array to determine the number of basic modules         */
    radarChart.valueDescArray = @[@"接单率",@"好评率",@"事故率",@"取消率",@"迟到率",@"到达时间"];
    
    /*         Number of basic module layers        */
    radarChart.layerCount = 5;
    
    /*        Array of data sources, the need to add an array of arrays         */
    radarChart.valueDataArray = @[@[@"100",@"100",@"100",@"100",@"100",@"100"]];
    
    /*        Color of each basic module layer         */
    radarChart.layerFillColor = [UIColor colorWithRed:0/ 256.0 green:0/256.0 blue:0/ 256.0 alpha:0.5];
    
    /*        The fill color of the value module is required to specify the color for each value module         */
    radarChart.valueDrawFillColorArray = @[[UIColor colorWithRed:7/256.0 green:187/256.0 blue:177/256.0 alpha:0.5]];
    
    /*       show        */
    [radarChart showAnimation];
    
    [image1 addSubview:radarChart];
    
    
    
    CGFloat width = self.view.frame.size.width ;
    // CGFloat height = self.view.frame.size.height;
    UIImageView *leftIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.08,  self.view.frame.size.width*2/3 + width*0.05, width*0.2, width*0.2)];
    if ([_dict[@"thumb"] isKindOfClass:[NSNull class]]) {
        
    }else {
        [leftIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dict[@"thumb"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }

    leftIconImageView.backgroundColor = [UIColor purpleColor];
    leftIconImageView.layer.cornerRadius = 0.1 * width;
    leftIconImageView.layer.masksToBounds = YES;
    [_scrollerView addSubview:leftIconImageView];
    
    UIImageView *rightIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width-width*0.27,  self.view.frame.size.width*2/3 + width*0.05, width*0.2, width*0.2)];
    if ([_dict[@"dengji"] isEqualToString:@"V1"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V1.png"];
    }else if ([_dict[@"dengji"] isEqualToString:@"V2"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V2.png"];
    }else if ([_dict[@"dengji"] isEqualToString:@"V3"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V3.png"];
    }else if ([_dict[@"dengji"] isEqualToString:@"V4"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V4.png"];
    }else if ([_dict[@"dengji"] isEqualToString:@"V5"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V5.png"];
    }else if ([_dict[@"dengji"] isEqualToString:@"V6"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V6.png"];
    }else if ([_dict[@"dengji"] isEqualToString:@"V7"]) {
        rightIconImageView.image = [UIImage imageNamed:@"V7.png"];
    }
    //rightIconImageView.backgroundColor = [UIColor purpleColor];
    // rightIconImageView.layer.cornerRadius = 0.125 * width;
    rightIconImageView.layer.masksToBounds = YES;
    [_scrollerView addSubview:rightIconImageView];
    
    UILabel *zhuceLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.08, CGRectGetMaxY(leftIconImageView.frame)+width*0.03, width, width*0.1)];
    
    zhuceLabel.font = [UIFont fontWithName:@"Arial-boldMT" size:18];
    
    zhuceLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0  blue:157/255.0  alpha:1];
    zhuceLabel.text = [NSString stringWithFormat:@"%@  %@",@"注册时间:",_dict[@"regdate"]];
    
    [_scrollerView addSubview:zhuceLabel];
    
    NSString *str1 = @"综合评定:  订单发生时您将收到";
    
    long len1 = [str1 length];
    
    NSString *nameStr = @"100%";
    
    NSString *str = [NSString stringWithFormat:@"综合评定:  订单发生时您将收到%@的订单",nameStr];
    
    long len2 = [nameStr length];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:157/255.0 green:157/255.0  blue:157/255.0  alpha:1] range:NSMakeRange(0,str2.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15] range:NSMakeRange(0,str2.length)];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:97/255.0  blue:57/255.0  alpha:1] range:NSMakeRange(len1,len2)];
    
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15] range:NSMakeRange(len1,len2)];
    
    UILabel *pingdingLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.08, CGRectGetMaxY(zhuceLabel.frame), width*0.84, width*0.1)];
    
    pingdingLabel.attributedText = str2;
    
    pingdingLabel.adjustsFontSizeToFitWidth = YES;
    
    [_scrollerView addSubview:pingdingLabel];
    
    NSString *jiedanlv;
    NSString *haopinglv;
    NSString *tiqiandaoda;
    NSString *chidaolv;
    NSString *quxiaolv;
    NSString *shigulv;
    
    if ([_dict[@"jiedanlv"] isKindOfClass:[NSNull class]]) {
        jiedanlv = @"100%";
    }else {
       jiedanlv = _dict[@"jiedanlv"];
    }
    if ([_dict[@"haopinglv"] isKindOfClass:[NSNull class]]) {
        haopinglv = @"100%";
    }else {
        haopinglv = _dict[@"haopinglv"];
    }
    if ([_dict[@"tiqiandaoda"] isKindOfClass:[NSNull class]]) {
        tiqiandaoda = @"30";
    }else {
        tiqiandaoda = _dict[@"tiqiandaoda"];
    }
    if ([_dict[@"chidaolv"] isKindOfClass:[NSNull class]]) {
        chidaolv = @"0%";
    }else {
        chidaolv = _dict[@"chidaolv"];
    }
    if ([_dict[@"quexiaolv"] isKindOfClass:[NSNull class]]) {
        quxiaolv = @"0%";
    }else {
        quxiaolv = _dict[@"quexiaolv"];
    }
    if ([_dict[@"shigulv"] isKindOfClass:[NSNull class]]) {
        shigulv = @"0%";
    }else {
        shigulv = _dict[@"shigulv"];
    }
    
    NSArray *array = @[@"接单率",@"好评率",@"平均提前到达时间",jiedanlv,haopinglv,tiqiandaoda
                       ,@"迟到率",@"取消率",@"事故率",chidaolv,quxiaolv,shigulv];
    
    for (int i = 0; i < 12; i++) {
        
        if (i/3 == 0) {
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05 , CGRectGetMaxY(pingdingLabel.frame), width*0.9, 2)];
            
            line.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0  blue:237/255.0  alpha:1];
            
            [_scrollerView addSubview:line];
            
            UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(width*0.08 +i%3*width*0.1+i%3*0.15*width, CGRectGetMaxY(line.frame)+width*0.02, width*0.2, width*0.1)];
            
            ping.text = [NSString stringWithFormat:@"%@",array[i]];
            
            ping.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0  blue:157/255.0  alpha:1];
            
            ping.font = [UIFont fontWithName:@"Arial-boldMT" size:14];
            
            if (i == 2 ) {
                ping.frame = CGRectMake(width*0.08 +i%3*width*0.1+i%3*0.15*width, CGRectGetMaxY(line.frame)+width*0.02, width*0.6, width*0.1);
            }
            
            [_scrollerView addSubview:ping];
            
        }
        if (i/3 == 1) {
            
            UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(width*0.08 +i%3*width*0.1+i%3*0.15*width, CGRectGetMaxY(pingdingLabel.frame)+width*0.08, width*0.2, width*0.1)];
            
            ping.text = [NSString stringWithFormat:@"%@",array[i]];
            
            ping.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0  blue:157/255.0  alpha:1];
            
            ping.font = [UIFont fontWithName:@"Arial-boldMT" size:16.5];
            
            if (i == 5 ) {
                ping.frame = CGRectMake(width*0.08 +i%3*width*0.1+i%3*0.15*width, CGRectGetMaxY(pingdingLabel.frame)+width*0.08, width*0.6, width*0.1);
            }
            
            [_scrollerView addSubview:ping];
            
        }
        if (i/3 == 2) {
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05 , CGRectGetMaxY(pingdingLabel.frame)+width*0.18, width*0.9, 2)];
            
            line.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0  blue:237/255.0  alpha:1];
            
            [_scrollerView addSubview:line];
            
            UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(width*0.08 +i%3*width*0.1+i%3*0.15*width, CGRectGetMaxY(line.frame)+width*0.02, width*0.2, width*0.1)];
            
            ping.text = [NSString stringWithFormat:@"%@",array[i]];
            
            ping.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0  blue:157/255.0  alpha:1];
            
            ping.font = [UIFont fontWithName:@"Arial-boldMT" size:14];
            
            [_scrollerView addSubview:ping];
            
        }
        if (i/3 == 3) {
            
            UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(width*0.08 +i%3*width*0.1+i%3*0.15*width, CGRectGetMaxY(pingdingLabel.frame)+width*0.26, width*0.2, width*0.1)];
            
            ping.text = [NSString stringWithFormat:@"%@",array[i]];
            
            ping.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0  blue:157/255.0  alpha:1];
            
            ping.font = [UIFont fontWithName:@"Arial-boldMT" size:16.65];
            
            [_scrollerView addSubview:ping];
            
        }
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05 , CGRectGetMaxY(pingdingLabel.frame)+width*0.38, width*0.9, 2)];
    
    line.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0  blue:237/255.0  alpha:1];
    
    [_scrollerView addSubview:line];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.4 , CGRectGetMaxY(line.frame)+width*0.05, width*0.15, width*0.15)];
    
    bottomImageView.image = [UIImage imageNamed:@"logo浅.png"];
    
    bottomImageView.alpha = 0.5;
    
    [_scrollerView addSubview:bottomImageView];
    
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
