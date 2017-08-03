//
//  ParentsViewController.m
//  Damai
//
//  Created by qianfeng01 on 15-1-20.
//  Copyright (c) 2015年 BSL. All rights reserved.
//
#define CHGIFAnimationDict @[\
@{@"pattern":@"PullToRefresh_%03d.png",@"drawingStart":@0,@"drawingEnd":@73,@"loadingStart":@73,@"loadingEnd":@140}\
]
#import "ParentsViewController.h"
#import "AFNetworking.h"
#import "AllPages.pch"
#import "MBProgressHUD.h"
#import <SMS_SDK/SMSSDK.h>
//#import "ShopcartViewController.h"
#import "UILabel+SizeLabel.h"
#import "UIScrollView+GifPullToRefresh.h"


//#import <ShareSDK/ShareSDK.h>
#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")
@interface ParentsViewController ()
{
    
    //数据源数组
    NSMutableArray *_dataArr;
    //下载请求类对象
    AFHTTPRequestOperationManager *_manager;
    //保存当前界面任务
    NSMutableDictionary *_currentTask;
    //记录是否正在加载
    BOOL _isLoadMore;
}


@end

@implementation ParentsViewController
-(void)dealloc{
    [_manager.operationQueue cancelAllOperations];
    [_currentTask removeAllObjects];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //自定义返回按钮
    
}
-(void)lostnet:(UIView *)page loding:(void (^)(NSString *status))loding
{
    [LGReachability LGwithSuccessBlock:loding];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;}

-(void)label :(UILabel *)label isBold:(BOOL)isBold isFont:(float )fontOrBoldFont;

{
    if (isBold ==YES)
    {
        label.font =[UIFont boldSystemFontOfSize:fontOrBoldFont/320*ScreenWidth];
    }else
    {
        label.font =[UIFont systemFontOfSize:fontOrBoldFont/320*ScreenWidth];
    }
    
}
-(void)addView:(UIView *)view grade:( int )grade
{
    
    UIImageView *grade1 =[[UIImageView alloc]init];
    UIImageView *grade2 =[[UIImageView alloc]init];
    UIImageView *grade3 =[[UIImageView alloc]init];
    UIImageView *grade4 =[[UIImageView alloc]init];
    UIImageView *grade5 =[[UIImageView alloc]init];
    
    
    
    if (150<grade&&grade<501)
    {
        grade1.frame =CGRectMake(ScreenWidth*0.04, ScreenWidth*0.02, ScreenWidth*0.05, ScreenWidth*0.05);
        
        grade2.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05, ScreenWidth*0.02, ScreenWidth*0.05, ScreenWidth*0.05);
        
        grade3.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05*2, ScreenWidth*0.02, ScreenWidth*0.05, ScreenWidth*0.05);
        
        grade4.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05*3, ScreenWidth*0.02, ScreenWidth*0.05, ScreenWidth*0.05);
        
        grade5.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05*4, ScreenWidth*0.02, ScreenWidth*0.05, ScreenWidth*0.05);
        
    }else
    {
        grade1.frame =CGRectMake(ScreenWidth*0.04, ScreenWidth*0.02, ScreenWidth*0.04, ScreenWidth*0.04);
        
        grade2.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05, ScreenWidth*0.02, ScreenWidth*0.04, ScreenWidth*0.04);
        
        grade3.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05*2, ScreenWidth*0.02, ScreenWidth*0.04, ScreenWidth*0.04);
        
        grade4.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05*3, ScreenWidth*0.02, ScreenWidth*0.04, ScreenWidth*0.04);
        
        grade5.frame =CGRectMake(ScreenWidth*0.04+ScreenWidth*0.05*4, ScreenWidth*0.02, ScreenWidth*0.04, ScreenWidth*0.04);
    }
    
    [view addSubview:grade1];
    [view addSubview:grade2];
    [view addSubview:grade3];
    [view addSubview:grade4];
    [view addSubview:grade5];
    
    
    /***************星星************************/
    if (grade <11)
    {
        
        
        [grade5 setImage:[UIImage imageNamed:@"starliang"]];
        //        grade2.image=grade3.image=grade4.image=grade1.image=[UIImage imageNamed:@"starhei"];
        
    }
    if (10<grade&&grade<21)
    {
        
        grade5.image=grade4.image=[UIImage imageNamed:@"starliang"];
        
        //        grade3.image=grade2.image=grade1.image=[UIImage imageNamed:@"starhei"];
    }
    else if (20<grade&&grade<31)
    {
        grade5.image=grade4.image=grade3.image=[UIImage imageNamed:@"starliang"];
        
        //        grade4.image=grade5.image=[UIImage imageNamed:@"starhei"];
    }
    else if (30<grade&&grade<41)
    {
        grade5.image=grade2.image=grade3.image=grade4.image=[UIImage imageNamed:@"starliang"];
        
        //        grade5.image=[UIImage imageNamed:@"starhei"];
    }
    else if (40<grade&&grade<51)
    {
        
        grade1.image=grade2.image=grade3.image=grade4.image=grade5.image=[UIImage imageNamed:@"starliang"];
    }
    
    /********************钻石*******************/
    else if (50<grade&&grade<71)
    {
        [grade5 setImage:[UIImage imageNamed:@"黄钻"]];
        
    }
    else if (70<grade&&grade<91)
    {
        
        grade5.image=grade4.image=[UIImage imageNamed:@"黄钻"];
    }
    else if (90<grade&&grade<111)
    {
        grade5.image=grade4.image=grade3.image=[UIImage imageNamed:@"黄钻"];
    }
    else if (110<grade&&grade<131)
    {
        grade5.image=grade2.image=grade3.image=grade4.image=[UIImage imageNamed:@"黄钻"];
    }
    else if (130<grade&&grade<151)
    {
        grade1.image=grade2.image=grade3.image=grade4.image=grade5.image=[UIImage imageNamed:@"黄钻"];
        
        
    }
    
    
    /******************冠****************/
    
    else if (150<grade&&grade<181)
    {
        [grade5 setImage:[UIImage imageNamed:@"冠"]];
        
    }
    
    else if (180<grade&&grade<211)
    {
        grade5.image=grade4.image=[UIImage imageNamed:@"冠"];
    }
    else if (210<grade&&grade<241)
    {
        grade5.image=grade4.image=grade3.image=[UIImage imageNamed:@"冠"];
    }
    else if (240<grade&&grade<271)
    {
        grade5.image=grade2.image=grade3.image=grade4.image=[UIImage imageNamed:@"冠"];
    }
    else if (270<grade&&grade<301)
    {
        grade1.image=grade2.image=grade3.image=grade4.image=grade5.image=[UIImage imageNamed:@"冠"];
    }
    /************************金冠**************************/
    
    else if (300<grade&&grade<341)
    {
        [grade5 setImage:[UIImage imageNamed:@"皇冠"]];
    }
    
    else if (340<grade&&grade<381)
    {
        grade5.image=grade4.image=[UIImage imageNamed:@"皇冠"];
    }
    else if (380<grade&&grade<421)
    {
        grade5.image=grade4.image=grade3.image=[UIImage imageNamed:@"皇冠"];
    }
    else if (420<grade&&grade<461)
    {
        grade5.image=grade2.image=grade3.image=grade4.image=[UIImage imageNamed:@"皇冠"];
    }
    else if (460<grade&&grade<501)
    {
        grade1.image=grade2.image=grade3.image=grade4.image=grade5.image=[UIImage imageNamed:@"皇冠"];
    }
    
   }

