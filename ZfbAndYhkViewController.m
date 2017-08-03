//
//  ZfbAndYhkViewController.m
//  CarHead
//
//  Created by MacBookXcZl on 2017/5/25.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "ZfbAndYhkViewController.h"
#import "Header.h"
#import "HttpManager.h"
#import "ZCUserData.h"

@interface ZfbAndYhkViewController ()<UIScrollViewDelegate>{
    UISegmentedControl *_segment;
    UIView *backgroundView;
    UIScrollView *_scrollerView;
    
    NSMutableArray *_zfbArray;
    NSMutableArray *_yhkArray;
}

@end

@implementation ZfbAndYhkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _zfbArray = [NSMutableArray new];
    _yhkArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    // Do any additional setup after loading the view.
    [self createSegment];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    UITextField *te1 = [self.view viewWithTag:601];
    UITextField *te2 = [self.view viewWithTag:602];
    UITextField *te5 = [self.view viewWithTag:604];
    [te1 resignFirstResponder];
    [te2 resignFirstResponder];
    [te5 resignFirstResponder];


    UITextField *te11 = [self.view viewWithTag:701];
    UITextField *te22 = [self.view viewWithTag:702];
    UITextField *te23 = [self.view viewWithTag:703];
    UITextField *te35 = [self.view viewWithTag:705];
    [te11 resignFirstResponder];
    [te2 resignFirstResponder];
    [te22 resignFirstResponder];
    [te23 resignFirstResponder];
    [te35 resignFirstResponder];
}
#pragma mark - 支付宝And银行卡

//支付宝
-(void)creatZfbView {
    
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segment.frame), ScreenWidth, ScreenHeight-64-ScreenWidth*0.12)];
    backgroundView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:backgroundView];
    
    UIView *whitegroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.12, ScreenWidth, ScreenWidth*0.36)];
    whitegroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:whitegroundView];
    
    UIView *whitegroundView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whitegroundView.frame)+ScreenWidth*0.12, ScreenWidth, ScreenWidth*0.18)];
     whitegroundView1.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:whitegroundView1];
    
