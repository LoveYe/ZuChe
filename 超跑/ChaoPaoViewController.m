//
//  ChaoPaoViewController.m
//  ZuChe
//
//  Created by apple  on 2017/7/6.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ChaoPaoViewController.h"
#import "Header.h"
#import "MyAnnomationView.h"
#import "ChaoPaoDingDanView.h"

@interface ChaoPaoViewController ()<UIScrollViewDelegate>{
    
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

@implementation ChaoPaoViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)createPrice{
    
    if ([self.fangshi isEqualToString:@"结婚用车"] || [self.fangshi isEqualToString:@"展示拍摄"] || [self.fangshi isEqualToString:@"商务活动"]) {
        
        self.priceArray = @[@"5000",@"6000",@"8000",@"60000"];
    }else if ([self.fangshi isEqualToString:@"自驾租赁"]){
        
        self.priceArray = @[@"8000",@"10000",@"18000",@"180000"];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    leixingLabel = [[UILabel alloc] init];
    
    NSLog(@"==%@ ==%@ ==%@",self.priceArray,self.fangshi,self.jiage);
    _imageNameArray = @[@"SLS",@"迈凯伦",@"兰博基尼",@"LaFerrari"];
    _typeArray =  @[@"入门",@"专业",@"超级",@"顶级"];
    
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
    self.typeWidth = self.imageWidth/4.00;
    self.imageViewArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<self.imageNameArray.count; i++) {
        
        CGRect rect = CGRectMake( ScreenWidth*0.008+i*ScreenWidth*0.18+ScreenWidth*0.075*i, 0, ScreenWidth*0.08, ScreenWidth*0.08);
        MyAnnomationView *view = [[MyAnnomationView alloc] initWithFrame:rect typeString:self.imageNameArray[i]];
        [self.imageViewArray addObject:view];
        if (i==0) {
            
            self.lastImageView = view;
            self.lastPageIndex = 0;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transForm:)];
        [view addGestureRecognizer:tap];
    }
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*2/3)];
    image.image = [UIImage imageNamed:@"超跑展示图.png"];
    image.userInteractionEnabled = YES;
    [mianView addSubview:image];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(20, 20, 30, 30);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回白1.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:fanhui];
    
    UIColor *itemColor = Color(7, 187, 177);
    
    UILabel *choiceAddress = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, CGRectGetMaxY(image.frame)+ScreenWidth*0.03, ScreenWidth*0.8, ScreenWidth*0.1)];
    
    NSString *str = [NSString string];
    if ([self.fangshi isEqualToString:@"结婚用车"]) {
        
        str = @"结婚用车";
    }else if([self.fangshi isEqualToString:@"展示拍摄"]){
        
        str = @"展示拍摄";
    }else if ([self.fangshi isEqualToString:@"商务活动"]){
        
        str = @"商务活动";
    }else if ([self.fangshi isEqualToString:@"自驾租赁"]){
        
        str = @"自驾租赁";
    }
    
    choiceAddress.text = [NSString stringWithFormat:@"%@",self.fangshi];
    choiceAddress.textColor = itemColor;
    choiceAddress.layer.borderWidth = 0.5;
    choiceAddress.textAlignment = NSTextAlignmentCenter;
    choiceAddress.adjustsFontSizeToFitWidth = YES;
    choiceAddress.font = [UIFont systemFontOfSize:19];
    choiceAddress.layer.borderColor = [itemColor CGColor];
    choiceAddress.userInteractionEnabled = YES;
    [mianView addSubview:choiceAddress];
    
    UIImageView *shaixuan = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.8, CGRectGetMaxY(image.frame)+ScreenWidth*0.05, ScreenWidth*0.06, ScreenWidth*0.06)];
    shaixuan.image = [UIImage imageNamed:@"筛选.png"];
    [mianView addSubview:shaixuan];
    shaixuan.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoiceType:)];
    [choiceAddress addGestureRecognizer:tapGester];
    UITapGestureRecognizer *tapGester2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoiceType:)];
    [shaixuan addGestureRecognizer:tapGester2];
    
    _CarTypeSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(choiceAddress.frame), self.view.frame.size.width,self.view.frame.size.width*0.65)];
    _CarTypeSV.delegate = self;
    _CarTypeSV.contentSize = CGSizeMake(ScreenWidth * 4, 0);
    _CarTypeSV.pagingEnabled = YES;
    _CarTypeSV.showsHorizontalScrollIndicator = NO;
    [_CarTypeSV setContentOffset:CGPointMake(0, 0)];
    
    NSArray *array = @[@"奔驰SLS、宝马I8、奥迪R8",@"法拉利458、兰博基尼Huracan、迈凯伦650",@"兰博基尼Aventador、法拉利F12",@"法拉利LaFerrari、迈凯伦P1、保时捷918Spyder"];
    
    for (int i = 0; i < 4; i++) {
        
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
        
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*i+ScreenWidth*0.3, ScreenWidth*0.52, ScreenWidth*0.4, ScreenWidth*0.1)];
        price.textColor = Color(127, 127, 127);
        price.textAlignment = NSTextAlignmentCenter;
        price.adjustsFontSizeToFitWidth = YES;
        price.font = [UIFont systemFontOfSize:17];
        
        NSString *str1 = [self.priceArray[i] componentsSeparatedByString:@"/元"][0];
        NSString *str2 = @" 元/天";
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
        wenhao2.frame = CGRectMake(ScreenWidth*i + ScreenWidth*0.68, ScreenWidth*0.538, ScreenWidth*0.08, ScreenWidth*0.08);
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
        label.textColor = Color(157, 157, 157);
        label.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        if (i == 0) {
            
            label.textColor = Color(7, 187, 177);
            label.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            leixingLabel = label;
        }
        [_labelView addSubview:label];
    }
    [mianView addSubview:_labelView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.07, CGRectGetMaxY(_CarTypeSV.frame)+ScreenWidth*0.07, ScreenWidth*0.86, ScreenWidth*0.08)];
    backgroundView.layer.cornerRadius = ScreenWidth*0.04;
    backgroundView.backgroundColor = Color(237, 237, 237);
    [mianView addSubview:backgroundView];
    NSInteger i=0;
    
    for (MyAnnomationView *view in self.imageViewArray) {
        [backgroundView addSubview:view];
        if (i == 0) {
            
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
    
    NSLog(@" --- %d",i);
    
    //    UIView *view1 =  [self.view viewWithTag:10044];
    UILabel *label = (UILabel *)[_labelView viewWithTag:10033 + i];
    label.textColor = Color(7, 187, 177);
    label.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    if (leixingLabel != label) {
        
        leixingLabel.textColor = Color(157, 157, 157);
        leixingLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
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
    
    ChaoPaoDingDanView *view = [[ChaoPaoDingDanView alloc] init];
    
    view.fangshi = self.fangshi;
    
    CGFloat currentPostion = _CarTypeSV.contentOffset.x;
    int i = currentPostion/ScreenWidth;
    
    if (i == 0) {
        
        view.cartype = @"入门";
        view.price = self.priceArray[0];
        view.outPrice = @"1000/100";
    }else if(i == 1){
        
        view.cartype = @"专业";
        view.price = self.priceArray[1];
        view.outPrice = @"1000/100";
    }else if (i == 2){
        
        view.cartype = @"超级";
        view.price = self.priceArray[2];
        view.outPrice = @"1000/100";
    }else if (i == 3){
        
        view.cartype = @"顶级";
        view.price = self.priceArray[3];
        view.outPrice = @"10000/1000";
    }
    
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 重新选择接送筛选
- (void)ChoiceType:(NSString *)sender{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    view.tag = 10089;
    [self.view.window addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.3, ScreenWidth*0.9, ScreenWidth*0.85)];
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
    
    UILabel *yongtu = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.8, ScreenWidth*0.08)];
    yongtu.text =@"请选择用途";
    yongtu.textColor = Color(77, 77, 77);
    yongtu.textAlignment = NSTextAlignmentCenter;
    yongtu.font = [UIFont boldSystemFontOfSize:19];
    [view2 addSubview:yongtu];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(yongtu.frame)+ScreenWidth*0.04, ScreenWidth*0.9, 0.7)];
    xian.backgroundColor = Color(207, 207, 207);
    [view2 addSubview:xian];
    
    UIColor *color = Color(7, 187, 177);
    NSArray *array = @[@"结婚用车",@"展示拍摄",@"商务活动",@"自驾租赁"];
    for (int i = 0; i < 4; i++) {
        
        UIButton *fangshi = [UIButton buttonWithType:UIButtonTypeCustom];
        fangshi.frame = CGRectMake(ScreenWidth * 0.15, CGRectGetMaxY(yongtu.frame)+ScreenWidth*0.1 + i*ScreenWidth*0.15, ScreenWidth*0.6, ScreenWidth*0.1);
        [fangshi setTitle:array[i] forState:UIControlStateNormal];
        [fangshi setTitleColor:color forState:UIControlStateNormal];
        fangshi.layer.borderColor = [color CGColor];
        fangshi.layer.borderWidth = 1;
        [view2 addSubview:fangshi];
        [fangshi addTarget:self action:@selector(yongtuxuanze:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)removeAll{
    
    UIView *view1 = (UIView *)[self.view.window viewWithTag:10089];
    [view1 removeFromSuperview];
}

- (void)yongtuxuanze:(UIButton *)sender{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
    
    UIView *view2 = [self.view viewWithTag:10086];
    [view2 removeFromSuperview];
    
    self.fangshi = sender.titleLabel.text;
    
    [self createPrice];
    [self createMainView];
}
#pragma mark - 
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
    image.image = [UIImage imageNamed:@"超跑说明图.png"];
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