-(void)xiaojiadeTishiTitle:(NSString *)tishixinxi{
    
    UIWindow *keywindow=[[UIApplication sharedApplication] keyWindow];
    UILabel* tishi=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-ScreenWidth*0.745)/2, ScreenHeight-ScreenWidth*0.545, 0, Height(30))];
    
    [UIWindow animateWithDuration:1.5 animations:^{
        tishi.text =tishixinxi;
        tishi.backgroundColor =[UIColor blackColor];
        tishi.layer.masksToBounds=YES;
        tishi.layer.cornerRadius=Height(30)/2;
        tishi.font =[UIFont systemFontOfSize: 14.0f];
        tishi.textColor=[UIColor whiteColor];
        tishi.textAlignment = NSTextAlignmentCenter;
        tishi.alpha=0;
        tishi.frame= CGRectMake((ScreenWidth-ScreenWidth*0.745)/2, ScreenHeight-ScreenWidth*0.545, 0, Height(30));
        
        [keywindow addSubview:tishi];
    }completion:^(BOOL finished) {
        
       
    }];
    
    float myWidth=[UILabel width:tishi.text heightOfFatherView:tishi.frame.size.height textFont:tishi.font];
    tishi.frame=CGRectMake((ScreenWidth-myWidth-10)/2, ScreenHeight-ScreenWidth*0.545, myWidth+20, Height(30));
}

