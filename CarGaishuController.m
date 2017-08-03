//
//  CarGaishuController.m
//  ZuChe
//
//  Created by apple  on 16/11/22.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "CarGaishuController.h"
#import "AFHTTPRequestOperationManager.h"
#import "HttpManager.h"
#import "AllPages.pch"
#import "AddYourCars.h"
#import "Header.h"

#define MY_MAX 600
#define Height(H) (H)/320.0*ScreenWidth
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width

@interface CarGaishuController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UILabel *label;
    UILabel *label2;
    NSTimer *myTimer;
    NSInteger number;
    UILabel *residuetext;
    NSString *text_text;
    
    UIView *_alertView1;
    UIView *bigView1;
    UIButton *queding1;
}
@property (nonatomic,retain)  UITextView *textView;
@property (nonatomic,retain) AFHTTPRequestOperationManager *manager;

@end

@implementation CarGaishuController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;
    
    [_textView resignFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
    [_textView resignFirstResponder];
    
    [IQKeyboardManager sharedManager].enable = YES;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self fankui];
    
//    self.navigationController.navigationBar.backgroundColor = Color(255, 255, 255);
    self.title = @"车辆描述";
    UIColor *col = Color(100, 100, 100);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    text_text=[[NSString alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9  blue:0.9  alpha:1.0];
}

