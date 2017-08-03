//
//  ChangbaoDTCell.m
//  ZuChe
//
//  Created by apple  on 2017/7/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#define CarDetailInfo @"http://wx.leisurecarlease.com/api.php?op=api_cartypexq"
#define PAGE_OFFSET 50

#import "ChangbaoDTCell.h"
#import "Header.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "WMConversationViewController.h"
#import "AFNetworking.h"
#import "RCUserInfo+Addition.h"
#import "RCDataManager.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation ChangbaoDTCell

{
    
    UIImageView *cartu;
    UIView *balckView;
    UILabel *price;
    UILabel *hours;
    UILabel *kms;
    
    UILabel *name;
    UILabel *chaochu;
    UIImageView *icon;
    
    UILabel *fuwu;
    UILabel *waiguan;
    UILabel *neishi;
    
    UILabel *waiguanXing;
    UILabel *neishiXing;
    UILabel *fuwuXing;
    
    UIImageView *star;
    UIImageView *star1;
    UIImageView *star2;
    UIImageView *star3;
    UIImageView *star4;
    UIImageView *star5;
    UIImageView *star6;
    UIImageView *star7;
    UIImageView *star8;
    UIImageView *star9;
    UIImageView *star10;
    UIImageView *star11;
    UIImageView *star12;
    UIImageView *star13;
    UIImageView *star14;
    UIImageView *star15;
    
    
    UILabel *jieshao1;
    UILabel *jieshao2;
    UILabel *jieshao3;
    UILabel *jieshao4;
    UILabel *jieshao5;
    
    UILabel *pingjia;
    
    UIView *ditu;
    
    UILabel *fuwuCenter;
    
    UILabel *erweima;
    UIImageView *erweimaDa;
    
    UIView *xiangsi;
    UILabel *xsCar;
    
    UIButton *yuding;
    
    UIScrollView *scrollView;
    
    UILabel *xian1;
    UILabel *xian2;
    UILabel *xian3;
    UILabel *xian4;
    UILabel *xian5;
    
    UIImageView *jiantou1;
    UIImageView *jiantou2;
    
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *array4;
    NSMutableArray *array5;
    NSMutableArray *array6;
    NSMutableArray *array7;
    NSMutableArray *array8;
    
    NSString *carID;
    
    NSDictionary *dict;
    NSDictionary *dict2;
    NSMutableArray *dict3;
    
    bool isGeoSearch;
    AMapSearchAPI* _geocodesearch;
    
    float x;
    float y;
    
    WSStarRatingView *_wsStraRating;
    WSStarRatingView *_wsStraRating1;
    WSStarRatingView *_wsStraRating2;
    WSStarRatingView *_wsStraRating3;
    
    UIView *bigView1;
    UIView *bigView2;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self reloadView];
    }
    return self;
}

- (void)reloadView{
    
    _geocodesearch = [[AMapSearchAPI alloc] init];
    _geocodesearch.delegate = self;
    
    name = [[UILabel alloc] init];
    [self.contentView addSubview:name];
    chaochu = [[UILabel alloc] init];
    [self.contentView addSubview:chaochu];

    icon = [[UIImageView alloc] init];
    [self.contentView addSubview:icon];
    
    xian1 = [[UILabel alloc] init];
    [self.contentView addSubview:xian1];
    
    fuwu = [[UILabel alloc] init];
    [self.contentView addSubview:fuwu];
    waiguan = [[UILabel alloc] init];
    [self.contentView addSubview:waiguan];
    neishi = [[UILabel alloc] init];
    [self.contentView addSubview:neishi];
    
    waiguanXing = [UILabel new];
    neishiXing = [UILabel new];
    fuwuXing = [UILabel new];
    [self.contentView addSubview:waiguanXing];
    [self.contentView addSubview:neishiXing];
    [self.contentView addSubview:fuwuXing];
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10, -5000, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating];
    
    _wsStraRating1 = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10, 50, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating1];
    
    _wsStraRating2 = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10, 50, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating2];
    
    _wsStraRating3 = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10, 50, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating3];
    
    xian2 = [[UILabel alloc] init];
    [self.contentView addSubview:xian2];