-(void)button :(UIButton *)button  isBold:(BOOL)isBold isFont:(float )fontOrBoldFont;
{
    if (isBold ==YES)
    {
        button.titleLabel.font =[UIFont fontWithName:@"Helvetica" size:fontOrBoldFont/320*ScreenWidth];
    }else
    {
        button.titleLabel.font =[UIFont fontWithName:@"STHeitiSC-Light" size:fontOrBoldFont/320*ScreenWidth];
    }
}
-(void)wenxintishiTitle:(NSString *)tishi
{
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-ScreenWidth*0.6)/2, (ScreenHeight-64)/2-ScreenWidth*0.6/2, ScreenWidth*0.6, ScreenWidth*0.6)];
    imageView.image =[UIImage imageNamed:@"Big"];
    [self.view addSubview:imageView];
    UILabel *label =[[UILabel alloc ]initWithFrame:CGRectMake((ScreenWidth-ScreenWidth*0.6)/2, (ScreenHeight-64)/2-ScreenWidth*0.6/2+ScreenWidth*0.6, ScreenWidth*0.6, ScreenWidth*0.1)];
    label.text =tishi;
    label.font =[UIFont boldSystemFontOfSize:16.0f];
    label.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}
-(void)ShowMBHubWithTitleOnlyWithTitle:(NSString *)title withTime:(float)time{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 14.f;
    hud.color=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}
-(void)textfieldsech:(SEL)action action1:(SEL)TapGestureRecognizer
{
    NSLog(@"开始");
    _textField=[[CustomTextField alloc]initWithFrame:CGRectMake(ScreenWidth/5.4, (ScreenWidth*0.046875+ScreenWidth*0.0625/2)-ScreenWidth*0.035625, ScreenWidth/1.48,ScreenWidth*0.07)];
    _textField.borderStyle=UITextBorderStyleNone;
//    _textField.placeholder=@"品牌  车型  颜色";
    _textField.layer.borderWidth=1;
    _textField.layer.cornerRadius=3;
 
    _textField.backgroundColor =[UIColor whiteColor];
    _textField.alpha =0.4;
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0,0, ScreenWidth/1.6,ScreenWidth*0.07)];
    label.text =@"     品牌  车型  颜色";
    [self label:label isBold:NO isFont:12.0f];
    label.textColor=[UIColor blackColor];
//    [self.navigationController.navigationBar addSubview:label];
    [_textField addSubview:label];
    
    _textField.layer.borderColor=[UIColor whiteColor].CGColor;
    _textField.font=[UIFont systemFontOfSize:ScreenWidth*0.040625];
    [self.navigationController.navigationBar addSubview:_textField];
    UIButton *sech=[MyUtil createBtnFrame:CGRectMake(0, ScreenWidth*0.0125, ScreenWidth*0.0875, ScreenWidth*0.05625) image:@"56-2 (4)" selectedImage:nil target:self action:action];
    [sech setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, ScreenWidth*0.03125)];
