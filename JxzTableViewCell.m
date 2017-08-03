//
//  XingchengTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/2/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "JxzTableViewCell.h"
//#import "FMDB.h"
#import "Header.h"
#import "AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "FriendsViewController.h"
#import "RCDataManager.h"
#import "RCUserInfo+Addition.h"
#import <CommonCrypto/CommonCrypto.h>
#import "HttpManager.h"
#import "ZCorderId.h"
#import "WMConversationViewController.h"
#import "AppDelegate.h"
#import "ZCUserData.h"

#define PATH_URLPOST @"http://wx.leisurecarlease.com/api.php?op=api_xcxqwks"

@implementation JxzTableViewCell {
    UIView *_bottomView;
    UIImageView *_imageView;
    UILabel *_carIdLable;
    UILabel *_yearLable;
    UILabel *_timeLable;
    UIButton *_receiveButton;
    UILabel *_whereLable;
    UIImageView *_rightImage;
    NSArray *_dataArray;
    NSArray *_commArray;
    NSMutableArray *dataSource;
    NSInteger flagTag;
    
    
    NSMutableArray *_dataArray1;
    
    NSMutableDictionary *_detailsDict;

    NSMutableArray *_gencheArray;
    NSMutableArray *_zhucheArray;
    
    
    
    NSString *_jieshuString;
    
    
    NSString *_s;
    
    UIView *_blackView;
    
    UILabel *_idLabel;
    
    UIView *bigView;
    
    
    UILabel *_chaoshiLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self  customTables];
       
        flagTag = 0;
        _jieshuString = @"";
        _s = @"";
        
}
    return self;
}

-(void)customTables {
    
    
    _dataArray1 = [NSMutableArray new];
    _gencheArray = [NSMutableArray new];
    _zhucheArray = [NSMutableArray new];
    _detailsDict =[NSMutableDictionary new];
    
    
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
    
    _idLabel = [UILabel new];
    [_bottomView addSubview:_idLabel];
    

    _yearLable = [UILabel new];
    [_bottomView addSubview:_yearLable];
    _timeLable = [UILabel new];
    [_bottomView addSubview:_timeLable];
    
    _chaoshiLabel = [UILabel new];
    [_bottomView addSubview:_chaoshiLabel];
    
    _receiveButton = [UIButton new];
    [self.contentView addSubview:_receiveButton];
    

    
    
    _whereLable = [UILabel new];
    [self.contentView addSubview:_whereLable];
    
    _rightImage = [UIImageView new];
    [_bottomView addSubview:_rightImage];
    
}
-(void)setDict:(NSDictionary *)dict {
    
    _dict = dict;
    
    [self reallCell];
}

-(void)reallCell {
    
    if([_dict[@"carimgurl"] isEqualToString:@""]){
        
        _imageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
    }else {
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_dict[@"carimgurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
//    _idLabel.text = _dict[@"id"];
//    _idLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//    _idLabel.textAlignment = NSTextAlignmentLeft;
//    _idLabel.textColor = Color(7, 187, 177);
//    
    
    NSString *str1 = @"订单号: ";
    
    long len1 = [str1 length];
    
    NSString *nameStr = _dict[@"id"];
    
    NSString *str = [NSString stringWithFormat:@"订单号: %@",nameStr];
    
    
    
    long len2 = [nameStr length];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:7/255.0 green:187/255.0  blue:177/255.0  alpha:1] range:NSMakeRange(0,str2.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15 ] range:NSMakeRange(0,str2.length)];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(len1,len2)];
    
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15] range:NSMakeRange(len1,len2)];
    
    
    _idLabel.attributedText = str2;
    
    

    _carIdLable.text = _dict[@"state"];
    _carIdLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _carIdLable.textAlignment = NSTextAlignmentRight;
    _carIdLable.adjustsFontSizeToFitWidth = YES;
    _carIdLable.textColor = Color(7, 187, 177);
    
    _rightImage.image = [UIImage imageNamed:@"箭头右22.png"];
    _rightImage.alpha = 0.7;
    
    _yearLable.text = _dict[@"ntime"];
    _yearLable.adjustsFontSizeToFitWidth = YES;
    _yearLable.textColor = [UIColor whiteColor];
    _yearLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLable.text = _dict[@"ytime"];
    
    _timeLable.adjustsFontSizeToFitWidth = YES;
    
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
        NSString *starString = [dateFormatter stringFromDate:currentDate];
    

        _jieshuString= [NSString stringWithFormat:@"%@%@%@%@%@ %@:00",[_dict[@"ntime"] substringWithRange:NSMakeRange(0, 4)],@"-", [_dict[@"ytime"] substringWithRange:NSMakeRange(0, 2)],@"-", [_dict [@"ytime"] substringWithRange:NSMakeRange(3, 2)],[_dict [@"ytime"] substringWithRange:NSMakeRange(6, 5)]];