//    star = [[UIImageView alloc] init];
//    [self.contentView addSubview:star];
//    star2 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star2];
//    star3 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star3];
//    star4 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star4];
//    star5 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star5];
//    star6 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star6];
//    star7 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star7];
//    star8 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star8];
//    star9 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star9];
//    star10 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star10];
//    star11 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star11];
//    star12 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star12];
//    star13 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star13];
//    star14 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star14];
//    star15 = [[UIImageView alloc] init];
//    [self.contentView addSubview:star15];
    
    jieshao1 = [[UILabel alloc] init];
    [self.contentView addSubview:jieshao1];
    jieshao2 = [[UILabel alloc] init];
    [self.contentView addSubview:jieshao2];
    jieshao3 = [[UILabel alloc] init];
    [self.contentView addSubview:jieshao3];
    jieshao4 = [[UILabel alloc] init];
    [self.contentView addSubview:jieshao4];
    jieshao5 = [[UILabel alloc] init];
    [self.contentView addSubview:jieshao5];

    bigView1 = [UIView new];
    [self.contentView addSubview:bigView1];
    
    
    
    bigView2 = [UIView new];
    [self.contentView addSubview:bigView2];
    
    jiantou1 = [UIImageView new];
    [bigView1 addSubview:jiantou1];
    
    jiantou2 = [UIImageView new];
    [bigView2 addSubview:jiantou2];
    
    xian3 = [[UILabel alloc] init];
    [self.contentView addSubview:xian3];
    
    pingjia = [[UILabel alloc] init];
    [bigView1 addSubview:pingjia];
    
    ditu = [[UIView alloc] init];
    [self.contentView addSubview:ditu];
    
    fuwuCenter = [[UILabel alloc] init];
    [bigView2 addSubview:fuwuCenter];
    
    erweima = [[UILabel alloc] init];
    [self.contentView addSubview:erweima];
    erweimaDa = [[UIImageView alloc] init];
    [self.contentView addSubview:erweimaDa];
    
    xiangsi = [[UIView alloc] init];
    [self.contentView addSubview:xiangsi];
    
    xsCar = [UILabel new];
    [self.contentView addSubview:xsCar];
    
    yuding = [[UIButton alloc] init];
    [self.contentView addSubview:yuding];
    
    xian4 = [[UILabel alloc] init];
    [self.contentView addSubview:xian4];
    
    xian5 = [[UILabel alloc] init];
    [self.contentView addSubview:xian5];
    
    self.iCarousel = [[iCarousel alloc] init];
    [self.contentView addSubview:self.iCarousel];
    
    
    array1 = [NSMutableArray array];
    array2 = [NSMutableArray array];
    array3 = [NSMutableArray array];
    array4 = [NSMutableArray array];
    array5 = [NSMutableArray array];
    array6 = [NSMutableArray array];
    array7 = [NSMutableArray array];
    array8 = [NSMutableArray array];
    
    dict  = [NSDictionary dictionary];
    dict2 = [NSDictionary dictionary];
    dict3 = [NSMutableArray array];
}
- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    
    dict = _model[@"state"];
    dict2 = _model[@"carinfo"];
    [dict3 addObjectsFromArray:_model[@"xscarlist"]];
    
    [self customView];
    [self onClick:[NSString stringWithFormat:@"%@",dict2[@"address"]]];
}