//    [_textField addSubview:sech];
    _textField.rightView=sech;
    _textField.rightViewMode=UITextFieldViewModeAlways;
    UIView *viewwe=[[UIView alloc]initWithFrame:_textField.bounds];
    [viewwe setUserInteractionEnabled:YES];
    [_textField addSubview:viewwe];
    UITapGestureRecognizer *tapge=[[UITapGestureRecognizer alloc]initWithTarget:self action:TapGestureRecognizer];
    tapge.numberOfTapsRequired = 1;//点击数
    tapge.numberOfTouchesRequired = 1; //手指数
    
    UITapGestureRecognizer *tapge2=[[UITapGestureRecognizer alloc]initWithTarget:self action:TapGestureRecognizer];
    tapge2.numberOfTapsRequired = 2;//点击数
    tapge2.numberOfTouchesRequired = 1; //手指数
    [tapge requireGestureRecognizerToFail:tapge2];
    [viewwe addGestureRecognizer:tapge];
    [viewwe addGestureRecognizer:tapge2];
    
}
-(void)leftButton:(NSString *)title action:(SEL)action
{
    [_labell removeFromSuperview];
    CGFloat W=ScreenWidth*0.15625;
    _LeftBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.03125,ScreenWidth*0.046875,W, ScreenWidth*0.0625)];
    _labell=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.00125, ScreenWidth*0.046875, W/1.4, ScreenWidth*0.0625)];
    _labell.font =[UIFont systemFontOfSize:ScreenWidth*0.041875];
    _labell.text=title;
    
    _labell.textColor=[UIColor whiteColor];
    _labell.textAlignment=NSTextAlignmentRight;
    _labell.adjustsFontSizeToFitWidth=YES;
    [self.navigationController.navigationBar addSubview:_labell];
    
    
    [_LeftBtn setTitle:@"" forState:UIControlStateNormal];
    [_LeftBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
    _LeftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_LeftBtn setImageEdgeInsets:UIEdgeInsetsMake(ScreenWidth*0.015625,ScreenWidth*0.09375,ScreenWidth*0.009375,ScreenWidth*0.025)];
    [_LeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-Height(57),0,Height(9))];
    [_LeftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    _LeftBtn.titleLabel.font =[UIFont systemFontOfSize:ScreenWidth*0.041875];
    _LeftBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    _LeftBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    //    [self addItemWithCustomView:@[leftbutton] isLeft:YES];
    [self.navigationController.navigationBar addSubview:_LeftBtn];
    //    _LeftBtn=leftbutton;
}
-(void)rightButton:(NSString *)title action:(SEL)action
{
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.077125-ScreenWidth*0.03125,ScreenWidth*0.025875, ScreenWidth*0.088125,ScreenWidth*0.088125)];
    [rightbutton setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        [rightbutton setImageEdgeInsets:UIEdgeInsetsMake(ScreenWidth*0.01025, 0, -ScreenWidth*0.01025, 0)];
    [rightbutton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:rightbutton];
    _RightBtn=rightbutton;
}
-(void)addTitleViewWithTitle:(NSString *)title{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0], NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont boldSystemFontOfSize:Height(17)];
    lable.text=title;
    lable.textColor=[UIColor blackColor];
    self.navigationItem.titleView=lable;
}
-(void)startTimebtn:(UIButton *)btn
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"重新发送" forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
                btn.backgroundColor =Color(249, 98, 104);
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"%@s后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
//                btn.backgroundColor=Color(153, 153, 153);
                [self button:btn  isBold:YES isFont:11.0f];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(void)thisIsDuanXinYanZhengWithPhone:(NSString *)phone
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            
            [self ShowMBHubWithTitleOnlyWithTitle:@"已发送到您的手机，请验证" withTime:1.0f];
            
        }else{
            
            [self ShowMBHubWithTitleOnlyWithTitle:@"系统错误，请重新获取" withTime:1.0f];
        }
    }];
    
}