//    
//        _jieshuString = [NSString stringWithFormat:@"%@ 00:00:00",_jieshuString];
        _s = [self dateTimeDifferenceWithStartTime:starString endTime:_jieshuString];
    
        _timeLable.textColor = [UIColor whiteColor];
    
        _timeLable.textAlignment = NSTextAlignmentCenter;
    
        _timeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];

    
    
    _chaoshiLabel.text = [NSString stringWithFormat:@"%@ / %@",_dict[@"zhuche_chaoshi"],_dict[@"zhuche_chaogongli"]];
    
    _chaoshiLabel.adjustsFontSizeToFitWidth = YES;
    
    _chaoshiLabel.textColor = [UIColor whiteColor];
    
    _chaoshiLabel.textAlignment = NSTextAlignmentCenter;
    
    _chaoshiLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    
    UIColor *color = Color(7, 187, 177);
   
    
    if([_s intValue] >2) {
        _receiveButton.layer.borderColor = [[UIColor grayColor] CGColor];
        _receiveButton.layer.borderWidth = 2;
        _receiveButton.tag = 1;
        [_receiveButton setTitle:@"hi" forState:UIControlStateNormal];
        [_receiveButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
        _receiveButton.selected = NO;

    }else if(([_s intValue] <=2) && ([_s intValue] >=0))    {
        _receiveButton.selected = YES;
        _receiveButton.layer.borderColor = [color CGColor];
        _receiveButton.layer.borderWidth = 2;
        _receiveButton.tag = 0;
        [_receiveButton setTitle:@"hi" forState:UIControlStateNormal];
        [_receiveButton setTitleColor:color forState:UIControlStateNormal] ;

    }
    [_receiveButton addTarget:self action:@selector(tishiHaiyouQitian:) forControlEvents:UIControlEventTouchUpInside];
    _whereLable.text = [NSString stringWithFormat:@"集合地址:%@",_dict[@"address"]];
    _whereLable.textAlignment = NSTextAlignmentRight;
    _whereLable.textColor = [UIColor whiteColor];
    _whereLable.adjustsFontSizeToFitWidth = YES;
    _whereLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
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

-(void)tishiHaiyouQitian: (UIButton *)Button {
    
//    NSString *groupId = [_groupId copy];
//    
    if (Button.tag == 1) {
        
        [self AlertView];
    }
    if (Button.tag == 0) {
        
        NSLog(@"聊天了哦++++++++++++");
        NSString  *orderid = _dict[@"id"];
        
        NSNumber *number = [NSNumber numberWithInt:[orderid intValue]];
        
        [HttpManager postData:@{@"orderid":number} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_orderalluser" success:^(NSDictionary *fanhuicanshu) {
            
            
            if ([fanhuicanshu[@"chezhu"] isKindOfClass:[NSNull class]]) {
                
                [self AlertView];
                
            }else {

                    NSDictionary *dictNeed = [NSDictionary dictionaryWithObjectsAndKeys:_dict[@"id"],@"id",nil];
                    
                    [HttpManager postData:dictNeed andUrl:@"http://wx.leisurecarlease.com/rongcloud.php?op=add" success:^(NSDictionary *fanhuicanshu) {
                        
                        NSString *dString = orderid;
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ORDRID"];
                        [[ZCorderid share] saveUserInfoWithOrderId:nil];
                        [[ZCorderid share]saveUserInfoWithOrderId:dString];
                        
                        [self viewController].tabBarController.selectedViewController =  [self viewController].tabBarController.childViewControllers[2];
                        [[self viewController].navigationController popToRootViewControllerAnimated:YES];
                        
                        
                        
                        
                        
                        [HttpManager postData:@{@"orderid": [ZCorderid share].orderid} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_orderalluser" success:^(NSDictionary *fanhuicanshu) {
                            
                      
                            
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
                            [formatter setDateStyle:NSDateFormatterMediumStyle];
                            [formatter setTimeStyle:NSDateFormatterShortStyle];
                            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
                            NSInteger a1 = [fanhuicanshu[@"shijian"] integerValue];
                            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:a1];
                            NSLog(@"1296035591  = %@",confromTimesp);
                            NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                            NSLog(@"1296035591  = %@",confromTimespStr);
                            
                            NSString *stringName = [NSString stringWithFormat:@"%@的新人",confromTimespStr];
                     
//                        [HttpManager postData:@{@"userid": [ZCUserData share].userId} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=member" success:^(NSDictionary *fanhuicanshu) {
                            //
                            //获取Token的接口
                            NSString *url = @"http://api.cn.ronghub.com/user/getToken.json";
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
                            //在这post    userId 接口
                            
                            NSString  *userid = [ZCUserData share].userId;
                            NSString  *username =  stringName;
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
                                NSLog(@"123123123%@",dataSource);
                                
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

//- (void)tishiHaizaiPIpei:(UIButton *)sender{
//}
//
//-(void)postURL:(NSString *)name AndPlant:(NSString*)plant AndNeedName:(NSString*)needName{
//    
//    NSString  *orderid =  _dict[@"id"];
//    __block NSString *s = @"";
//    
//    NSNumber *number = [NSNumber numberWithInt:[orderid intValue]];
//    [HttpManager postData:@{@"orderid":number} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_orderalluser" success:^(NSDictionary *fanhuicanshu) {
//        
//        //获取Token的接口
//        NSString *url = @"http://api.cn.ronghub.com/message/private/publish.json";
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"application/json", @"text/json", @"text/JavaScript"]];
//        s = [NSString stringWithFormat:@"我是车牌号为（%@)驾驶员（%@)",plant,needName];
//        NSString *string = [NSString stringWithFormat:@"%@",@"RC:TxtMsg"];
//        NSDictionary *di =@{@"content":s,@"extra":@"helloExtra"};
//        NSData *dataContent = [NSJSONSerialization dataWithJSONObject:di options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonString = [[NSString alloc] initWithData:dataContent encoding:NSUTF8StringEncoding];
//        NSDictionary *dict = @{@"fromUserId":name,@"toUserId":fanhuicanshu[@"yonghu"][@"carid"],@"objectName":string,@"content":jsonString};
//        
//        //content={@"content":@"c#hello\"}&fromUserId=2191&toUserId=2191&toUserId=2192&objectName=RC:TxtMsg&pushContent=thisisapush&pushData={\"pushData\":\"hello\"}
//        NSString *appkey = @"kj7swf8ok47u2";
//        NSString *nonce = [self getRandomNonce];
//        NSString *timestamp = [self getTimestamp];
//        NSString *signature = [self getSignatureWithAppSecret:@"Kv26rgnvLRR" nonce:nonce timestamp:timestamp];
//        
//        NSLog(@"-------%@",appkey);
//        NSLog(@"-------%@",nonce);
//        NSLog(@"--------%@",timestamp);
//        NSLog(@"---------%@",signature);
//        
//        [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
//        [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
//        [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
//        [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
//        
//        [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"1");
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];
//
//        
//    } Error:^(NSString *cuowuxingxi) {
//        
//    }];
//}

//-(void)initLoacalTestData{
//    
//    dataSource = [[NSMutableArray alloc]init];
////    for (NSInteger i = 1; i<3; i++) {
////        if(i==1){
//            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:@"wangye" name:@"1" portrait:@"https://www.baidu.com/img/baidu_jgylogo3.gif" QQ:@"123456" sex:@"男"];
//            [dataSource addObject:aUserInfo];
//            
//        //}
//   // }
//    
//}
-(UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *responder = [next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}


- (void)refuseButtonClick:(UIButton *)sender{
    
    NSLog(@"拒单了------------");
}
// posturl  融云登录接口
//-(NSString *)postURL:(NSString *)userId {
//    
//    return  toke;
//}
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
-(void)layoutSubviews {
    [super layoutSubviews];
    
    _bottomView.frame =CGRectMake(ScreenWidth*0.1, ScreenWidth*0.01, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    
  
    _imageView.frame = CGRectMake(0, 0, _bottomView.frame.size.width, ScreenWidth*0.8*8/11);
    
    
      _blackView.frame =CGRectMake(0, 0, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
   // _imageView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    _carIdLable.frame = CGRectMake(ScreenWidth*0.55, ScreenWidth*0.01, ScreenWidth*0.2, ScreenWidth*0.05);
    _idLabel.frame = CGRectMake(ScreenWidth*0.01, ScreenWidth*0.01, ScreenWidth*0.3, ScreenWidth*0.05);
    _idLabel.adjustsFontSizeToFitWidth = YES;
    _idLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    //_carIdLable.backgroundColor = [UIColor greenColor];
    _idLabel.textAlignment = NSTextAlignmentCenter;
     _rightImage.frame = CGRectMake(ScreenWidth*0.75, CGRectGetMidY(_carIdLable.frame)-ScreenWidth*0.018, ScreenWidth*0.036, ScreenWidth*0.036);
     //_rightImage.backgroundColor = [UIColor redColor];
    
    _yearLable.frame = CGRectMake(0,  (ScreenWidth*0.8*8/11 -(ScreenWidth*0.28))/2, ScreenWidth*0.8, ScreenWidth*0.08);
    
    _timeLable.frame = CGRectMake(0, CGRectGetMaxY(_yearLable.frame)+ScreenWidth*0.02, ScreenWidth*0.8, ScreenWidth*0.08);
    
    _chaoshiLabel.frame = CGRectMake(0, CGRectGetMaxY(_timeLable.frame)+ScreenWidth*0.02, ScreenWidth*0.8, ScreenWidth*0.08);
    
    _receiveButton.frame = CGRectMake(ScreenWidth*0.75, ScreenWidth*0.1, ScreenWidth*0.1, ScreenWidth*0.1);
   
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

@end
