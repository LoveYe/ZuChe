//
//  JieSongViewController.m
//  ZuChe
//
//  Created by apple  on 2017/7/6.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "JieSongViewController.h"
#import "Header.h"
#import "MyAnnomationView.h"
#import "JieSongDanView.h"

@interface JieSongViewController ()<UIScrollViewDelegate>{
    
    UIView *_sliderView;
    UILabel *leixingLabel;
    UIButton *jie;
    UIButton *song;
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

@implementation JieSongViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)createPrice{
    
    if ([self.address isEqualToString:@"虹桥机场T1"] || [self.address isEqualToString:@"虹桥机场T2"] || [self.address isEqualToString:@"上海南站"] || [self.address isEqualToString:@"虹桥火车站"]) {
        
        self.priceArray = @[@"1000",@"300",@"600",@"800",@"3000"];
    }else if ([self.address isEqualToString:@"浦东机场T2"] || [self.address isEqualToString:@"浦东机场T1"]){
        
        self.priceArray = @[@"1500",@"350",@"700",@"1000",@"3500"];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    leixingLabel = [[UILabel alloc] init];
    
    NSLog(@"==%@ ==%@ ==%@",self.priceArray,self.jiesong,self.address);
    _imageNameArray = @[@"MPV",@"行政",@"奢华",@"激情",@"尊贵"];
    _typeArray =  @[@"MPV",@"行政级",@"奢华",@"激情",@"尊贵"];
    
    [self createPrice];
    [self createMainView];
}
- (void)createMainView{
    
    
    
    UIView *mianView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mianView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mianView];
    mianView.tag = 10086;
    
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
    [mianView addSubview:image];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(20, 20, 30, 30);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回白1.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:fanhui];
    
    UIColor *itemColor = Color(7, 187, 177);
    UILabel *choiceAddress = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(image.frame)+ScreenWidth*0.03, ScreenWidth*0.8, ScreenWidth*0.12)];
    
    NSString *str = [NSString string];
    if ([self.jiesong isEqualToString:@"jie"]) {
        
        str = @"接机";
    }else{
        
        str = @"送机";
    }
    
    choiceAddress.text = [NSString stringWithFormat:@"%@ >%@",self.address,str];
    choiceAddress.textColor = itemColor;
    choiceAddress.layer.borderWidth = 1;
    choiceAddress.textAlignment = NSTextAlignmentCenter;
    choiceAddress.adjustsFontSizeToFitWidth = YES;
    choiceAddress.font = [UIFont systemFontOfSize:19];
    choiceAddress.layer.borderColor = [itemColor CGColor];
    [mianView addSubview:choiceAddress];
    choiceAddress.userInteractionEnabled = YES;
    
    UIImageView *shaixuan = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.8, CGRectGetMaxY(image.frame)+ScreenWidth*0.06, ScreenWidth*0.06, ScreenWidth*0.06)];
    shaixuan.image = [UIImage imageNamed:@"筛选.png"];
    [mianView addSubview:shaixuan];
    shaixuan.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGester1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoiceType:)];
    [choiceAddress addGestureRecognizer:tapGester1];
    UITapGestureRecognizer *tapGester2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoiceType:)];
    [shaixuan addGestureRecognizer:tapGester2];
    
    _CarTypeSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(choiceAddress.frame), self.view.frame.size.width,self.view.frame.size.width*0.65)];
    _CarTypeSV.delegate = self;
    _CarTypeSV.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    _CarTypeSV.pagingEnabled = YES;
    _CarTypeSV.showsHorizontalScrollIndicator = NO;
    [_CarTypeSV setContentOffset:CGPointMake(self.view.frame.size.width *2, 0)];
    
    NSArray *array = @[@"埃尔法、奔驰V级、GMC、奔驰斯宾特",@"奔驰E级、宝马5系、奥迪A6",@"奔驰S级、宝马7系、奥迪A8L",@"玛莎拉蒂总裁、保时捷帕拉梅拉",@"劳斯莱斯、迈巴赫、宾利"];
    
    for (int i = 0; i < 5; i++) {
        
        CGRect rect = CGRectMake(ScreenWidth*i+ScreenWidth*0.15, ScreenWidth*0.1, ScreenWidth*0.7, ScreenWidth*0.5);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = [UIImage imageNamed:self.imageNameArray[i]];
        [_CarTypeSV addSubview:imageView];
        imageView.center = CGPointMake(ScreenWidth*(i*2+1)/2, _CarTypeSV.frame.size.height/2);
        
        UILabel *chexing = [[UILabel alloc] init];
        chexing.text = array[i];
        chexing.textColor = Color(187, 187, 187);
        chexing.textAlignment = NSTextAlignmentCenter;
        chexing.adjustsFontSizeToFitWidth = YES;
        UIFont *font1 = [UIFont systemFontOfSize:14];
        chexing.font = font1;
        
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
        NSString *str1 = self.priceArray[i];
        NSString *str2 = @" 元/次";
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
    [mianView addSubview:_CarTypeSV];
//    [mianView addSubview:self.labelView];
    _labelView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_CarTypeSV.frame)-ScreenWidth*0.02, self.view.frame.size.width, 30)];
    _labelView.tag = 10044;
    for (int i=0; i<self.typeArray.count; i++) {
        
        CGRect rect = CGRectMake(self.typeWidth*i, 0, self.typeWidth, 30);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.text = self.typeArray[i];
        label.tag = 10033 + i;
        label.textAlignment = NSTextAlignmentCenter;
        label.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
        label.textColor = Color(157, 157, 157);
        if (i == 2) {
            
            label.textColor = Color(7, 187, 177);;
            label.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            leixingLabel = label;
        }
        [_labelView addSubview:label];
    }
    [mianView addSubview:_labelView];
    