-(void)addItemWithCustomView:(NSArray *)customViews isLeft:(BOOL)isLeft{
    
    NSMutableArray *items=[[NSMutableArray alloc]init];
    for (int i=0; i<customViews.count; i++) {
        UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:customViews[i]];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems=items;
    } else {
        self.navigationItem.rightBarButtonItems=items;
    }
}
-(void)initTitleBar
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initTitleBarColor];
    
}
-(void)initTitleBarColor
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0], NSFontAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}
-(void)addTask:(NSString *)url finished:(SEL)sel{
    
    if ([_currentTask objectForKey:url]) {
        NSLog(@"已经添加了这个任务");
        return;
    }
    [_currentTask setObject:url forKey:url];
    //返回二进制，不解析
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL];
        NSLog(@"下载成功");
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(
                                               [self performSelector:sel withObject:responseObject];
                                               
                                               );
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL];
        NSLog(@"下载失败!%@",[error localizedDescription]);
    }];
}
//文字自动适应宽高
-(void)suitableWH:(UILabel *)label X:(CGFloat )X Y:(CGFloat)Y font:(UIFont *)font
{
    UIFont *fnt = font;
    label.font = fnt;
    // 根据字体得到NSString的尺寸
    CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    // 名字的H
    CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    label.frame = CGRectMake(X, Y, nameW,nameH);
    
}
-(void)TextLineSpacing:(CGFloat)flot text:(UILabel *)Hlabel
{
    
    if (Hlabel.text.length>0)
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Hlabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:flot];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [Hlabel.text length])];
        
        Hlabel.attributedText = attributedString;
        
    }else
    {
        
    }
    
}
- (void)loadAvatarInKeyWindow {
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    NSDictionary *parameter =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
    [manager POST:[NSString stringWithFormat:@"%@api.php?op=listshops",NowUrl] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=responseObject;
        NSArray *_listArray=[NSArray array];
        _listArray =[dict objectForKey:@"shop_list"];
        
        
        RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(ScreenWidth-2*ScreenWidth*0.134375,ScreenHeight-120, ScreenWidth*0.134375, ScreenWidth*0.134375)];

        
        [avatar setLongPressBlock:^(RCDraggableButton *avatar) {
            NSLog(@"长按");
                if ([ZCUserData share].isLogin==YES) {
                
//                ShopcartViewController *shopingcart=[[ShopcartViewController alloc]init];
//             
//                [self.navigationController pushViewController:shopingcart animated:YES];
                
            }else
            {
                
                LoginView *log=[[LoginView alloc]init];
               
                [self.navigationController pushViewController:log animated:YES];
                
            }
            
        }];
        
        [avatar setTapBlock:^(RCDraggableButton *avatar) {
            NSLog(@"单击");
            
            if ([ZCUserData share].isLogin==YES) {
                
//                ShopcartViewController *shopingcart=[[ShopcartViewController alloc]init];
//                
//                [self.navigationController pushViewController:shopingcart animated:YES];
                
            }else
            {
                
                LoginView *log=[[LoginView alloc]init];
                
                [self.navigationController pushViewController:log animated:YES];
                
            }
            
        }];
        
        [avatar setDoubleTapBlock:^(RCDraggableButton *avatar) {
            NSLog(@"双击");
            
            if ([ZCUserData share].isLogin==YES) {
                
//                ShopcartViewController *shopingcart=[[ShopcartViewController alloc]init];
//                [self.navigationController pushViewController:shopingcart animated:YES];
                
            }else
            {
                
                LoginView *log=[[LoginView alloc]init];
                
                [self.navigationController pushViewController:log animated:YES];
                
            }
            
        }];
        
        [avatar setDraggingBlock:^(RCDraggableButton *avatar) {
            NSLog(@"拖动");
            //More todo here.
            
        }];
        
        [avatar setDragDoneBlock:^(RCDraggableButton *avatar) {
            NSLog(@"松手");
            //More todo here.
            
        }];
        
        [avatar setAutoDockingBlock:^(RCDraggableButton *avatar) {
            NSLog(@"松手后自动移动");
            //More todo here.
            
        }];
        [avatar setAutoDockingDoneBlock:^(RCDraggableButton *avatar) {
            NSLog(@"松手后自动移动后贴边");
            //More todo here.
            
        }];
        _avatar1=avatar;
        UIImageView* imageView =[[UIImageView alloc]initWithFrame:CGRectMake(avatar.frame.size.width-Height(12),Height(6), Height(6), Height(6))];
        imageView.layer.cornerRadius=imageView.frame.size.height/2;
        imageView.backgroundColor=[UIColor redColor];
        if (_listArray.count ==0)
        {
            
            
        }else
        {
            [avatar addSubview:imageView];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error%@",error);
    }];
    
}
-(void)AlertController:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionWithTitle:(NSString *)title actionWithTitle2:(NSString *)title2 handler:(void (^ __nullable)(UIAlertAction *action))handler handler2:(void (^ __nullable)(UIAlertAction *action))handler2 handler3:(void (^ _Nullable)(UIAlertAction *action))handler3
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:handler3];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:handler2];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
/**   *  MBProgressHUD 添加加载动画   *  Memory-23.8M   *  #import "UIImage+GIF.h"   *  #import "MBProgressHUD.h"   */
-(void)gifPlay6  {
    UIImage  *image=[UIImage sd_animatedGIFNamed:@"test"];
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,image.size.width/2, image.size.height/2)];
    gifview.image=image;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color=[UIColor grayColor];
    //默认颜色太深了
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"加载中...";
    hud.customView=gifview;
}
-(void)Refresh_JXY:(UITableView *)TABLEVIEW VOID:(Refresh)VOID
{
    
    NSMutableArray *drawingImgs = [NSMutableArray array];
    NSMutableArray *loadingImgs = [NSMutableArray array];
    NSUInteger drawingStart = [CHGIFAnimationDict[0][@"drawingStart"] intValue];
    NSUInteger drawingEnd = [CHGIFAnimationDict[0][@"drawingEnd"] intValue];
    NSUInteger laodingStart = [CHGIFAnimationDict[0][@"loadingStart"] intValue];
    NSUInteger loadingEnd = [CHGIFAnimationDict[0][@"loadingEnd"] intValue];
    for (NSUInteger i  = drawingStart; i <= drawingEnd; i++) {
        NSString *fileName = [NSString stringWithFormat:CHGIFAnimationDict[0][@"pattern"],i];
        [drawingImgs addObject:[UIImage imageNamed:fileName]];
    }
    
    for (NSUInteger i  = laodingStart; i <= loadingEnd; i++) {
        NSString *fileName = [NSString stringWithFormat:CHGIFAnimationDict[0][@"pattern"],i];
        [loadingImgs addObject:[UIImage imageNamed:fileName]];
    }
    
    
    __weak UITableView *tempScrollView = TABLEVIEW;
    
    [TABLEVIEW addPullToRefreshWithDrawingImgs:drawingImgs andLoadingImgs:loadingImgs andActionHandler:^{
        [tempScrollView performSelector:@selector(didFinishPullToRefresh) withObject:nil afterDelay:1];
        VOID();
    }];

}


@end