- (void)customView{
    
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = Color(77, 77, 77);
    name.text = [NSString stringWithFormat:@"%@ From %@",dict2[@"cartype"],dict2[@"nickname"]];
    name.font = [UIFont systemFontOfSize:17];
    
    chaochu.text = [NSString stringWithFormat:@"超出： %@/小时，%@/公里",dict2[@"jiage2"],dict2[@"jiage3"]];
    chaochu.textAlignment = NSTextAlignmentLeft;
    chaochu.textColor = Color(107, 107, 107);
    chaochu.font = [UIFont systemFontOfSize:17];
    
    //    icon = self.iconImage;
    //    icon.backgroundColor = [UIColor greenColor];
    icon.image = [UIImage imageNamed:@"头像.png"];
    
    xian1.backgroundColor = Color(237, 237, 237);
    
    waiguan.text = @"外观";
    waiguan.textColor = Color(77, 77, 77);
    waiguan.textAlignment = NSTextAlignmentLeft;
    waiguan.font = [UIFont systemFontOfSize:18];
    
    fuwu.text = @"服务";
    fuwu.textColor = Color(77, 77, 77);
    fuwu.textAlignment = NSTextAlignmentLeft;
    fuwu.font = [UIFont systemFontOfSize:18];
    
    neishi.text = @"内饰";
    neishi.textColor = Color(77, 77, 77);
    neishi.textAlignment = NSTextAlignmentLeft;
    neishi.font = [UIFont systemFontOfSize:18];
    
    waiguanXing.text = [NSString stringWithFormat:@"%@.0",dict2[@"wgxing"]];
    waiguanXing.textColor = Color(107, 107, 107);
    waiguanXing.textAlignment = NSTextAlignmentLeft;
    waiguanXing.adjustsFontSizeToFitWidth = YES;
    waiguanXing.font = [UIFont systemFontOfSize:12];
    
    neishiXing.text = [NSString stringWithFormat:@"%@.0",dict2[@"nsxing"]];
    neishiXing.textColor = Color(107, 107, 107);
    neishiXing.textAlignment = NSTextAlignmentLeft;
    neishiXing.adjustsFontSizeToFitWidth = YES;
    neishiXing.font = [UIFont systemFontOfSize:12];
    
    fuwuXing.text = [NSString stringWithFormat:@"%@.0",dict2[@"fwxing"]];
    fuwuXing.textColor = Color(107, 107, 107);
    fuwuXing.textAlignment = NSTextAlignmentLeft;
    fuwuXing.adjustsFontSizeToFitWidth = YES;
    fuwuXing.font = [UIFont systemFontOfSize:12];
    
//    star.image = [UIImage imageNamed:@"五角星.png"];
//    star2.image = [UIImage imageNamed:@"五角星.png"];
//    star3.image = [UIImage imageNamed:@"五角星.png"];
//    star4.image = [UIImage imageNamed:@"五角星.png"];
//    star5.image = [UIImage imageNamed:@"五角星.png"];
//    star6.image = [UIImage imageNamed:@"五角星.png"];
//    star7.image = [UIImage imageNamed:@"五角星.png"];
//    star8.image = [UIImage imageNamed:@"五角星.png"];
//    star9.image = [UIImage imageNamed:@"五角星.png"];
//    star10.image = [UIImage imageNamed:@"五角星.png"];
//    star11.image = [UIImage imageNamed:@"五角星.png"];
//    star12.image = [UIImage imageNamed:@"五角星.png"];
//    star13.image = [UIImage imageNamed:@"五角星.png"];
//    star14.image = [UIImage imageNamed:@"五角星.png"];
//    star15.image = [UIImage imageNamed:@"五角星.png"];
    
    xian2.backgroundColor = Color(237, 237, 237);
    
    
        jieshao1.text = @"费用为长包每月的车辆使用费用";
        jieshao1.textColor = Color(107, 107, 107);
        jieshao1.textAlignment = NSTextAlignmentLeft;
        jieshao1.font = [UIFont systemFontOfSize:17];
        
        jieshao2.text = @"含车辆用油、驾驶服务、车辆使用";
        jieshao2.textColor = Color(107, 107, 107);
        jieshao2.textAlignment = NSTextAlignmentLeft;
        jieshao2.font = [UIFont systemFontOfSize:17];
        
        jieshao3.text = @"不含路桥费、停车费等其他费用";
        jieshao3.textColor = Color(107, 107, 107);
        jieshao3.textAlignment = NSTextAlignmentLeft;
        jieshao3.font = [UIFont systemFontOfSize:17];
        
        jieshao4.text = @"超出限制里程按超出标准计费";
        jieshao4.textColor = Color(107, 107, 107);
        jieshao4.textAlignment = NSTextAlignmentLeft;
        jieshao4.font = [UIFont systemFontOfSize:17];
        
        jieshao5.text = @"超出工作时间按超出标准计费";
        jieshao5.textColor = Color(107, 107, 107);
        jieshao5.textAlignment = NSTextAlignmentLeft;
        jieshao5.font = [UIFont systemFontOfSize:17];
    
    
    xian3.backgroundColor = Color(237, 237, 237);
    
    //    bigView1.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Click1)];
    [bigView1 addGestureRecognizer:tap1];
    
    //    bigView2.backgroundColor = [UIColor greenColor];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Click2)];
    [bigView2 addGestureRecognizer:tap2];
    
    pingjia.text = [NSString stringWithFormat:@"%@条评价",dict2[@"pj_count"]];
    pingjia.textColor = Color(77, 77, 77);
    pingjia.font = [UIFont systemFontOfSize:17];
    pingjia.textAlignment = NSTextAlignmentLeft;
    
    xian4.backgroundColor = Color(237, 237, 237);
    
    jiantou1.image = [UIImage imageNamed:@"右(1).png"];
    jiantou2.image = [UIImage imageNamed:@"右(1).png"];
    
    fuwuCenter.text = @"服务中心";
    fuwuCenter.textAlignment = NSTextAlignmentLeft;
    fuwuCenter.textColor = Color(77, 77, 77);
    fuwuCenter.font = [UIFont systemFontOfSize:17];
    
    xian5.backgroundColor = Color(237, 237, 237);
    
    erweima.textColor = Color(77, 77, 77);
    erweima.text = @"车辆二维码";
    erweima.textAlignment = NSTextAlignmentLeft;
    erweima.font = [UIFont systemFontOfSize:17];
    
    //    erweimaDa.image = [UIImage imageNamed:@""];
    //    erweimaDa.backgroundColor = [UIColor redColor];
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSString *url = [NSString stringWithFormat:@"http://wx.leisurecarlease.com/index.php?m=content&c=index&a=car_det&carid=%@&type=%@",dict[@"carid"],dict[@"type"]];
    
//    NSString *url1 = @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks";
    NSData *data=[url dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    
    erweimaDa.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    // ********************** 二维码结束
    xiangsi.backgroundColor = Color(57, 57, 57);
    
    xsCar.text = @"相似车源";
    xsCar.textColor = [UIColor whiteColor];
    xsCar.textAlignment = NSTextAlignmentLeft;
    xsCar.font = [UIFont systemFontOfSize:17];
    
    
    //    YdButtonClick:
    
    
    self.iCarousel.delegate = self;
    self.iCarousel.dataSource = self;
    self.iCarousel.bounces = NO;
    self.iCarousel.pagingEnabled = YES;
    self.iCarousel.type = iCarouselTypeCustom;
    
//    _wsStraRating.delegate = self;
    _wsStraRating1.delegate = self;
    _wsStraRating2.delegate = self;
    _wsStraRating3.delegate = self;
    
    float a = [dict2[@"wgxing"] doubleValue];
    float b = [dict2[@"nsxing"] doubleValue];
    float c = [dict2[@"fwxing"] doubleValue];
    
//    __block PjDemoTableViewCell *detaCell = self;
    
    [_wsStraRating1 setScore:a/5 withAnimation:YES completion:^(BOOL finished) {
//        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",a/5 * 5 ];
    }];
    [_wsStraRating2 setScore:b/5 withAnimation:YES completion:^(BOOL finished) {
        //        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",a/5 * 5 ];
    }];
    [_wsStraRating3 setScore:c/5 withAnimation:YES completion:^(BOOL finished) {
        //        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",a/5 * 5 ];
    }];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    
    name.frame = CGRectMake(width*0.05, width*0.05, width*0.65, width*0.1);
    chaochu.frame = CGRectMake(width*0.05, CGRectGetMaxY(name.frame), width*0.65, width*0.1);

    icon.frame = CGRectMake(CGRectGetMaxX(name.frame)+width*0.05, width*0.05, width*0.2, width*0.2);
    icon.layer.cornerRadius = width*0.1;
    icon.layer.masksToBounds = YES;

    xian1.frame = CGRectMake(0, CGRectGetMaxY(chaochu.frame)+width*0.05, width, 1);
    
    waiguan.frame = CGRectMake(width*0.05, CGRectGetMaxY(xian1.frame)+width*0.05, width*0.2, width*0.15);
    neishi.frame = CGRectMake(width*0.35, CGRectGetMaxY(xian1.frame)+width*0.05, width*0.2, width*0.15);
    fuwu.frame   = CGRectMake(width*0.65, CGRectGetMaxY(xian1.frame)+width*0.05, width*0.2, width*0.15);
    waiguanXing.frame = CGRectMake(width*0.22, CGRectGetMaxY(waiguan.frame)-width*0.025, width*0.06, width*0.08);
    neishiXing.frame = CGRectMake(width*0.52, CGRectGetMaxY(neishi.frame)-width*0.025, width*0.06, width*0.08);
    fuwuXing.frame = CGRectMake(width*0.82, CGRectGetMaxY(fuwu.frame)-width*0.025, width*0.06, width*0.08);
    
    _wsStraRating1.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame)-width*0.005, width*0.15, width*0.03);
    _wsStraRating2.frame = CGRectMake(width*0.35, CGRectGetMaxY(waiguan.frame)-width*0.005, width*0.15, width*0.03);
    _wsStraRating3.frame = CGRectMake(width*0.65, CGRectGetMaxY(waiguan.frame)-width*0.005, width*0.15, width*0.03);

    //    NSString *nei = dict2[@"nsxing"];