//    [mianView addSubview:self.annimationSuperView];
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(_CarTypeSV.frame)+ScreenWidth*0.07, ScreenWidth*0.9, ScreenWidth*0.08)];
    backgroundView.layer.cornerRadius = ScreenWidth*0.04;
    backgroundView.backgroundColor = Color(207, 207, 207);
    [mianView addSubview:backgroundView];
    NSInteger i=0;
    
    for (MyAnnomationView *view in self.imageViewArray) {
        [backgroundView addSubview:view];
        if (i == 2) {
            
            [view transForm];
        }
        i++;
    }
    
    UIButton *yuyue = [UIButton buttonWithType:UIButtonTypeCustom];
    yuyue.frame = CGRectMake(0, ScreenHeight-ScreenWidth*0.1, ScreenWidth, ScreenWidth*0.1);
    [yuyue setTitle:@"立即预约" forState:UIControlStateNormal];
    [yuyue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuyue addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    yuyue.backgroundColor = Color(7, 187, 177);
    [mianView addSubview:yuyue];
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
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
        
        leixingLabel.textColor = Color(157, 157, 157);
        leixingLabel.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
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
- (void)queding{
    
    JieSongDanView *view = [[JieSongDanView alloc] init];
    
    view.getOrSend = self.jiesong;
    view.finalAddress = self.address;
    
    CGFloat currentPostion = _CarTypeSV.contentOffset.x;
    int i = currentPostion/ScreenWidth;
    
    if (i == 0) {
        
        view.cartype = @"MPV";
        view.price = self.priceArray[0];
        view.outPrice = @"200/20";
    }else if(i == 1){
        
        view.cartype = @"行政级";
        view.price = self.priceArray[1];
        view.outPrice = @"50/5";
    }else if (i == 2){
        
        view.cartype = @"奢华";
        view.price = self.priceArray[2];
        view.outPrice = @"100/10";
    }else if (i == 3){
        
        view.cartype = @"激情";
        view.price = self.priceArray[3];
        view.outPrice = @"150/15";
    }else if(i == 4){
        
        view.cartype = @"尊贵";
        view.price = self.priceArray[4];
        view.outPrice = @"300/30";
    }
    
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 重新选择接送筛选
- (void)ChoiceType:(NSString *)sender{
    
    _jiesong = @"";
    _address = @"";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view.tag = 10089;
    [self.view.window addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.075, ScreenWidth*0.3, ScreenWidth*0.85, ScreenWidth*0.88)];
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
    [cuowu addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:cuowu];
    
    UILabel *yongtuXZ = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.2, ScreenWidth*0.04, view2.frame.size.width*0.6, ScreenWidth*0.1)];
    yongtuXZ.text = @"请选择用途";
    yongtuXZ.textColor = Color(77, 77, 77);
    yongtuXZ.textAlignment = NSTextAlignmentCenter;
    yongtuXZ.font = [UIFont boldSystemFontOfSize:19];
    yongtuXZ.adjustsFontSizeToFitWidth = YES;
    [view2 addSubview:yongtuXZ];
    
    UILabel *xian0 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(yongtuXZ.frame)+ScreenWidth*0.03, view2.frame.size.width*0.9, 0.7)];
    xian0.backgroundColor = Color(207, 207, 207);
    [view2 addSubview:xian0];
    
    UIColor *color = Color(7, 187, 177);
    jie = [UIButton buttonWithType:UIButtonTypeCustom];
    jie.frame = CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(xian0.frame)+ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.1);
    jie.backgroundColor = [UIColor whiteColor];
    [jie setTitle:@"接机" forState:UIControlStateNormal];
    [jie setTitleColor:color forState:UIControlStateNormal];
    jie.layer.borderWidth = 1;
    jie.titleLabel.font = [UIFont systemFontOfSize:20];
    [jie addTarget:self action:@selector(jieji:) forControlEvents:UIControlEventTouchUpInside];
    jie.layer.borderColor = [color CGColor];
    [view2 addSubview:jie];
    
    song = [UIButton buttonWithType:UIButtonTypeCustom];
    song.frame = CGRectMake(ScreenWidth*0.45, CGRectGetMaxY(xian0.frame)+ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.1);
    song.backgroundColor = [UIColor whiteColor];
    [song setTitle:@"送机" forState:UIControlStateNormal];
    [song setTitleColor:color forState:UIControlStateNormal];
    song.layer.borderWidth = 1;
    song.titleLabel.font = [UIFont systemFontOfSize:20];
    [song addTarget:self action:@selector(songji:) forControlEvents:UIControlEventTouchUpInside];
    song.layer.borderColor = [color CGColor];
    [view2 addSubview:song];
    
    UILabel *xian1 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width*0.05, CGRectGetMaxY(jie.frame)+ScreenWidth*0.05, view2.frame.size.width*0.9, 0.7)];
    xian1.backgroundColor = Color(207, 207, 207);
    [view2 addSubview:xian1];
    
    NSArray *array = @[@"虹桥机场T1",@"虹桥机场T2",@"浦东机场T1",@"浦东机场T2",@"上海南站",@"虹桥火车站"];
    for (int i = 0; i < 6; i++) {
        
        if (i %2 == 0) {
            
            UIButton *jichang = [UIButton buttonWithType:UIButtonTypeCustom];
            jichang.frame = CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(xian1.frame)+ScreenWidth*0.05+ (i/2)*ScreenWidth*0.15 , ScreenWidth*0.3, ScreenWidth*0.1);
            [jichang setTitle:array[i] forState:UIControlStateNormal];
            [jichang setTitleColor:color forState:UIControlStateNormal];
            jichang.layer.borderWidth = 1;
            jichang.tag = 10022+i;
            [jichang addTarget:self action:@selector(jichangmingzi:) forControlEvents:UIControlEventTouchUpInside];
            jichang.layer.borderColor = [color CGColor];
            [view2 addSubview:jichang];
        }else{
            
            UIButton *jichang = [UIButton buttonWithType:UIButtonTypeCustom];
            jichang.frame = CGRectMake(ScreenWidth*0.45, CGRectGetMaxY(xian1.frame)+ScreenWidth*0.05+ ((i-1)/2)*ScreenWidth*0.15, ScreenWidth*0.3, ScreenWidth*0.1);
            [jichang setTitle:array[i] forState:UIControlStateNormal];
            [jichang setTitleColor:color forState:UIControlStateNormal];
            jichang.layer.borderWidth = 1;
            jichang.tag = 10022+i;
            [jichang addTarget:self action:@selector(jichangmingzi:) forControlEvents:UIControlEventTouchUpInside];
            jichang.layer.borderColor = [color CGColor];
            [view2 addSubview:jichang];
        }
    }
}
- (void)jieji:(UIButton *)sender{
    
    UIColor *color = Color(7, 187, 177);
    sender.backgroundColor = color;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    song.backgroundColor = [UIColor whiteColor];
    [song setTitleColor:color forState:UIControlStateNormal];
    
    _jiesong = @"jie";
    
    if (!(_address == nil || [_address isEqualToString:@""])) {
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
        
        UIView *view2 = [self.view viewWithTag:10086];
        [view2 removeFromSuperview];
        
        [self createPrice];
        [self createMainView];
    }
}
- (void)songji:(UIButton *)sender{
    
    UIColor *color = Color(7, 187, 177);
    sender.backgroundColor = color;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    jie.backgroundColor = [UIColor whiteColor];
    [jie setTitleColor:color forState:UIControlStateNormal];
    
    _jiesong = @"song";
    
    if (!(_address == nil || [_address isEqualToString:@""])) {
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
        
        UIView *view2 = [self.view viewWithTag:10086];
        [view2 removeFromSuperview];
        
        [self createPrice];
        [self createMainView];
    }
    
}
- (void)jichangmingzi:(UIButton *)sender{
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = Color(7, 187, 177);
    
    _address = sender.titleLabel.text;
    
    float a = sender.tag - 10022;
    
    UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
    UIView *view2 = [view1 viewWithTag:10088];
    for (int i = 0; i < 6; i++) {
        
        if (a != i) {
            
            UIColor *color2 = Color(7, 187, 177);
            UIButton *button = (UIButton *)[view2 viewWithTag:10022+i];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:color2 forState:UIControlStateNormal];
        }
    }
    
    if (!(_jiesong == nil || [_jiesong isEqualToString:@""])){
        
        UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
        [view1 removeFromSuperview];
        
        UIView *view2 = [self.view viewWithTag:10086];
        [view2 removeFromSuperview];
        
        [self createPrice];
        [self createMainView];
    }
}
- (void)IKnowHowtoDo{
    
    UIView *view1 = (UIView *)[self.view.window viewWithTag:10084];
    [view1 removeFromSuperview];
}
- (void)removeAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
}

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
    image.image = [UIImage imageNamed:@"接送价格说明.png"];
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