- (void)fankui{
    
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _textView.text = self.gaishu;
    
    NSLog(@"%@",self.gaishu);
    _textView.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _textView.textColor = Color(73, 73, 73);
    _textView.backgroundColor= Color(240, 240, 240);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_textView becomeFirstResponder];
    _textView.scrollEnabled= YES;
    [_textView setDelegate:self];
    
    _textView.layer.masksToBounds =YES;
    _textView.layer.cornerRadius =6.0f;
    [self.view addSubview:_textView];
    
    // 下边placeholder的内容
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, -10, ScreenWidth-Height(20), ScreenWidth/6)];
    label.enabled = NO;
    label.text = @"请描述您的车辆...";
    label.numberOfLines =0;
    label.font = [UIFont systemFontOfSize:15];
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, ScreenWidth/6-10-ScreenWidth*0.1, ScreenWidth, ScreenWidth/6)];
    label2.text = @"我们为您准备了快速标签，以方便您叙述...";
    label2.numberOfLines = 0;
    label2.enabled = NO;
    label2.font = [UIFont systemFontOfSize:15];
    label2.adjustsFontSizeToFitWidth = YES;
    label2.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    
    //计算还有多少字
    residuetext=[[UILabel alloc]initWithFrame:CGRectMake(10, ScreenWidth*0.75-Height(70)+64*2-100, _textView.frame.size.width/3, Height(16))];
    [residuetext setTextAlignment:NSTextAlignmentLeft];
    residuetext.font = [UIFont systemFontOfSize:13];
    residuetext.adjustsFontSizeToFitWidth = YES;
    residuetext.textColor = Color(81, 81, 81);
    [self.view addSubview:residuetext];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.75-Height(70)+64*2-100+Height(16), ScreenWidth, ScreenWidth*1.2)];
    [self.view addSubview:view];
    
    NSArray *array = @[@"我的车外观光彩夺目",@"我的车内饰焕然一新",@"我能微笑的为你服务",@"我堪称城市的活地图",@"我驾驶车辆得心应手",@"我的车里从不会吸烟",@"我会理出整个后备箱",@"我承诺绝不索要红包",@"我能提前10分钟到达,绝不迟到！"];
    for (int i = 0; i < 9; i++) {
        
        if (i%2 != 0) {
            
            UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
            left.frame = CGRectMake(ScreenWidth*0.025, ScreenWidth*0.06+i/2*ScreenWidth*0.16, ScreenWidth*0.45, ScreenWidth*0.11);
            [left setTitle:array[i] forState:UIControlStateNormal];
            left.backgroundColor = Color(7, 187, 177);
            UIColor *color111 = Color(255, 255, 255);
            [left setTitleColor:color111 forState:UIControlStateNormal];
            left.titleLabel.font = [UIFont systemFontOfSize:16];
            [view addSubview:left];
            [left addTarget:self action:@selector(addCharacter:) forControlEvents:UIControlEventTouchUpInside];
//            UILabel *label22 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.025, ScreenWidth*0.06+i/2*ScreenWidth*0.16, ScreenWidth*0.45, ScreenWidth*0.11)];
//            label22.text = array[i];
//            label22.textColor = Color(156, 156, 156);
//            label22.backgroundColor = Color(0, 215, 200);
//            label22.textColor = Color(255, 255, 255);
//            label22.textAlignment = NSTextAlignmentCenter;
//            label22.font = [UIFont systemFontOfSize:16];
//            [view addSubview:label22];
        }else{
            
            UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
            left.frame = CGRectMake(ScreenWidth*0.525, ScreenWidth*0.06+i/2*ScreenWidth*0.16, ScreenWidth*0.45, ScreenWidth*0.11);
            [left setTitle:array[i] forState:UIControlStateNormal];
            left.backgroundColor = Color(7, 187, 177);
            UIColor *color111 = Color(255, 255, 255);
            left.titleLabel.font = [UIFont systemFontOfSize:16];
            [left setTitleColor:color111 forState:UIControlStateNormal];
            [view addSubview:left];
            [left addTarget:self action:@selector(addCharacter:) forControlEvents:UIControlEventTouchUpInside];
            
//            UILabel *label22 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.525, ScreenWidth*0.06+i/2*ScreenWidth*0.16, ScreenWidth*0.45, ScreenWidth*0.11)];
//            label22.text = array[i];
//            label22.backgroundColor = Color(0, 215, 200);
//            label22.textColor = Color(255, 255, 255);
//            label22.textAlignment = NSTextAlignmentCenter;
////            label2.layer.borderWidth = 1.0;
////            label2.layer.cornerRadius = 5;
////            label2.layer.borderColor = [[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1] CGColor];
//            label22.font = [UIFont systemFontOfSize:16];
//            [view addSubview:label22];
            
            if (i == 8) {
                
                left.frame = CGRectMake(ScreenWidth*0.025, ScreenWidth*0.06+4*ScreenWidth*0.16, ScreenWidth*0.7, ScreenWidth*0.11);
            }
        }
    
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"text_texttext_text"];
    if ([self.miaoshu  isEqualToString:@"(null)"]) {
        
        residuetext.text=@"剩余100字";
    }else
    {
     //   [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"text_texttext_text"]]
        NSString *miaoshu_text = self.gaishu;
        
        if ([miaoshu_text isEqualToString:@"(null)"]) {
            _textView.text = self.miaoshu;
            residuetext.text=[NSString stringWithFormat:@"剩余%ld字",100-self.miaoshu.length];
            [label setHidden:NO];
            [label2 setHidden:NO];
        }else
        {
            if ([miaoshu_text isEqualToString:@""]) {
//                _textView.text = miaoshu_text;
                residuetext.text=[NSString stringWithFormat:@"剩余%ld字",100-miaoshu_text.length];
                [label setHidden:NO];
                [label2 setHidden:NO];
            }else
            {
//                _textView.text=miaoshu_text;
                residuetext.text=[NSString stringWithFormat:@"剩余%ld字",100-miaoshu_text.length];
                [label setHidden:YES];
                [label2 setHidden:YES];
            }
        }
    }
    [self chineseCountOfString: _textView.text];
    [self isChinesecharacter:_textView.text];
    [self characterCountOfString:_textView.text];
    [self.view addSubview:label];
    [self.view addSubview:label2];
    
    UIBarButtonItem *submitButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoButton1:)];
//    UIBarButtonItemStyleBordered
    submitButtonItem.tintColor = Color(0, 215, 200);
    self.navigationItem.rightBarButtonItem = submitButtonItem;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
- (void)fanhui:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isChinesecharacter:(NSString *)string{
    
    if (string.length == 0)
    {
        return NO;
    }
    unichar c = [string characterAtIndex:0];
    
    if (c >=0x4E00 && c <=0x9FA5)
    {
        return YES;//汉字
    }
    else
    {
        return NO;//英文
    }
}