//    NSString *fu = dict2[@"nsxing"];
//    NSString *wai = dict2[@"wgxing"];
//    float a = [wai intValue];
//    float b = [nei intValue];
//    float c = [fu intValue];
//    
//    _wsStraRating.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame), width*0.15, width*0.03);
////    if (a == 5) {
////        
////        star.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star2.frame =CGRectMake(width*0.08, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star3.frame =CGRectMake(width*0.11, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star4.frame = CGRectMake(width*0.14, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star5.frame = CGRectMake(width*0.17, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////    }if (a == 4) {
////        star.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star2.frame =CGRectMake(width*0.08, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star3.frame =CGRectMake(width*0.11, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star4.frame = CGRectMake(width*0.14, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////    }if (a == 3) {
////        star.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star2.frame =CGRectMake(width*0.08, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star3.frame =CGRectMake(width*0.11, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////    }if (a == 2) {
////        star.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////        star2.frame =CGRectMake(width*0.08, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////    }if (a == 1) {
////        star.frame = CGRectMake(width*0.05, CGRectGetMaxY(waiguan.frame), width*0.03, width*0.03);
////    }
//    
//    if (b == 5) {
//        
//        star6.frame = CGRectMake(width*0.35, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star7.frame =CGRectMake(width*0.38, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star8.frame =CGRectMake(width*0.41, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star9.frame = CGRectMake(width*0.44, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star10.frame = CGRectMake(width*0.47, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//    }if (b == 4) {
//        star6.frame = CGRectMake(width*0.35, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star7.frame =CGRectMake(width*0.38, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star8.frame =CGRectMake(width*0.41, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star9.frame = CGRectMake(width*0.44, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//    }if (b == 3) {
//        star6.frame = CGRectMake(width*0.35, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star7.frame =CGRectMake(width*0.38, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star8.frame =CGRectMake(width*0.41, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//    }if (b == 2) {
//        star6.frame = CGRectMake(width*0.35, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//        star7.frame =CGRectMake(width*0.38, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//    }if (b == 1) {
//        star6.frame = CGRectMake(width*0.35, CGRectGetMaxY(neishi.frame), width*0.03, width*0.03);
//    }
//    
//    if (c == 5) {
//        
//        star11.frame = CGRectMake(width*0.65, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star12.frame =CGRectMake(width*0.68, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star13.frame =CGRectMake(width*0.71, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star14.frame = CGRectMake(width*0.74, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star15.frame = CGRectMake(width*0.77, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//    }if (c == 4) {
//        star11.frame = CGRectMake(width*0.65, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star12.frame =CGRectMake(width*0.68, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star13.frame =CGRectMake(width*0.71, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star14.frame = CGRectMake(width*0.74, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//    }if (c == 3) {
//        star11.frame = CGRectMake(width*0.65, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star12.frame =CGRectMake(width*0.68, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star13.frame =CGRectMake(width*0.71, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//    }if (c == 2) {
//        star11.frame = CGRectMake(width*0.65, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//        star12.frame =CGRectMake(width*0.68, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//    }if (c == 1) {
//        star11.frame = CGRectMake(width*0.65, CGRectGetMaxY(fuwu.frame), width*0.03, width*0.03);
//    }
//    
    xian2.frame = CGRectMake(0, CGRectGetMaxY(_wsStraRating1.frame)+width*0.05, width, 1);
    
    
        jieshao1.frame = CGRectMake(width*0.05, CGRectGetMaxY(xian2.frame)+width*0.05, width*0.9, width*0.1);
        jieshao2.frame = CGRectMake(width*0.05, CGRectGetMaxY(jieshao1.frame), width*0.9, width*0.1);
        jieshao3.frame = CGRectMake(width*0.05, CGRectGetMaxY(jieshao2.frame), width*0.9, width*0.1);
        jieshao4.frame = CGRectMake(width*0.05, CGRectGetMaxY(jieshao3.frame), width*0.9, width*0.1);
        jieshao5.frame = CGRectMake(width*0.05, CGRectGetMaxY(jieshao4.frame), width*0.9, width*0.1);
        
        xian3.frame = CGRectMake(0, CGRectGetMaxY(jieshao5.frame)+width*0.01, width, 1);
        
        bigView1.frame = CGRectMake(0, CGRectGetMaxY(xian3.frame), width, width*0.18);
        
        pingjia.frame = CGRectMake(width*0.05, width*0.04, width*0.5, width*0.1);
        
        jiantou1.frame = CGRectMake(width*0.89, width*0.06, width*0.06, width*0.06);
        
