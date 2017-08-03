//
//  ShaiXuanView.m
//  ZuChe
//
//  Created by apple  on 2017/6/22.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ShaiXuanView.h"
#import "Header.h"
#import "CarInfoView.h"
#import "CCDatePickerView.h"

@interface ShaiXuanView (){
    
    CGFloat width;
    
    UIButton *di;
    UIButton *duo;
    UIButton *gao;
    
    UIButton *xuanze ;
    UISwitch *kaiguan;
}

@end

@implementation ShaiXuanView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color(237, 237, 237);
    width = self.view.frame.size.width;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIButton *reset = [UIButton buttonWithType:UIButtonTypeCustom];
    reset.frame = CGRectMake(0, 0, 40, 40);
    [reset setTitle:@"重置" forState:UIControlStateNormal];
//    reset.backgroundColor = [UIColor redColor];
    UIColor *color = Color(7, 187, 177);
    [reset setTitleColor:color forState:UIControlStateNormal];
    [reset addTarget:self action:@selector(resetAll) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:reset];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*0.4, 44)];
    title.text = [NSString stringWithFormat:@"%@",self.titleText];
    title.textColor = Color(77, 77, 77);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    title.adjustsFontSizeToFitWidth = YES;
    
    self.navigationItem.titleView = title;
    
    [self createView];
}
- (void)fanhui{
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendtime:auto:duoshao:)]) {
        
        [_delegate sendtime:self.bukezutime auto:self.jiedan duoshao:self.state];
        
        CarInfoView *view = [[CarInfoView alloc] init];
        
        view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
- (void)createView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height)];
    scrollView.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(0, width*2.4);
    
    // 日历
    UILabel *choiceTime = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05 ,width*0.05, width*0.9, width*0.08)];
    choiceTime.text = @"选择日期";
    choiceTime.textColor = Color(127, 127, 127);
    choiceTime.textAlignment = NSTextAlignmentCenter;
    choiceTime.font = [UIFont fontWithName:@"ArialMT" size:17];
    [scrollView addSubview:choiceTime];
    
    UIView *rili = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(choiceTime.frame)+width*0.03, width*0.9, width*0.12)];
    rili.backgroundColor = [UIColor whiteColor];
    rili.userInteractionEnabled = YES;
    [scrollView addSubview:rili];
    
    xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanze.frame = CGRectMake(rili.frame.size.width*0.05, width*0.01, rili.frame.size.width*0.9, width*0.1);
    if ([self.bukezutime  isKindOfClass:[NSNull class]] || self.bukezutime == nil || [self.bukezutime isEqualToString:@""]) {
        
        [xuanze setTitle:@"请点击选择" forState:UIControlStateNormal];
    }else{
        
        [xuanze setTitle:self.bukezutime forState:UIControlStateNormal];
    }
    
    UIColor *color = Color(127, 127, 127);
    [xuanze setTitleColor:color forState:UIControlStateNormal];
    [rili addSubview:xuanze];
    [xuanze addTarget:self action:@selector(chooseTimeClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *jishi = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rili.frame)+width*0.05, width, width*0.08)];
    jishi.text = @"即时预定";
    jishi.textColor = Color(107, 107, 107);
    jishi.textAlignment = NSTextAlignmentCenter;
    jishi.font = [UIFont fontWithName:@"ArialMT" size:18];
    jishi.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:jishi];
    
    // 即时预定
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(jishi.frame)+width*0.05, width*0.9, width*0.5)];
    view1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view1];
    
    UIImageView *shandian = [[UIImageView alloc] initWithFrame:CGRectMake(view1.frame.size.width*0.425, view1.frame.size.width*0.05, view1.frame.size.width*0.15, view1.frame.size.width*0.15)];
    shandian.image = [UIImage imageNamed:@"闪电.png"];
    [view1 addSubview:shandian];
    
    UILabel *xuyao = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width*0.05, CGRectGetMaxY(shandian.frame), view1.frame.size.width*0.9, view1.frame.size.width*0.1)];
    xuyao.text = @"需要很快找到合适车辆吗?";
    xuyao.textColor = Color(77, 77, 77);
    xuyao.textAlignment = NSTextAlignmentCenter;
    xuyao.font = [UIFont fontWithName:@"ArialMT" size:17];
    xuyao.adjustsFontSizeToFitWidth = YES;
    [view1 addSubview:xuyao];
    
    UILabel *yuding = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width*0.05, CGRectGetMaxY(xuyao.frame), view1.frame.size.width*0.9, view1.frame.size.width*0.1)];
    yuding.text = @"即时预定功能让您不用发送申请就能预定车源";
    yuding.textColor = Color(127, 127, 127);
    yuding.textAlignment = NSTextAlignmentCenter;
    yuding.font = [UIFont fontWithName:@"ArialMT" size:17];
    yuding.adjustsFontSizeToFitWidth = YES;
    [view1 addSubview:yuding];
    
    UILabel *xianshi = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width*0.05, CGRectGetMaxY(yuding.frame)+view1.frame.size.width*0.02, view1.frame.size.width*0.6, view1.frame.size.width*0.1)];
    xianshi.text = @"只限即时预定";
    xianshi.textColor = Color(77, 77, 77);
    xianshi.textAlignment = NSTextAlignmentLeft;
    xianshi.font = [UIFont fontWithName:@"ArialMT" size:17];
    xianshi.adjustsFontSizeToFitWidth = YES;
    [view1 addSubview:xianshi];
    
    kaiguan = [[UISwitch alloc] initWithFrame:CGRectMake(view1.frame.size.width*0.8, CGRectGetMaxY(yuding.frame)+view1.frame.size.width*0.02, 0, 0)];
    if ([self.jiedan isKindOfClass:[NSNull class]]) {
        
        [kaiguan setOn:NO];
        kaiguan.selected = NO;
        
    }else{
        
        int a = [self.jiedan intValue];
        
        [kaiguan setOn:a];
        kaiguan.selected = a;
    }
    
    [kaiguan addTarget:self action:@selector(kaiguanAutolist:) forControlEvents:UIControlEventValueChanged];
    [view1 addSubview:kaiguan];
    
    UILabel *paixu = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame)+width*0.05, width, width*0.08)];
    paixu.text = @"排列顺序";
    paixu.textColor = Color(107, 107, 107);
    paixu.textAlignment = NSTextAlignmentCenter;
    paixu.font = [UIFont fontWithName:@"ArialMT" size:18];
    paixu.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:paixu];
    
    // 排序
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(paixu.frame)+width*0.05, width*0.9, width*0.6)];
    view2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view2];
    
    UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, width*0.05, view2.frame.size.width*0.6, width*0.1)];
    jiage.text = @"价格最低";
    jiage.textColor = Color(107, 107, 107);
    jiage.textAlignment = NSTextAlignmentLeft;
    jiage.font = [UIFont fontWithName:@"ArialMT" size:17];
    jiage.adjustsFontSizeToFitWidth = YES;
    [view2 addSubview:jiage];
    
    di = [UIButton buttonWithType:UIButtonTypeCustom];
    di.frame = CGRectMake(view2.frame.size.width*0.85, width*0.05, width*0.1, width*0.1);
    
    if ([self.state isKindOfClass:[NSNull class]] || ![self.state isEqualToString:@"1"]) {
        
//        di.backgroundColor = [UIColor redColor];
        [di setBackgroundImage:[UIImage imageNamed:@"价格筛选.png"] forState:UIControlStateNormal];
    }else{
        
        [di setBackgroundImage:[UIImage imageNamed:@"价格.png"] forState:UIControlStateNormal];
    }
    
    [view2 addSubview:di];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(jiage.frame)+width*0.05, view2.frame.size.width*0.9, 1)];
    line1.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:line1];
    
    UIView *viewClick1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height/3)];
    viewClick1.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapgester1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Click)];
    [viewClick1 addGestureRecognizer:tapgester1];
    [view2 addSubview:viewClick1];
    
    UILabel *fuwu = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(line1.frame)+width*0.05, view2.frame.size.width*0.9, width*0.1)];
    fuwu.text = @"服务最多";
    fuwu.textColor = Color(107, 107, 107);
    fuwu.textAlignment = NSTextAlignmentLeft;
    fuwu.font = [UIFont fontWithName:@"ArialMT" size:17];
    fuwu.adjustsFontSizeToFitWidth = YES;
    [view2 addSubview:fuwu];
    
    duo = [UIButton buttonWithType:UIButtonTypeCustom];
    duo.frame = CGRectMake(view2.frame.size.width*0.85, CGRectGetMaxY(line1.frame)+width*0.05, width*0.1, width*0.1);
    if ([self.state isKindOfClass:[NSNull class]] || ![self.state isEqualToString:@"2"]) {
        
        [duo setBackgroundImage:[UIImage imageNamed:@"服务筛选.png"] forState:UIControlStateNormal];
    }else{
        
        [duo setBackgroundImage:[UIImage imageNamed:@"服务.png"] forState:UIControlStateNormal];
    }
