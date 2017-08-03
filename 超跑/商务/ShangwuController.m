//
//  ShangwuController.m
//  ZuChe
//
//  Created by apple  on 2017/7/6.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ShangwuController.h"
#import "Header.h"
#import "ShangWuDingdanView.h"
#import "MyAnnomationView.h"

@interface ShangwuController ()<UIScrollViewDelegate>{
    
    UIView *_sliderView;
    UILabel *leixingLabel;
}

@property (nonatomic, strong)UIScrollView *CarTypeSV;
@property (nonatomic, assign)CGFloat imageWidth;
@property (nonatomic, assign)CGFloat imageHeight;
@property (nonatomic, assign)CGFloat typeWidth;
@property (nonatomic, assign)NSInteger lastPageIndex;
@property (nonatomic, strong)MyAnnomationView *lastImageView;
@property (nonatomic, strong)NSArray *imageNameArray;
@property (nonatomic, strong)NSArray *typeArray;
@property (nonatomic, strong)UIView *labelView;
@property (nonatomic, strong)UIView *annimationSuperView;
@property (nonatomic, strong)NSMutableArray<MyAnnomationView*> *imageViewArray;

@end

@implementation ShangwuController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageNameArray = @[@"MPV",@"行政",@"奢华",@"激情",@"尊贵"];
    _typeArray =  @[@"MPV",@"行政级",@"奢华",@"激情",@"尊贵"];
    
    self.imageWidth = [UIScreen mainScreen].bounds.size.width;
    self.imageHeight = self.imageWidth*0.7;
    self.typeWidth = self.imageWidth/5.00;
    self.imageViewArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<self.imageNameArray.count; i++) {
        
        CGRect rect = CGRectMake( ScreenWidth*0.008+i*ScreenWidth*0.2, 0, ScreenWidth*0.08, ScreenWidth*0.08);
        MyAnnomationView *view = [[MyAnnomationView alloc] initWithFrame:rect typeString:self.imageNameArray[i]];
        [self.imageViewArray addObject:view];
        if (i==2) {
            
            self.lastImageView = view;
            self.lastPageIndex = 2;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transForm:)];
        [view addGestureRecognizer:tap];
    }
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*2/3)];
    image.image = [UIImage imageNamed:@"商务展示图.png"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(20, 20, 30, 30);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回白1.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:fanhui];
    
    UILabel *choiceAddress = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(image.frame)+ScreenWidth*0.03, ScreenWidth*0.8, ScreenWidth*0.1)];
    choiceAddress.text = @"匠心之作 - 专注豪华车租赁";
    choiceAddress.textColor = Color(7, 187, 177);
    choiceAddress.textAlignment = NSTextAlignmentCenter;
    choiceAddress.adjustsFontSizeToFitWidth = YES;
    choiceAddress.font = [UIFont systemFontOfSize:17];
    choiceAddress.layer.borderWidth = 1.0;
    UIColor *col = Color(7, 187, 177);
    choiceAddress.layer.borderColor = [col CGColor];
    [self.view addSubview:choiceAddress];
    
    _CarTypeSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(choiceAddress.frame), self.view.frame.size.width,self.view.frame.size.width*0.65)];
    _CarTypeSV.delegate = self;
    _CarTypeSV.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    _CarTypeSV.pagingEnabled = YES;
    _CarTypeSV.showsHorizontalScrollIndicator = NO;
    _CarTypeSV.userInteractionEnabled = YES;
    [_CarTypeSV setContentOffset:CGPointMake(self.view.frame.size.width *2, 0)];
    
    NSArray *priceArray = @[@"800元起",@"150元起",@"350元起",@"500元起",@"1500元起"];
    NSArray *chaoChuArray = @[@"20",@"5",@"10",@"15",@"50"];
    NSArray *array = @[@"埃尔法、奔驰V级、GMC、奔驰斯宾特",@"奔驰E级、宝马5系、奥迪A6",@"奔驰S级、宝马7系、奥迪A8L",@"玛莎拉蒂总裁、保时捷帕拉梅拉",@"劳斯莱斯、迈巴赫、宾利"];
    
    for (int i = 0; i < 5; i++) {
        
        CGRect rect = CGRectMake(ScreenWidth*i+ScreenWidth*0.15, ScreenWidth*0.1, ScreenWidth*0.7, ScreenWidth*0.5);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = [UIImage imageNamed:self.imageNameArray[i]];
        [_CarTypeSV addSubview:imageView];
        imageView.center = CGPointMake(ScreenWidth*(i*2+1)/2, _CarTypeSV.frame.size.height/2);
        
        
        UILabel *chexing = [[UILabel alloc] init];
        UIFont *font1 = [UIFont systemFontOfSize:14];
        chexing.text = array[i];
        chexing.font = font1;
        chexing.textColor = Color(187, 187, 187);
        chexing.textAlignment = NSTextAlignmentCenter;
        
        CGSize size = [chexing.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font1,NSFontAttributeName, nil]];
        chexing.frame = CGRectMake(ScreenWidth*i, ScreenWidth*0.02, size.width, self.view.frame.size.width*0.1);
        
        chexing.center = CGPointMake(ScreenWidth*(i*2 + 1)/2, ScreenWidth*0.06);
        
        [_CarTypeSV addSubview:chexing];
        
        UIButton *wenhao1 =[UIButton buttonWithType:UIButtonTypeCustom];
        wenhao1.frame = CGRectMake(CGRectGetMaxX(chexing.frame)+ScreenWidth*0.01, ScreenWidth*0.02, ScreenWidth*0.08, ScreenWidth*0.08);
        [wenhao1 setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
        [wenhao1 addTarget:self action:@selector(wenhao1) forControlEvents:UIControlEventTouchUpInside];
        [_CarTypeSV addSubview:wenhao1];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*i, ScreenWidth*0.52, ScreenWidth, ScreenWidth*0.1)];
        
        price.textColor = Color(77, 77, 77);
        price.textAlignment = NSTextAlignmentCenter;
        price.adjustsFontSizeToFitWidth = YES;
        price.font = [UIFont boldSystemFontOfSize:15];
        NSString *str1 = [priceArray[i] componentsSeparatedByString:@"元"][0];
        NSString *str2 = @" 元起";
        long len1 = str1.length;
        NSString *str4 = [NSString stringWithFormat:@"%@%@",str1,str2];
        NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:str4];
        [str3 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:26] range:NSMakeRange(0, len1)];
        UIColor *color = Color(255, 97, 57);
        [str3 addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, len1)];
        //        price.backgroundColor = [UIColor greenColor];
        price.attributedText = str3;
        [_CarTypeSV addSubview:price];
        
        UIButton *wenhao2 = [UIButton buttonWithType:UIButtonTypeCustom];
        wenhao2.frame = CGRectMake(ScreenWidth*i + ScreenWidth*0.65, ScreenWidth*0.538, ScreenWidth*0.08, ScreenWidth*0.08);
        [wenhao2 setBackgroundImage:[UIImage imageNamed:@"问红.png"] forState:UIControlStateNormal];
        [wenhao2 addTarget:self action:@selector(wenhao2) forControlEvents:UIControlEventTouchUpInside];
        [_CarTypeSV addSubview:wenhao2];
    }
    [self.view addSubview:_CarTypeSV];
    
    _labelView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_CarTypeSV.frame)-ScreenWidth*0.02, self.view.frame.size.width, 30)];
    _labelView.tag = 10044;
    for (int i=0; i<self.typeArray.count; i++) {
        
        CGRect rect = CGRectMake(self.typeWidth*i, 0, self.typeWidth, 30);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.text = self.typeArray[i];
        label.tag = 10033 + i;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Color(157, 157, 157);
        label.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
        if (i == 2) {
            
            label.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            label.textColor = Color(7, 187, 177);
            leixingLabel = label;
        }
        [_labelView addSubview:label];
    }
    [self.view addSubview:_labelView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(_CarTypeSV.frame)+ScreenWidth*0.1, ScreenWidth*0.9, ScreenWidth*0.08)];
    backgroundView.layer.cornerRadius = ScreenWidth*0.04;
    backgroundView.backgroundColor = Color(207, 207, 207);
    [self.view addSubview:backgroundView];
    NSInteger i=0;
    
    for (MyAnnomationView *view in self.imageViewArray) {
        [backgroundView addSubview:view];
        if (i == 2) {
            
            [view transForm];
        }
        i++;
    }
    
    UIButton *yuyue = [UIButton buttonWithType:UIButtonTypeCustom];
    yuyue.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-self.view.frame.size.width*0.1, ScreenWidth, ScreenWidth*0.1);
    [yuyue setTitle:@"立即预约" forState:UIControlStateNormal];
    [yuyue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuyue addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    yuyue.backgroundColor = Color(7, 187, 177);
    [self.view addSubview:yuyue];
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)queding{
    
    ShangWuDingdanView *view = [[ShangWuDingdanView alloc] init];
    
    CGFloat currentPostion = _CarTypeSV.contentOffset.x;
    int i = currentPostion/ScreenWidth;
    
    if (i == 0) {
        
        view.carType = @"MPV";
        view.price = @"800";
        view.priceOut = @"20";
    }else if(i == 1){
        
        view.carType = @"行政级";
        view.price = @"150";
        view.priceOut = @"5";
    }else if (i == 2){
        
        view.carType = @"奢华";
        view.price = @"350";
        view.priceOut = @"10";
    }else if (i == 3){
        
        view.carType = @"激情";
        view.price = @"500";
        view.priceOut = @"15";
    }else if(i == 4){
        
        view.carType = @"尊贵";
        view.price = @"1500";
        view.priceOut = @"50";
    }
    
    [self.navigationController pushViewController:view animated:YES];
}

