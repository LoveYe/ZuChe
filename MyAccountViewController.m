//
//  MyAccountViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/12.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "MyAccountViewController.h"
#import "Header.h"
#import "UILabel+SizeLabel.h"
#import "IncomeStatementViewController.h"
#import "WithdrawalsViewController.h"
#import "XWAlterview.h"
@interface MyAccountViewController ()
{
    NSTimer *_yesterdayIncomeLabelAnimationTimer;
    NSTimer *_totalMoneyAmountLabelAnimationTimer;
}
@property (nonatomic, assign) float yesterdayIncome;
@property (nonatomic,strong)UILabel *yesterdayIncomeLabel;
@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"我的帐户"];
    
    self.view.backgroundColor =Color(245, 245, 249);
    
    
    
    
    
    
    
    UIButton *tixian =[UIButton buttonWithType:UIButtonTypeSystem];
    tixian.frame =CGRectMake(ScreenWidth*0.03, ScreenWidth*0.9, ScreenWidth-ScreenWidth*0.06, ScreenWidth*0.125);
    tixian.backgroundColor =Color(0, 170, 238);
    tixian.layer.masksToBounds =YES;
    [self button:tixian isBold:YES isFont:14.0f];
    [tixian setTitle:@"提 现" forState:UIControlStateNormal];
    [tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tixian.layer.cornerRadius =6.0f;
    [tixian addTarget:self action:@selector(txianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tixian];
    
    
    
    UIButton *mingxi =[UIButton buttonWithType:UIButtonTypeSystem];
    mingxi.frame =CGRectMake(ScreenWidth*0.03, ScreenWidth+ScreenWidth*0.12, ScreenWidth-ScreenWidth*0.06, ScreenWidth*0.125);
    mingxi.backgroundColor =Color(245 , 245, 249);
    mingxi.layer.masksToBounds =YES;
    [self button:mingxi isBold:YES isFont:14.0f];
    [mingxi setTitle:@"收 支 明 细" forState:UIControlStateNormal];
    UIColor *blueColor=Color(0, 170, 238);
    [mingxi setTitleColor:blueColor forState:UIControlStateNormal];
    mingxi.layer.cornerRadius =6.0f;
    [mingxi.layer setBorderWidth:1];
    UIColor *color =Color(0, 170, 238);
    mingxi.layer.borderColor =color.CGColor;
    
    [mingxi addTarget:self action:@selector(mingxiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mingxi];
    
    
}
-(void)txianBtnClick
{
    WithdrawalsViewController *vc =[[WithdrawalsViewController alloc]init];
    [self.navigationController pushViewController:vc  animated:YES];
    
}
-(void)mingxiBtnClick
{
    IncomeStatementViewController *vc =[[IncomeStatementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES] ;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
//    NSUserDefaults *  jine =[NSUserDefaults standardUserDefaults];

    UIView * smallView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.75)];
    smallView.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:smallView];
    
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.75)];
    imageView.image =[UIImage imageNamed:@"账户背景.jpg"];
    [smallView addSubview:imageView];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.4/2, ScreenWidth*0.125, ScreenWidth*0.4, ScreenWidth*0.1)];
    //    label.backgroundColor =[UIColor redColor];
    label.textAlignment =NSTextAlignmentCenter;
    [self label:label isBold:YES isFont:15.0f];
    label.textColor =[UIColor whiteColor];
    label.text= @"可用租金";
    [smallView addSubview:label];
    
    
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenWidth*(0.125+0.1+0.04), ScreenWidth*0.8, ScreenWidth*0.2)];
    //    money.backgroundColor =[UIColor yellowColor];
    money.textColor =[UIColor whiteColor];
    money.adjustsFontSizeToFitWidth=YES;
    self.yesterdayIncomeLabel= money;