//    duo.backgroundColor = [UIColor redColor];
    [view2 addSubview:duo];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(fuwu.frame)+width*0.05, view2.frame.size.width*0.9, 1)];
    line2.backgroundColor = Color(237, 237, 237);
    [view2 addSubview:line2];
    
    UIView *viewClick2 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.size.height/3, view2.frame.size.width, view2.frame.size.height/3)];
    viewClick2.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapgester2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Click)];
    [viewClick2 addGestureRecognizer:tapgester2];
    [view2 addSubview:viewClick2];
    
    UILabel *pingjia = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(line2.frame)+width*0.05, view2.frame.size.width*0.9, width*0.1)];
    pingjia.text = @"评价最高";
    pingjia.textColor = Color(107, 107, 107);
    pingjia.textAlignment = NSTextAlignmentLeft;
    pingjia.font = [UIFont fontWithName:@"ArialMT" size:17];
    pingjia.adjustsFontSizeToFitWidth = YES;
    [view2 addSubview:pingjia];
    
    gao = [UIButton buttonWithType:UIButtonTypeCustom];
    gao.frame = CGRectMake(view2.frame.size.width*0.85, CGRectGetMaxY(line2.frame)+width*0.05, width*0.1, width*0.1);
    if ([self.state isKindOfClass:[NSNull class]] || ![self.state isEqualToString:@"3"]) {
        
        [gao setBackgroundImage:[UIImage imageNamed:@"评价筛选.png"] forState:UIControlStateNormal];
    }else{
        
        [gao setBackgroundImage:[UIImage imageNamed:@"评价.png"] forState:UIControlStateNormal];
    }
    
    [view2 addSubview:gao];
    
    UIView *viewClick3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.size.height/3*2, view2.frame.size.width, view2.frame.size.height/3)];
    viewClick3.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapgester3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Click)];
    [viewClick3 addGestureRecognizer:tapgester3];
    [view2 addSubview:viewClick3];
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.425, CGRectGetMaxY(view2.frame)+width*0.1, width*0.15, width*0.15)];
    logo.image = [UIImage imageNamed:@"logo浅.png"];
    [scrollView addSubview:logo];
    
    // 搜索按钮
    UIButton *sousuo = [UIButton buttonWithType:UIButtonTypeCustom];
    sousuo.frame = CGRectMake(width*0.2, CGRectGetMaxY(logo.frame)+width*0.1, width*0.6, width*0.1);
    [sousuo setTitle:@"搜索" forState:UIControlStateNormal];
    [sousuo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIColor *itemColor = Color(7, 187, 177);
    sousuo.backgroundColor = itemColor;
    [scrollView addSubview:sousuo];
    [sousuo addTarget:self action:@selector(sousuoClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 选择价格、服务还是 评价
- (void)tap1Click{
    
    [di setBackgroundImage:[UIImage imageNamed:@"价格.png"] forState:UIControlStateNormal];
    di.selected = YES;
    [duo setBackgroundImage:[UIImage imageNamed:@"服务筛选.png"] forState:UIControlStateNormal];
    duo.selected = NO;
    [gao setBackgroundImage:[UIImage imageNamed:@"评价筛选.png"] forState:UIControlStateNormal];
    gao.selected = NO;
    
    self.state = @"1";
}
- (void)tap2Click{
    
    [di setBackgroundImage:[UIImage imageNamed:@"价格筛选.png"] forState:UIControlStateNormal];
    di.selected = NO;
    [duo setBackgroundImage:[UIImage imageNamed:@"服务.png"] forState:UIControlStateNormal];
    duo.selected = YES;
    [gao setBackgroundImage:[UIImage imageNamed:@"评价筛选.png"] forState:UIControlStateNormal];
    gao.selected = NO;
    
    self.state = @"2";
}
- (void)tap3Click{
    
    [di setBackgroundImage:[UIImage imageNamed:@"价格筛选.png"] forState:UIControlStateNormal];
    di.selected = NO;
    [duo setBackgroundImage:[UIImage imageNamed:@"服务筛选.png"] forState:UIControlStateNormal];
    duo.selected = NO;
    [gao setBackgroundImage:[UIImage imageNamed:@"评价.png"] forState:UIControlStateNormal];
    gao.selected = YES;
    
    self.state = @"3";
}
#pragma mark - 是否自动接单
- (void)kaiguanAutolist:(UISwitch *)sender{
    
    if (sender.selected == NO) {
        
        self.jiedan = @"1";
        sender.selected = YES;
        [sender setOn:YES];
    }else if(sender.selected == YES){
        
        sender.selected = NO;
        [sender setOn:NO];
        self.jiedan = @"0";
    }
}
#pragma mark - 搜索按钮点击
- (void)sousuoClick{
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendtime:auto:duoshao:)]) {
        
        [_delegate sendtime:self.bukezutime auto:self.jiedan duoshao:self.state];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)chooseTimeClick{
    
    CCDatePickerView *dateView = [[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view.window addSubview:dateView];
    
    dateView.blcok = ^(NSDate *dateString){
        
        NSLog(@"年 = %ld  月 = %.2ld  日 = %.2ld  时 = %.2ld  分 = %.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        
        NSString *str = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)dateString.year,(long)dateString.month,(long)dateString.day];
        
        NSString *datestr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        [xuanze setTitle:datestr forState:UIControlStateNormal];
        UIColor *color = Color(77, 77, 77);
        [xuanze setTitleColor:color forState:UIControlStateNormal];
        self.bukezutime = str;
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
}
#pragma mark - 重置
- (void)resetAll{
    
    [di setBackgroundImage:[UIImage imageNamed:@"价格筛选.png"] forState:UIControlStateNormal];
    di.selected = NO;
    [duo setBackgroundImage:[UIImage imageNamed:@"服务筛选.png"] forState:UIControlStateNormal];
    duo.selected = NO;
    [gao setBackgroundImage:[UIImage imageNamed:@"评价筛选.png"] forState:UIControlStateNormal];
    gao.selected = NO;
    
    [xuanze setTitle:@"请点击设置" forState:UIControlStateNormal];
    
    [kaiguan setOn:NO];
    kaiguan.selected = NO;
    
    self.jiedan = @"";
    self.bukezutime = @"";
    self.state = @"";
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