//        xian4.frame = CGRectMake(0, CGRectGetMaxY(bigView1.frame), width, 1);
    
        ditu.frame = CGRectMake(0, CGRectGetMaxY(bigView1.frame), width, width*0.6);
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, width*0.015, width, width*0.6)];
        self.mapView.delegate = self;
        self.mapView.zoomLevel = 15;
        [ditu addSubview:self.mapView];
        //初始化定位
        self.service = [[AMapLocationManager alloc] init];
        //设置代理
        self.service.delegate = self;
        //开启定位
        [self.service startUpdatingLocation];
        
        bigView2.frame = CGRectMake(0, CGRectGetMaxY(ditu.frame)+width*0.04, width, width*0.18);
        fuwuCenter.frame = CGRectMake(width*0.05, width*0.03, width*0.3, width*0.1);
        
        jiantou2.frame = CGRectMake(width*0.89, width*0.045, width*0.06, width*0.06);
        
        xian5.frame = CGRectMake(0, CGRectGetMaxY(bigView2.frame), width, 1);
        
        erweima.frame = CGRectMake(width*0.05, CGRectGetMaxY(xian5.frame)+width*0.04, width*0.3, width*0.1);
        
        erweimaDa.frame = CGRectMake(width/2-width*0.3, CGRectGetMaxY(erweima.frame)+width*0.05, width*0.6, width*0.6);
        
        xiangsi.frame = CGRectMake(0, CGRectGetMaxY(erweimaDa.frame)+width*0.05, width, width*1.2);
        
        xsCar.frame = CGRectMake(width*0.05, CGRectGetMaxY(erweimaDa.frame)+width*0.1, width*0.9, width*0.1);
    
    
    if (dict3.count == 0) {
        
        UILabel *wuxiangsi = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.05, CGRectGetMaxY(xsCar.frame)+self.contentView.frame.size.width*0.1, self.contentView.frame.size.width*0.9, self.contentView.frame.size.width*0.9*2/3)];
        wuxiangsi.text = @"暂无相似车源";
        wuxiangsi.textColor = [UIColor whiteColor];
        wuxiangsi.textAlignment = NSTextAlignmentCenter;
        wuxiangsi.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:wuxiangsi];
    }else{
        
        self.iCarousel.frame = CGRectMake(0, CGRectGetMaxY(xsCar.frame)+width*0.05, width, width*0.8);
    }
    
    
}


