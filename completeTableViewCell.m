//
//  XingchengTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/2/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "completeTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "RCDataManager.h"
#import "RCUserInfo+Addition.h"
#import <CommonCrypto/CommonCrypto.h>
#import "ZCorderId.h"
#import "HttpManager.h"
#import "ZCUserData.h"



@implementation completeTableViewCell {
    UIView *_bottomView;
    UIImageView *_imageView;
    UILabel *_carIdLable;
    UILabel *_yearLable;
    UILabel *_timeLable;
    UILabel *_carStateLable;
    UIImageView *_rightImageView;
    UIButton *_telButton;
    
    UILabel *_whereLable;
    UIButton *_receiveButton;
    
    UIView *_blackView;
    
    UIView *bigView;
    
    
     UILabel *_chaoshiLabel;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self  customTables];
        
    }
    return self;
}
-(void)customTables {
    
    
    _bottomView = [UIView new];
    [self.contentView addSubview:_bottomView];
    

    
    _imageView = [UIImageView new];
    [_bottomView addSubview:_imageView];
    
    _blackView = [UIView new];
    _blackView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    //_blackView.backgroundColor = [UIColor redColor];
    [_bottomView addSubview:_blackView];

    _carIdLable = [UILabel new];
    [_bottomView addSubview:_carIdLable];
    _yearLable = [UILabel new];
    [_bottomView addSubview:_yearLable];
    _timeLable = [UILabel new];
    [_bottomView addSubview:_timeLable];
    
    
    _chaoshiLabel = [UILabel new];
    [_bottomView addSubview:_chaoshiLabel];

    
    
    _carStateLable = [UILabel new];
    [_bottomView addSubview:_carStateLable];
    _rightImageView = [UIImageView new];
    [_bottomView addSubview:_rightImageView];
    
    _telButton = [UIButton new];
    [self.contentView addSubview:_telButton];
    
    _whereLable = [UILabel new];
    [self.contentView addSubview:_whereLable];
    
    _receiveButton = [UIButton new];
    [self.contentView addSubview: _receiveButton];
    
    
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self reallCell];
}

