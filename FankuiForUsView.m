//
//  FankuiForUsView.m
//  ZuChe
//
//  Created by apple  on 2017/6/9.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "FankuiForUsView.h"
#import "AFHTTPRequestOperationManager.h"
#import "Header.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import "LoginView.h"

#define Height(H) (H)/320.0*ScreenWidth
#define MY_MAX 600

@interface FankuiForUsView ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UILabel*label;
    NSTimer *myTimer;
}
@property (nonatomic,retain)  UITextView *textView;
@property (nonatomic,retain) AFHTTPRequestOperationManager *manager;

@end

@implementation FankuiForUsView
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.[self fankui];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    title.text = @"意见反馈";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = title;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    self.view.backgroundColor=Color(245, 245, 249);
    
    [self fankui];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fankui{
    
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(Height(20)/2, ScreenWidth*0.05, ScreenWidth-(Height(20)), ScreenWidth*0.65)];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.textColor =[UIColor blackColor];
    _textView.backgroundColor= [UIColor whiteColor];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_textView becomeFirstResponder];
    _textView.scrollEnabled= YES;
    [_textView setDelegate:self];
    _textView.layer.masksToBounds =YES;
    _textView.layer.cornerRadius =6.0f;
    [self.view addSubview:_textView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(Height(20),  0, ScreenWidth-2*Height(20), ScreenWidth/6)];
    label.enabled = NO;
    label.text = @"你若有什么想要对我们说的话，都可以在这里留言...";
    label.numberOfLines =0;
    label.font =[UIFont systemFontOfSize:13];
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = Color(50, 50, 50);
    
    
    [self chineseCountOfString: _textView.text];
    [self isChinesecharacter:_textView.text];
    [self characterCountOfString:_textView.text];
    [self.view addSubview:label];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame=CGRectMake(20, 0, 70, 30);
    submitButton.titleLabel.font =[UIFont boldSystemFontOfSize:16];
    [submitButton setTitle:@"        提交" forState:UIControlStateNormal];
    [submitButton setTintColor:[UIColor whiteColor]];
    [submitButton addTarget:self action:@selector(tijiaoButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *submitButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    self.navigationItem.rightBarButtonItem = submitButtonItem;
    
}
- (BOOL)isChinesecharacter:(NSString *)string
{
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
    
    
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textView isExclusiveTouch]) {
        [_textView resignFirstResponder];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ((textView.text.length - range.length + text.length) > MY_MAX)
    {
        NSString *substring = [text substringToIndex:MY_MAX - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.editing=YES;
}
-(void)tijiaoButton:(UIButton *)sender
{
    NSLog(@"你点击了提交按钮=%@",_textView.text);
    if ([ZCUserData share].isLogin==YES) {
        if (_textView.text.length==0) {
            NSString *strTitle = [NSString stringWithFormat:@"温馨提示"];
            NSString *strMsg = @"请填写您宝贵的意见";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                            message:strMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }else
        {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].username,@"username",_textView.text,@"content", nil];
            [HttpManager postData:dic andUrl:YIJIAN success:^(NSDictionary *fanhuicanshu) {
                if ([[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"error"]] isEqualToString:@"0"]) {
                    NSString *strTitle = [NSString stringWithFormat:@"温馨提示"];
                    NSString *strMsg =[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                                    message:strMsg
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } Error:^(NSString *cuowuxingxi) {
                
            }];
        }
    }else
    {
        LoginView *log=[[LoginView alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }
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