#pragma mark-可用租金在这个地方
    NSUserDefaults *  jines =[NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[jines objectForKey:@"jines"]);
    
    
    
    
    self.yesterdayIncome=[[jines objectForKey:@"jines"] floatValue];
    
    self.yesterdayIncomeLabel.text=@"0.00";
    money.textAlignment =NSTextAlignmentCenter;
    [self label:money  isBold:NO isFont:65.0f];
    if (money.text.length>6)
    {
        money.adjustsFontSizeToFitWidth =YES;
        money.frame=CGRectMake(ScreenWidth*0.1, ScreenWidth*(0.125+0.1+0.02), ScreenWidth*0.8, ScreenWidth*0.2);
    }
    [smallView addSubview:money];
    
    
    for (int i =0; i<2; i++)
    {
        UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/3*(i+1))-0.25,ScreenWidth*(0.75-0.2) , 0.5, ScreenWidth*0.115)];
        xian.backgroundColor =Color(225, 225, 225);
        [smallView addSubview:xian];
        
    }
    float fistWitdh =  ScreenWidth *0.333;
    
    float fistHeight =  ScreenWidth *0.125;
    
    
    
    UILabel *bzjin=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*(0.75-0.2), fistWitdh, fistHeight/2)];
    bzjin.text =@"保证金";
    bzjin.textColor =Color(234, 234, 234);
    bzjin.textAlignment =NSTextAlignmentCenter;
    [self label:bzjin isBold:NO isFont:14.0f];
    [smallView addSubview:bzjin];
    float bzWidth = [UILabel width:bzjin.text heightOfFatherView:bzjin.frame.size.height textFont:bzjin.font];
    bzjin.frame =CGRectMake(fistWitdh/2-(bzWidth+ScreenWidth*0.035)/2, ScreenWidth*(0.75-0.2-0.01), bzWidth, fistHeight/2);
    
    UIButton *wenhao =[UIButton buttonWithType:UIButtonTypeSystem];
    wenhao.frame =CGRectMake((fistWitdh/2-(bzWidth+ScreenWidth*0.035)/2)+1+bzWidth,ScreenWidth*(0.75-0.187-0.01) , ScreenWidth*0.035, ScreenWidth*0.035);
    [wenhao setBackgroundImage: [UIImage imageNamed:@"问好"] forState:UIControlStateNormal];
    [wenhao addTarget:self action:@selector(baozj) forControlEvents:UIControlEventTouchUpInside];
    //    wenhao.backgroundColor=[UIColor yellowColor];
    [smallView addSubview:wenhao];
    
    UILabel *djjin=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh+1, 0, fistWitdh, fistHeight/2)];
    djjin.text =@"冻结租金";
    djjin.textColor =Color(234 , 234, 234);
    djjin.textAlignment =NSTextAlignmentCenter;
    [self label:djjin isBold:NO isFont:14.0f];
    [smallView addSubview:djjin];
    float djWidth = [UILabel width:djjin.text heightOfFatherView:djjin.frame.size.height textFont:djjin.font];
    djjin.frame =CGRectMake(fistWitdh+1+ (fistWitdh/2-(djWidth+ScreenWidth*0.035)/2), ScreenWidth*(0.75-0.2-0.01), djWidth, fistHeight/2);
    
    UIButton *wenhao2 =[UIButton buttonWithType:UIButtonTypeSystem];
    wenhao2.frame =CGRectMake(fistWitdh+1+(fistWitdh/2-(djWidth+ScreenWidth*0.035)/2)+1+djWidth,ScreenWidth*(0.75-0.187-0.01) , ScreenWidth*0.035, ScreenWidth*0.035);
    [wenhao2 setBackgroundImage: [UIImage imageNamed:@"问好"] forState:UIControlStateNormal];
    [wenhao2 addTarget:self action:@selector(baozj2) forControlEvents:UIControlEventTouchUpInside];
    //    wenhao.backgroundColor=[UIColor yellowColor];
    [smallView addSubview:wenhao2];
    
    
    UILabel *leiji=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*2+2, ScreenWidth*(0.75-0.2-0.01), fistWitdh, fistHeight/2)];
    leiji.text =@"累计租金";
    leiji.textColor =Color(234, 234, 234);
    leiji.textAlignment =NSTextAlignmentCenter;
    [self label:leiji isBold:NO isFont:14.0f];
    [smallView addSubview:leiji];
    
    
    
    
    UILabel *jdLvs=[[UILabel alloc]initWithFrame:CGRectMake(0, fistHeight/2+ScreenWidth*(0.75-0.2), fistWitdh, fistHeight/2)];
    jdLvs.text =@"0";
    jdLvs.textColor =[UIColor whiteColor];
    jdLvs.textAlignment =NSTextAlignmentCenter;
    [self label:jdLvs isBold:NO isFont:17.0f];
    [smallView addSubview:jdLvs];
    
    
    UILabel *fuwus=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh+1, fistHeight/2+ScreenWidth*(0.75-0.2), fistWitdh, fistHeight/2)];
    fuwus.text =self.dongjiemoney;
    fuwus.textColor =[UIColor whiteColor];
    [self label:fuwus isBold:NO isFont:17.0f];
    fuwus.textAlignment =NSTextAlignmentCenter;
    [smallView addSubview:fuwus];
    
    
    UILabel *times=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*2+2, fistHeight/2+ScreenWidth*(0.75-0.2), fistWitdh, fistHeight/2)];
    times.text =self.dongjiemoney;
    times.textColor =[UIColor whiteColor];
    [self label:times isBold:NO isFont:17.0f];
    times.textAlignment =NSTextAlignmentCenter;
    [smallView addSubview:times];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setYesterdayIncome:(float)yesterdayIncome
{
    _yesterdayIncome = yesterdayIncome;
    
    [self setNumberTextOfLabel:self.yesterdayIncomeLabel WithAnimationForValueContent:yesterdayIncome];
}
- (void)setNumberTextOfLabel:(UILabel *)label WithAnimationForValueContent:(CGFloat)value
{
    CGFloat lastValue = [label.text floatValue];
    CGFloat delta = value - lastValue;
    if (delta == 0) return;
    
    if (delta > 0) {
        
        CGFloat ratio = value / 60.0;
        
        NSDictionary *userInfo = @{@"label" : label,
                                   @"value" : @(value),
                                   @"ratio" : @(ratio)
                                   };
        
        if (label.text.length>6)
        {
            label.adjustsFontSizeToFitWidth =YES;
        }
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(setupLabel:) userInfo:userInfo repeats:YES];
        if (label == self.yesterdayIncomeLabel) {
            _yesterdayIncomeLabelAnimationTimer = timer;
        } else {
            _totalMoneyAmountLabelAnimationTimer = timer;
        }
    }
}
- (void)setupLabel:(NSTimer *)timer
{
    NSDictionary *userInfo = timer.userInfo;
    UILabel *label = userInfo[@"label"];
    CGFloat value = [userInfo[@"value"] floatValue];
    CGFloat ratio = [userInfo[@"ratio"] floatValue];
    
    static int flag = 1;
    CGFloat lastValue = [label.text floatValue];
    CGFloat randomDelta = (arc4random_uniform(2) + 1) * ratio;
    CGFloat resValue = lastValue + randomDelta;
    
    if ((resValue >= value) || (flag == 50)) {
        label.text = [NSString stringWithFormat:@"%.2f", value];
        flag = 1;
        [timer invalidate];
        timer = nil;
        return;
    } else {
        
        label.text = [NSString stringWithFormat:@"%.2f", resValue];
    }
    flag++;
}
-(void)baozj
{
    [XWAlterview showmessage:@"提示" subtitle:@"这是保证金呦！" cancelbutton:@"确定"];
}
-(void)baozj2
{
    [XWAlterview showmessage:@"提示" subtitle:@"这是冻结租金呦！" cancelbutton:@"确定"];
}

@end