-(void)reallCell {
    
    if ([_dict[@"cartu1"] isKindOfClass:[NSNull class]]) {
        _imageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
    }else {
          NSString *cartuString = [NSString stringWithFormat:@"%@%@",@"http://wx.leisurecarlease.com",_dict[@"cartu1"]];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:cartuString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];

    }
    NSString *str1 = @"订单号: ";
    
    long len1 = [str1 length];
    
    NSString *nameStr = _dict[@"orderid"];
    
    NSString *str = [NSString stringWithFormat:@"订单号: %@",nameStr];
    
    long len2 = [nameStr length];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:7/255.0 green:187/255.0  blue:177/255.0  alpha:1] range:NSMakeRange(0,str2.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15 ] range:NSMakeRange(0,str2.length)];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(len1,len2)];
    
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15] range:NSMakeRange(len1,len2)];
    
    _carIdLable.attributedText = str2;
   
    _yearLable.text =[NSString stringWithFormat:@"%@",_dict[@"ntime"]];
    _yearLable.textColor = [UIColor whiteColor];
    _yearLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLable.text =  [NSString stringWithFormat:@"%@",_dict[@"ytime"]];
    _timeLable.textColor = [UIColor whiteColor];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    
    _carStateLable.text =  [NSString stringWithFormat:@"%@",_dict[@"state"]];
    _carStateLable.textColor = Color(0, 215, 200);
    _carStateLable.adjustsFontSizeToFitWidth =YES;
    _carStateLable.font = [UIFont systemFontOfSize:13];
    _carStateLable.textAlignment = NSTextAlignmentRight;
    
    
    
    _chaoshiLabel.text = [NSString stringWithFormat:@"%@ / %@",_dict[@"zhuche_chaoshi"],_dict[@"zhuche_chaogongli"]];
    
    _chaoshiLabel.adjustsFontSizeToFitWidth = YES;
    
    _chaoshiLabel.textColor = [UIColor whiteColor];
    
    _chaoshiLabel.textAlignment = NSTextAlignmentCenter;
    
    _chaoshiLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    
    
    
    _rightImageView.image = [UIImage imageNamed:@"箭头右.png"];
    
    [_telButton setBackgroundImage:[UIImage imageNamed:@"电话222.png"] forState:UIControlStateNormal];
    [_telButton addTarget:self action:@selector(dianhua1:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *starString = [dateFormatter stringFromDate:currentDate];
    
    
    NSString *jieshuString= [NSString stringWithFormat:@"%@%@%@%@%@ %@:00",[_dict[@"ntime"] substringWithRange:NSMakeRange(0, 4)],@"-", [_dict[@"ytime"] substringWithRange:NSMakeRange(0, 2)],@"-", [_dict [@"ytime"] substringWithRange:NSMakeRange(3, 2)],[_dict [@"ytime"] substringWithRange:NSMakeRange(6, 5)]];
    //
    //        _jieshuString = [NSString stringWithFormat:@"%@ 00:00:00",_jieshuString];
    NSString *s = [self dateTimeDifferenceWithStartTime:starString endTime:jieshuString];
    
    UIColor *color = Color(7, 187, 177);
    
    
    
    if([s intValue] >7) {
        _receiveButton.layer.borderColor = [[UIColor grayColor] CGColor];
        _receiveButton.layer.borderWidth = 2;
        _receiveButton.tag = 1;
        [_receiveButton setTitle:@"hi" forState:UIControlStateNormal];
        [_receiveButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
        _receiveButton.selected = NO;
        
    }else if(([s intValue] <=7) && ([s intValue] >=0))    {
        _receiveButton.selected = YES;
        _receiveButton.layer.borderColor = [color CGColor];
        _receiveButton.layer.borderWidth = 2;
        _receiveButton.tag = 0;
        [_receiveButton setTitle:@"hi" forState:UIControlStateNormal];
        [_receiveButton setTitleColor:color forState:UIControlStateNormal] ;
        
    }
    [_receiveButton addTarget:self action:@selector(tishiButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if ([_dict[@"address"] isKindOfClass:[NSNull class]]) {
        _whereLable.text = @"无地址";
        _whereLable.textAlignment = NSTextAlignmentRight;
        _whereLable.textColor = [UIColor whiteColor];
        _whereLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];

    }else {
        _whereLable.text = _dict[@"address"];
        _whereLable.textAlignment = NSTextAlignmentRight;
        _whereLable.textColor = [UIColor whiteColor];
        _whereLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        
    }
    
}

- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    //    int second = (int)value %60;//秒
    //
    //    int minute = (int)value /60%60;
    //
    //    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
    str = [NSString stringWithFormat:@"%d",day];
    
    return str;
    
}

- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 1000;
    [self.window addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.8, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame)*0.9, CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"订单未匹配，匹配后发起聊天";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.7, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.8, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
-(void)moveAll {
    
    [bigView removeFromSuperview];
}

-(void)tishiButton1: (UIButton *)Button {
    
  
    if (Button.tag == 1) {
        
        [self AlertView];
    }
    if (Button.tag == 0) {
        
        NSLog(@"聊天了哦++++++++++++");
        NSString  *orderid = _dict[@"orderid"];
        
        NSNumber *number = [NSNumber numberWithInt:[orderid intValue]];
        
        [HttpManager postData:@{@"orderid":number} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_orderalluser" success:^(NSDictionary *fanhuicanshu) {
            
            
            if ([fanhuicanshu[@"chezhu"] isKindOfClass:[NSNull class]]) {
                
                [self AlertView];
                
            }else {
                
                NSDictionary *dictNeed = [NSDictionary dictionaryWithObjectsAndKeys:_dict[@"orderid"],@"id",nil];
                
                [HttpManager postData:dictNeed andUrl:@"http://wx.leisurecarlease.com/rongcloud.php?op=add" success:^(NSDictionary *fanhuicanshu) {
                    
                    NSString *dString = orderid;
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ORDRID"];
                    [[ZCorderid share] saveUserInfoWithOrderId:nil];
                    [[ZCorderid share]saveUserInfoWithOrderId:dString];
                    
                    [self viewController].tabBarController.selectedViewController =  [self viewController].tabBarController.childViewControllers[2];
                    [[self viewController].navigationController popToRootViewControllerAnimated:YES];
                    
                    
                    [HttpManager postData:@{@"userid": [ZCUserData share].userId} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=member" success:^(NSDictionary *fanhuicanshu) {
                        //
                        //获取Token的接口
                        NSString *url = @"http://api.cn.ronghub.com/user/getToken.json";
                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
                        //在这post    userId 接口
                        
                        NSString  *userid = [ZCUserData share].userId;
                        NSString  *username =  fanhuicanshu[@"arr"][@"nickname"];
                        NSString *catTu = [NSString stringWithFormat:@"%@",fanhuicanshu[@"arr"][@"thumb"]];
                        
                        NSDictionary *dict = @{@"userId":userid,@"userName":username,@"portraiUri":catTu};
                        NSString *appkey = @"kj7swf8ok47u2";
                        NSString *nonce = [self getRandomNonce];
                        NSString *timestamp = [self getTimestamp];
                        NSString *signature = [self getSignatureWithAppSecret:@"Kv26rgnvLRR" nonce:nonce timestamp:timestamp];
                        
                        NSLog(@"-------%@",appkey);
                        NSLog(@"-------%@",nonce);
                        NSLog(@"--------%@",timestamp);
                        NSLog(@"---------%@",signature);
                        
                        [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
                        [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
                        [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
                        [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
                        [manager.requestSerializer setValue:@"Kv26rgnvLRR" forHTTPHeaderField:@"appSecret"];
                        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                        [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                            
                            NSLog(@"%@",responseObject[@"token"]);
                            //   [self initLoacalTestData];
                            RCUserInfo *aUserInfo1 =[[RCUserInfo alloc]initWithUserId:userid name:username portrait:catTu QQ:@"" sex:@""];
                            RCUserInfo *aUserInfo = aUserInfo1;
                            
                            NSString *token;
                            if([aUserInfo.userId intValue] == [userid intValue]){
                                token = responseObject[@"token"];
                            }
                            
                            [[RCDataManager shareManager] loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:aUserInfo.userId name:aUserInfo.name portrait:aUserInfo.portraitUri QQ:aUserInfo.QQ sex:aUserInfo.sex] withToken:token];
                            
                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSLog(@"%@",error);
                        }];
                        NSLog(@"点我干啥");
                        
                    } Error:^(NSString *cuowuxingxi) {
                        
                    }];
                    
                    
                } Error:^(NSString *cuowuxingxi) {
                    
                }];
                
            }
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }

}
//-(void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo withToken:(NSString *)token{
//
//    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
//        [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor redColor];
//
//        [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
//        [[RCDataManager shareManager] refreshBadgeValue];
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"status = %ld",(long)status);
//    } tokenIncorrect:^{
//        
//        NSLog(@"token 错误");
//    }];
//    
//}


//融云head 参数




-(void)dianhua1:(UIButton *)button {
    NSLog(@"赶紧接电话");
    
    [self callPhone:_dict[@"tel"]];
    
    
}
//打电话
-(void)callPhone:(NSString *)phoneNum {
    
    if (phoneNum.length == 0) {
        
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

-(UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *responder = [next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    _bottomView.frame =CGRectMake(ScreenWidth*0.1, ScreenWidth*0.01, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    
    _imageView.frame = CGRectMake(0, 0, _bottomView.frame.size.width, ScreenWidth*0.8*8/11);
    
    _blackView.frame =CGRectMake(0, 0, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    
    _yearLable.frame = CGRectMake(0,  (ScreenWidth*0.8*8/11 -(ScreenWidth*0.28))/2, ScreenWidth*0.8, ScreenWidth*0.08);
    
    _timeLable.frame = CGRectMake(0, CGRectGetMaxY(_yearLable.frame)+ScreenWidth*0.02, ScreenWidth*0.8, ScreenWidth*0.08);
    
    _chaoshiLabel.frame = CGRectMake(0, CGRectGetMaxY(_timeLable.frame)+ScreenWidth*0.02, ScreenWidth*0.8, ScreenWidth*0.08);

    _carStateLable.frame = CGRectMake(ScreenWidth*0.55, ScreenWidth*0.01, ScreenWidth*0.2, ScreenWidth*0.05);
    
    _carIdLable.frame = CGRectMake(ScreenWidth*0.01, ScreenWidth*0.01, ScreenWidth*0.3, ScreenWidth*0.05);
    _carIdLable.adjustsFontSizeToFitWidth = YES;
    _carIdLable.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    //_carIdLable.backgroundColor = [UIColor greenColor];
    _carIdLable.textAlignment = NSTextAlignmentCenter;
    
    
    _rightImageView.frame = CGRectMake(ScreenWidth*0.75, CGRectGetMidY(_carStateLable.frame)-ScreenWidth*0.018, ScreenWidth*0.036, ScreenWidth*0.036);
    _rightImageView.image = [UIImage imageNamed:@"箭头右22.png"];
    
    
    _telButton.frame = CGRectMake(ScreenWidth*0.75, ScreenWidth*0.1, ScreenWidth*0.1, ScreenWidth*0.1);
    
    _receiveButton.frame = CGRectMake(ScreenWidth*0.75, CGRectGetMaxY(_telButton.frame)+ScreenWidth*0.02, ScreenWidth*0.1, ScreenWidth*0.1);
    _receiveButton.layer.cornerRadius = ScreenWidth*0.05;
    
    _whereLable.frame = CGRectMake(ScreenWidth*0.06, ScreenWidth*0.54, ScreenWidth*0.8, ScreenWidth*0.04);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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
@end