#pragma mark - 二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width11 = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width11, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

#pragma mark - ditu
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

//- (void)coderes

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    
    
    //    NSArray *array = [NSArray arrayWithArray:_mapView.annotations];
    //    [_mapView removeAnnotations:array];
    //    array = [NSArray arrayWithArray:_mapView.overlays];
    //    [_mapView removeOverlays:array];
    //
    //    if (response.count == 0) {
    //
    //        return;
    //    }else{
    //
    //        AMapGeoPoint *item = [[AMapGeoPoint alloc] init];
    //        item = response.geocodes[0].location;
    //
    //        x = item.latitude;
    //        y = item.latitude;
    //    }
}

- (void)onClick:(NSString *)address{
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:[NSString stringWithFormat:@"上海市%@",address] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //创建placemark对象
        CLPlacemark *placemark=[placemarks firstObject];
        MACoordinateRegion region;
        CLLocationCoordinate2D centerCoordinate ;
        NSString * lau = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
        NSString * lon = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
        centerCoordinate.latitude = [lau floatValue];
        centerCoordinate.longitude = [lon floatValue];
        region.center = centerCoordinate;
        _mapView.centerCoordinate = centerCoordinate;
        
        MAPointAnnotation *annoPoint = [[MAPointAnnotation alloc] init];
        annoPoint.coordinate = centerCoordinate;
        [_mapView addAnnotation:annoPoint];
    }];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation{
    
    self.mapView.showsUserLocation = YES;
    MAUserLocationRepresentation *location = (MAUserLocationRepresentation *)userLocation;
    [self.mapView updateUserLocationRepresentation:location];
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(x, y);
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    MAAnnotationView *newView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    newView.annotation = annotation;
    newView.image = [UIImage imageNamed:@"停车地点.png"];
    return newView;
}