// logo浅背景图
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.4, CGRectGetMaxY(whitegroundView1.frame)+0.1*ScreenWidth, 0.2*ScreenWidth, 0.2*ScreenWidth)];
    imageview.image = [UIImage imageNamed:@"logo浅.png"];
    imageview.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];;
    [backgroundView addSubview:imageview];
    
   //button
    UIButton *tixian = [UIButton buttonWithType:UIButtonTypeCustom];
    tixian.frame = CGRectMake(ScreenWidth*0.2, CGRectGetMaxY(imageview.frame)+ScreenWidth*0.15,  ScreenWidth*0.6, ScreenWidth*0.1);
    [tixian setTitle:@"体现提交" forState:UIControlStateNormal];
    [tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tixian.backgroundColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    [tixian addTarget:self action:@selector(tixianZfb:) forControlEvents:UIControlEventTouchUpInside];
    [tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:tixian];
    
    float height = 0;
    float jianGe = ScreenWidth*0.05;
    NSArray *nameArray = @[@"请填写本人支付宝账号",@"姓名",@"支付宝",@"每次最低提现100元",@"提现金额"];
    for (int i = 0; i<5; i++) {
        
        UILabel *label = [UILabel new];
        label.text = nameArray[i];
        if (i == 0 || i == 3) {
            label.frame = CGRectMake(jianGe, height, ScreenWidth*0.9, ScreenWidth*0.12);
            height += ScreenWidth*0.48;
            label.textColor = [UIColor colorWithWhite:0.6 alpha:1];
            label.font  = [UIFont fontWithName:@"Arial-BoldMT" size:16.0];
            [backgroundView addSubview:label];
        }else if (i == 1 || i == 2){
            label.frame = CGRectMake(jianGe, (i-1)*0.18*ScreenWidth, ScreenWidth*0.9, ScreenWidth*0.18);
            label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
            label.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
            [whitegroundView addSubview:label];
            if(i == 1) {
                UILabel *lab = [UILabel new];
                lab.frame = CGRectMake(jianGe, 0.18*ScreenWidth, ScreenWidth*0.9, 2);
                lab.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
                [whitegroundView addSubview:lab];
            }
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth*0.05+(i+2)*0.05*ScreenWidth, (i-1)*0.18*ScreenWidth, ScreenWidth-(ScreenWidth*0.04+(i+2)*0.05*ScreenWidth)-ScreenWidth*0.05, ScreenWidth*0.18)];
            textField.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
            textField.tag = 600+i;
             textField.textColor = [UIColor colorWithWhite:0.8 alpha:1];
            textField.font =[UIFont boldSystemFontOfSize:20];
            [whitegroundView addSubview:textField];
            
          //  [_zfbArray addObject:textField.text];
        }else {
            label.frame = CGRectMake(jianGe,0, ScreenWidth*0.9, ScreenWidth*0.18);
            label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
            label.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
            [whitegroundView1 addSubview:label];
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth*0.06+5*0.05*ScreenWidth, 0, ScreenWidth-(ScreenWidth*0.04+5*0.05*ScreenWidth)-ScreenWidth*0.05, ScreenWidth*0.18)];
            textField.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
             textField.tag = 600+i;
            textField.textColor = [UIColor colorWithWhite:0.8 alpha:1];
            textField.font =[UIFont boldSystemFontOfSize:20];
            textField.placeholder = @"可提现金额500元";
            [textField setValue:[UIColor colorWithWhite:0.8 alpha:1]forKeyPath:@"_placeholderLabel.textColor"];
            [textField setValue:[UIFont boldSystemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
            [whitegroundView1 addSubview:textField];
            //  [_zfbArray addObject:textField.text];

        }
    }
    
}
-(void)tixianZfb:(UIButton *)tiXianButton {
 
    [_zfbArray removeAllObjects];
    
    UITextField *nameText = [self.view viewWithTag:601];
    UITextField *zfbNumberText = [self.view viewWithTag:602];
    UITextField *jiageText = [self.view viewWithTag:604];
    [_zfbArray addObject:[ZCUserData share].userId];
    [_zfbArray addObject:nameText.text];
    [_zfbArray addObject:zfbNumberText.text];
    [_zfbArray addObject:jiageText.text];

    //[_zfbArray removeAllObjects];
    NSDictionary *dict = @{@"userid":_zfbArray[0],@"jiage":jiageText.text,@"name":nameText.text,@"paytype":@"支付宝",@"payno":zfbNumberText.text};
   
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlife.com/tc.php?op=tixian" success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"%@",fanhuicanshu);
        
        [_zfbArray removeAllObjects];
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];
}
//银行卡
-(void)creatYhkView {
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segment.frame), ScreenWidth, ScreenHeight-64-ScreenWidth*0.12)];
   
    _scrollerView.delegate = self;
    _scrollerView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:_scrollerView];
    
    UIView *whitegroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.12, ScreenWidth, ScreenWidth*0.54)];
    whitegroundView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:whitegroundView];
    
    UIView *whitegroundView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whitegroundView.frame)+ScreenWidth*0.12, ScreenWidth, ScreenWidth*0.18)];
    whitegroundView1.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:whitegroundView1];
    
    // logo浅背景图
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.4, CGRectGetMaxY(whitegroundView1.frame)+0.1*ScreenWidth, 0.2*ScreenWidth, 0.2*ScreenWidth)];
    imageview.image = [UIImage imageNamed:@"logo浅.png"];
    imageview.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];;
    [_scrollerView addSubview:imageview];
    
    //button
    UIButton *tixian = [UIButton buttonWithType:UIButtonTypeCustom];
    tixian.frame = CGRectMake(ScreenWidth*0.2, CGRectGetMaxY(imageview.frame)+ScreenWidth*0.15,  ScreenWidth*0.6, ScreenWidth*0.1);
    [tixian setTitle:@"体现提交" forState:UIControlStateNormal];
    [tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tixian.backgroundColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    [tixian addTarget:self action:@selector(tixianYhk:) forControlEvents:UIControlEventTouchUpInside];
    [tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollerView addSubview:tixian];
    
    _scrollerView.contentSize = CGSizeMake(self.view.frame.size.width,  self.view.frame.size.height);
    
    float height = 0;
    float jianGe = ScreenWidth*0.05;
    NSArray *nameArray = @[@"请填写本人开户银行卡号",@"姓名",@"支付宝",@"开户行",@"每次最低提现100元",@"提现金额"];
    for (int i = 0; i<6; i++) {
        
        UILabel *label = [UILabel new];
        label.text = nameArray[i];
        if (i == 0 || i == 4) {
            label.frame = CGRectMake(jianGe, height, ScreenWidth*0.9, ScreenWidth*0.12);
            height += ScreenWidth*0.66;
            label.textColor = [UIColor colorWithWhite:0.6 alpha:1];
            label.font  = [UIFont fontWithName:@"Arial-BoldMT" size:16.0];
            [_scrollerView addSubview:label];
        }else if (i == 1 || i == 2 || i == 3){
            label.frame = CGRectMake(jianGe, (i-1)*0.18*ScreenWidth, ScreenWidth*0.9, ScreenWidth*0.18);
            label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
            label.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
            [whitegroundView addSubview:label];
            if(i == 1 || i == 2) {
                UILabel *lab = [UILabel new];
                lab.frame = CGRectMake(jianGe, 0.18*ScreenWidth*i, ScreenWidth*0.9, 2);
                lab.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
                [whitegroundView addSubview:lab];
            }
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth*0.05+(i+2)*0.05*ScreenWidth, (i-1)*0.18*ScreenWidth, ScreenWidth-(ScreenWidth*0.04+(i+2)*0.05*ScreenWidth)-ScreenWidth*0.05, ScreenWidth*0.18)];
            textField.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
            textField.tag = 700+i;
            textField.textColor = [UIColor colorWithWhite:0.8 alpha:1];
            textField.font =[UIFont boldSystemFontOfSize:20];
            [whitegroundView addSubview:textField];
            
            
        }else {
            label.frame = CGRectMake(jianGe,0, ScreenWidth*0.9, ScreenWidth*0.18);
            label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
            label.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
            [whitegroundView1 addSubview:label];
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth*0.06+5*0.05*ScreenWidth, 0, ScreenWidth-(ScreenWidth*0.04+5*0.05*ScreenWidth)-ScreenWidth*0.05, ScreenWidth*0.18)];
            textField.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
            textField.tag = 700+i;
            textField.textColor = [UIColor colorWithWhite:0.8 alpha:1];
            textField.font =[UIFont boldSystemFontOfSize:20];
            textField.placeholder = @"可提现金额500元";
            [textField setValue:[UIColor colorWithWhite:0.8 alpha:1]forKeyPath:@"_placeholderLabel.textColor"];
            [textField setValue:[UIFont boldSystemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
            [whitegroundView1 addSubview:textField];
            
        }
    }
    
}
-(void)tixianYhk:(UIButton *)tiXianButton {

    
    [_yhkArray removeAllObjects];
    [_yhkArray addObject:[ZCUserData share].userId];
    
    UITextField *nameText = [self.view viewWithTag:701];
    UITextField *zfbNumberText = [self.view viewWithTag:702];
    UITextField *jiageText = [self.view viewWithTag:705];
    UITextField *yinhangkaText = [self.view viewWithTag:703];
    
    //[_zfbArray removeAllObjects];
    NSDictionary *dict = @{@"userid":_yhkArray[0],@"jiage":jiageText.text,@"name":nameText.text,@"paytype":@"银行",@"payno":zfbNumberText.text,@"kaihuhang":yinhangkaText.text};
    
    [HttpManager postData:dict andUrl:@"http://wx.leisurecarlife.com/tc.php?op=tixian" success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"%@",fanhuicanshu);

    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];

    
}



#pragma mark - xuanze

- (void)createSegment{
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"支付宝", @"银行卡", nil];
    
    
    _segment = [[UISegmentedControl alloc] initWithItems:arr];
    
    _segment.frame = CGRectMake(0, 64, ScreenWidth, ScreenWidth*0.12);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:17.f],NSFontAttributeName,nil];
    
    [_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    _segment.selectedSegmentIndex = 0;
    
    _segment.tag = 667;
    
    _segment.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    
    _segment.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    _segment.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _segment.layer.borderWidth = 0.5;
    
    [_segment addTarget:self action:@selector(segMentValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    [self creatZfbView];
}

#pragma mark - segment selected
- (void)segMentValueChange:(UISegmentedControl *)sender{
    
    NSInteger index = sender.selectedSegmentIndex;
    
    switch (index) {
        case 0:{
            [_scrollerView removeFromSuperview];
            backgroundView.hidden = NO;
            _scrollerView.hidden = YES;
            [self creatZfbView];
            break;
            
        }
        case 1:{
            [backgroundView removeFromSuperview];
            _scrollerView.hidden = NO;
            backgroundView.hidden = YES;
            [self creatYhkView];
            break;
            
        }
        default:
            break;
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