//计算汉字的个数
- (NSInteger)chineseCountOfString:(NSString *)string
{
    int ChineseCount = 0;
    if (string.length == 0)
    {
        return 0;
    }
    for (int i = 0; i<string.length; i++)
    {
        unichar c = [string characterAtIndex:i];
        
        if (c >=0x4E00 && c <=0x9FA5)
        {
            ChineseCount++ ;//汉字
            NSLog(@"%hu",c );
        }
        
    }    return ChineseCount;
}
//计算字母的个数
- (NSInteger)characterCountOfString:(NSString *)string
{
    int characterCount = 0;
    
    if (string.length == 0)
    {
        
        return 0;
        
    }
    for (int i = 0; i<string.length; i++)
    {
        unichar c = [string characterAtIndex:i];
        
        if (c >=0x4E00 && c <=0x9FA5)
        {
            
            NSLog(@"%hu--321312",c );
        }
        else
        {
            characterCount++;//英文
        }
        
    }
    return characterCount;
}

- (void) textViewDidChange:(UITextView *)textView{
    
    NSInteger number1 = [textView.text length];
    if (number1 > 100) {
        
        [self AlertView11];
        textView.text = [textView.text substringToIndex:10];
        number1 = 100;
    }
    residuetext.text = [NSString stringWithFormat:@"剩余%ld字",100-(long)number1];
    
    if ([textView.text length] == 0) {
        [label setHidden:NO];
        [label2 setHidden:NO];
    }else{
        [label setHidden:YES];
        [label2 setHidden:YES];
    }
//    text_text = textView.text;
//    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"textView.text2"];
//    
//    //存起来，下次进来可以修改
//    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"text_texttext_text"];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
//    text_text = textView.text;
//    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"textView.text2"];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textView isExclusiveTouch]) {
        
        [_textView resignFirstResponder];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ((textView.text.length - range.length + text.length) > MY_MAX)
    {
        NSString *substring = [text substringToIndex:MY_MAX - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        
        return NO;
    }
    else{
        
        return YES;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.editing = YES;
    [label2 setHidden:YES];
    [label setHidden:YES];
}

-(void)tijiaoButton1:(UIButton *)sender{
    
    if ([[NSString stringWithFormat:@"%@",self.MIAOSHU_id] isEqualToString:@"(null)"]) {
        
        if ([_textView.text isEqualToString:@""]) {
            
            text_text = @"";
        }else{
            text_text = _textView.text;
        }
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           self.carid,@"carid",
                           text_text,@"content", nil];
        
        [HttpManager postData:dic andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_bcgaishu" success:^(NSDictionary *fanhuicanshu) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            if (_delegate&& [_delegate respondsToSelector:@selector(sendMessage)]) {
                
                [_delegate sendMessage];
            }
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        
    }
}


- (void)addCharacter:(UIButton *)sender{
    
    NSString *str = [[NSString alloc] init];
    str = _textView.text;
    if ([str isEqualToString:@""]) {
        
        _textView.text = sender.titleLabel.text;
        text_text = _textView.text;
    }else{
        
        _textView.text = [NSString stringWithFormat:@"%@；%@",str,sender.titleLabel.text];
        if (_textView.text.length <=100) {
            
//            text_text = _textView.text;
        }else{
            _textView.text = [_textView.text substringToIndex:100];
//            text_text = _textView.text;
            
            [self AlertView11];
        }
    }
    residuetext.text=[NSString stringWithFormat:@"剩余%ld字",100-_textView.text.length];
    [label setHidden:YES];
    [label2 setHidden:YES];
}

- (void)AlertView11{
    
    bigView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:bigView1];
    
    _alertView1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView1.backgroundColor = [UIColor whiteColor];
    _alertView1.alpha = 1.0;
    
    [bigView1 addSubview:_alertView1];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView1.frame), CGRectGetHeight(_alertView1.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView1 addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label1.text = @"字数不能大于100";
    label1.textColor = Color(107, 107, 107);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label1];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    queding1 = [UIButton buttonWithType:UIButtonTypeCustom];
    queding1.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding1 setTitle:@"确定" forState:UIControlStateNormal];
    [queding1 addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding1.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding1 setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding1];
}
- (void)moveAll{
    
    [bigView1 removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