-(void) initSlideView:(UIView *)backView{
    
    CGFloat sliderwidth = ScreenWidth / 5;
    _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.frame.size.height - 5, sliderwidth, 5)];
    [_sliderView setBackgroundColor:[UIColor brownColor]];
    [backView addSubview:_sliderView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    CGFloat setX = point.x;
    NSInteger index = (int)(setX/self.view.frame.size.width+0.5);
    if (index != self.lastPageIndex) {
        
        self.lastPageIndex = index;
        [self.lastImageView becomeLittle];
        [self.imageViewArray[self.lastPageIndex] transForm];
        self.lastImageView =self.imageViewArray[self.lastPageIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat currentPostion = _CarTypeSV.contentOffset.x;
    int i = currentPostion/ScreenWidth;
    
    UILabel *label = (UILabel *)[_labelView viewWithTag:10033 + i];
    label.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    label.textColor = Color(7, 187, 177);
    if (leixingLabel != label) {
        
        leixingLabel.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
        leixingLabel.textColor = Color(157, 157, 157);
    }
    leixingLabel = label;
}

- (void)transForm:(UITapGestureRecognizer *)tap{
    
    MyAnnomationView *view = (MyAnnomationView *) tap.view;
    NSInteger pageIndex = [self.imageNameArray indexOfObject:view.typeString];
    if (pageIndex == self.lastPageIndex ) {
        return;
    }else{
        
        [self.CarTypeSV setContentOffset:CGPointMake(self.view.frame.size.width*pageIndex, 0)];// animated:YES
        self.lastPageIndex = pageIndex;
    }
}
#pragma mark - 商务说明图
- (void)wenhao1{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view.tag = 10089;
    [self.view.window addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.9, ScreenWidth*0.8)];
    view2.tag = 10088;
    view2.backgroundColor = [UIColor whiteColor];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:view2];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(ScreenWidth*0.035, ScreenWidth*0.035, ScreenWidth*0.1, ScreenWidth*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(touchBeside) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.055, ScreenWidth*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"SW说明图.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-ScreenWidth*0.12, view2.frame.size.height-ScreenWidth*0.12-view2.frame.size.width*0.05, ScreenWidth*0.12, ScreenWidth*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBeside)];
    [view addGestureRecognizer:tap];
}
#pragma mark - 计费说明
- (void)wenhao2{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view.tag = 10089;
    [self.view.window addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.9, ScreenWidth*0.8)];
    view2.tag = 10088;
    view2.backgroundColor = [UIColor whiteColor];
    view2.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:view2];
    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(ScreenWidth*0.035, ScreenWidth*0.035, ScreenWidth*0.1, ScreenWidth*0.1);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [view2 addSubview:cuowu];
    [cuowu addTarget:self action:@selector(touchBeside) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.055, ScreenWidth*0.17, view2.frame.size.width, view2.frame.size.width/2)];
    image.image = [UIImage imageNamed:@"SW计费说明.png"];
    [view2 addSubview:image];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.95-ScreenWidth*0.12, view2.frame.size.height-ScreenWidth*0.12-view2.frame.size.width*0.05, ScreenWidth*0.12, ScreenWidth*0.12)];
    iconImage.image = [UIImage imageNamed:@"logo浅.png"];
    [view2 addSubview:iconImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBeside)];
    [view addGestureRecognizer:tap];
}
- (void)touchBeside{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
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
