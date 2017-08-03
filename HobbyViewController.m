//
//  HobbyViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/12/11.
//  Copyright © 2015年 佐途. All rights reserved.
//
#define MY_MAX 100

#import "HobbyViewController.h"
#import "AllPages.pch"

@interface HobbyViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UILabel*label;
    NSTimer *myTimer;
}
@property (nonatomic,retain)  UITextView *textView;
@property (nonatomic,retain) AFHTTPRequestOperationManager *manager;

@end

@implementation HobbyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"兴趣爱好"];
    self.view.backgroundColor=Color(245, 245, 249);
    
    [self xingqu];
}
-(void)xingqu
{
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(Height(20)/2, Height(20)/2+5, ScreenWidth-(Height(20)), ScreenWidth*0.95)];
    _textView.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _textView.textColor =[UIColor blackColor];
    _textView.backgroundColor= [UIColor whiteColor];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_textView becomeFirstResponder];
    _textView.scrollEnabled= YES;
    [_textView setDelegate:self];
    _textView.text =[ZCUserData share].xingqu;
    _textView.layer.masksToBounds =YES;
    _textView.layer.cornerRadius =6.0f;
    [self.view addSubview:_textView];
    
    if (_textView.text.length==0){
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(Height(20),  Height(20)/2, ScreenWidth-Height(20)*2, ScreenWidth/8)];
        label.enabled = NO;
        label.text = @"请填写您的兴趣爱好。";
        label.numberOfLines =0;
        label.font =Font(15);
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = Color(50, 50, 50);
        
    }
    
    
    
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
    NSString * string =[NSString stringWithFormat:@"%@",_textView.text];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *parameter =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].lianxi,@"lianxi", [ZCUserData share].userId,@"userid",[ZCUserData share].nickname,@"nickname",[ZCUserData share].xueli,@"xueli",[ZCUserData share].zhiye,@"zhiye",string,@"xingqu",[ZCUserData share].descriptions,@"description",nil];
    [manager POST:[NSString stringWithFormat:@"%@api.php?op=member_update",NowUrl] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic =responseObject;
        NSLog(@"312321:%@",dic);
        if ([[dic objectForKey:@"error"] isEqualToString:@"0"])
        {
            
            [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[ZCUserData share].descriptions mobile:[ZCUserData share].mobile fuwu:[ZCUserData share].fuwu jiedan:[ZCUserData share].jiedan lianxi:[ZCUserData share].lianxi yinxiang:[ZCUserData share].yinxiang nickname:[ZCUserData share].nickname thumb:[ZCUserData share].thumb tiqian:[ZCUserData share].tiqian xing:[ZCUserData share].xing xingqu:_textView.text xueli:[ZCUserData share].xueli zhiye:[ZCUserData share].zhiye IsLogin:[ZCUserData share].isLogin];
            
            [self ShowMBHubWithTitleOnlyWithTitle:@"填写成功"withTime:1.0f];
            
            
            [self.navigationController popViewControllerAnimated: YES];
            
            
        }else
        {
            [self ShowMBHubWithTitleOnlyWithTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]] withTime:1.0f];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
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