- (void)sendstr:(NSString *)str{
    
    
}
- (void)buttonClick{
    
    if (_dicDelegate && [_dicDelegate respondsToSelector:@selector(sendPSG:)]) {
        
        [_dicDelegate sendPSG:_model];
    }
}

#pragma mark - iCarousel代理
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
        UIImageView *image1111 = [[UIImageView alloc] init];
        
        [image1111 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",[dict3 objectAtIndex:index][@"cartu"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        if (view == nil) {
            
            CGFloat viewWidth = ScreenWidth - 2*PAGE_OFFSET;
            view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth*1.2, viewWidth*1.1)];
        }
        image1111.frame = CGRectMake(view.frame.size.width*0.05, view.frame.size.width*0.05, view.frame.size.width*0.9, view.frame.size.width*0.9*2/3);
        [view addSubview:image1111];
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, image1111.frame.size.width*0.45, image1111.frame.size.width*0.4, image1111.frame.size.width*0.15)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.7;
        [image1111 addSubview:blackView];
        
        UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, blackView.frame.size.width*0.7, blackView.frame.size.height)];
        jiage.text = [NSString stringWithFormat:@"¥%@",[dict3 objectAtIndex:index][@"jiage1"]];
        jiage.textColor = [UIColor whiteColor];
        jiage.textAlignment = NSTextAlignmentLeft;
        jiage.font = [UIFont boldSystemFontOfSize:24];;
        jiage.adjustsFontSizeToFitWidth = YES;
        [blackView addSubview:jiage];
        
        UILabel *h = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jiage.frame), 0, blackView.frame.size.width*0.3, blackView.frame.size.height)];
        h.text = @"天";
        h.textColor = [UIColor whiteColor];
        h.textAlignment = NSTextAlignmentCenter;
        h.font = [UIFont boldSystemFontOfSize:12];;
        [blackView addSubview:h];
        
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(image1111.frame), CGRectGetMaxY(image1111.frame)+view.frame.size.width*0.05, view.frame.size.width*0.6, view.frame.size.width*0.1)];
        nameLabel.text = [NSString stringWithFormat:@"%@ From %@",[dict3 objectAtIndex:index][@"cartype"],[dict3 objectAtIndex:index][@"usernickname"]];
        nameLabel.textColor = Color(157, 157, 157);
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.adjustsFontSizeToFitWidth = YES;
        [view addSubview:nameLabel];
        
        
        _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(image1111.frame), CGRectGetMaxY(nameLabel.frame)+view.frame.size.width*0.01, view.frame.size.width*0.2125,view.frame.size.width*0.05) numberOfStar:5];
        [view addSubview:_wsStraRating];
        //CGRectGetMaxX(_wsStraRating.frame)+5, 50, ScreenWidth*0.05, 0.02*ScreenHeight
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+5, CGRectGetMaxY(nameLabel.frame)+view.frame.size.width*0.01, 0.085*ScreenHeight, view.frame.size.width*0.05)];
        _scoreLabel.textColor = Color(157, 157, 157);
        [view addSubview:_scoreLabel];
        
        
        _wsStraRating.delegate = self;
        
        __block ChangbaoDTCell *detaCell = self;
        
        [_wsStraRating setScore:1.0 withAnimation:YES completion:^(BOOL finished) {
            detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",1.0 * 5 ];
        }];
    
        UILabel *plate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_scoreLabel.frame)+view.frame.size.width*0.05, CGRectGetMaxY(nameLabel.frame)+view.frame.size.width*0.01, view.frame.size.width*0.5, view.frame.size.width*0.05)];
        plate.text = [NSString stringWithFormat:@"%@ · %@条评价",[dict3 objectAtIndex:index][@"plate"],[dict3 objectAtIndex:index][@"pj_count"]];
        plate.textColor = Color(157, 157, 157);
        plate.textAlignment = NSTextAlignmentLeft;
        plate.font = [UIFont systemFontOfSize:17];
        plate.adjustsFontSizeToFitWidth = YES;
        [view addSubview:plate];
        
        //        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width*0.7, view.frame.size.width*0.9*2/3-view.frame.size.width*0.025, view.frame.size.width*0.15, view.frame.size.width*0.15)];
        
        UIButton *iconImage = [UIButton buttonWithType:UIButtonTypeCustom];
        iconImage.frame = CGRectMake(view.frame.size.width*0.7, view.frame.size.width*0.9*2/3-view.frame.size.width*0.025, view.frame.size.width*0.15, view.frame.size.width*0.15);
        
        //        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict3 objectAtIndex:index][@"usericon"]]]]) {
        //
        //            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict3 objectAtIndex:index][@"usericon"]]]]];
        //
        //            [iconImage setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict3 objectAtIndex:index][@"usericon"]]]]] forState:UIControlStateNormal];
        //            iconImage.layer.cornerRadius = view.frame.size.width*0.15/2;
        //        }else{
        //
        //            [iconImage setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
        //        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict3 objectAtIndex:index][@"usericon"]]];
            
            NSData *data = [NSData dataWithContentsOfURL:iconURL];
            
            NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *image = [UIImage imageWithData:data];
                
                if ([s isEqualToString:@""]) {
                    
                    [iconImage setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
                }else{
                    
                    [iconImage setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                }
                
            });
        });
        //        iconImage.backgroundColor = [UIColor greenColor];
        iconImage.layer.masksToBounds = YES;
        iconImage.layer.cornerRadius = view.frame.size.width*0.15/2;
        [view addSubview:iconImage];
        
        view.backgroundColor = [UIColor whiteColor];
        
        return view;
    
}
- (void)starRatingView:(WSStarRatingView *)view score:(float)score
{
    _scoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
}

// 偏移量
-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    //    static CGFloat max_sacle = 1.0f;
    //    static CGFloat min_scale = 0.65f;
    //    if (offset <= 1 && offset >= -1) {
    //        float tempScale = offset < 0 ? 1+offset : 1-offset;
    //        float slope = (max_sacle - min_scale) / 1;
    //
    //        CGFloat scale = min_scale + slope*tempScale;
    //        transform = CATransform3DScale(transform, scale, scale, 1);
    //    }else{
    //        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    //    }
    
    return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.05, 0.0, 0.0);
    //    return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.05, 0.0, 0.0);
}
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return dict3.count;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    NSString *str = [dict3 objectAtIndex:index][@"carid"];
    NSString *cartu = [dict3 objectAtIndex:index][@"cartu"];
    
    if (_dicDelegate && [_dicDelegate respondsToSelector:@selector(sendCarId:sendPSG:)]) {
        
        [_dicDelegate sendCarId:str sendPSG:cartu];
    }
}


-(NSString *)sha1WithKey:(NSString *)key
{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
//获取随机数
-(NSString *)getRandomNonce
{
    NSInteger randomValue = [self getRandomNumber:100000 to:999999];
    return  [NSString stringWithFormat:@"%ld",randomValue];
}
//获取时间戳 从1970年
-(NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval times =  [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",times];
}

//获取从 from 到  to 的随机数
-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}


//根据appSecret nonce timestamp 获取signature
-(NSString *)getSignatureWithAppSecret:(NSString *)appSecret nonce:(NSString *)nonce timestamp:(NSString *)timestamp
{
    NSString *sha1String = [NSString stringWithFormat:@"%@%@%@",appSecret,nonce,timestamp];
    return [self sha1WithKey:sha1String];
}




#pragma mark - 评价点击
- (void)Click1{
    
//    NSLog(@"1111");
}

#pragma mark - 服务中心点击
- (void)Click2{
    
//    NSLog(@"22222");
    if (_dicDelegate && [_dicDelegate respondsToSelector:@selector(fuwuUserID)]) {
        
        [_dicDelegate fuwuUserID];
    }
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
