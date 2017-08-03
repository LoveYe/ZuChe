



//
//  RCDataManager.m
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RCDataManager.h"
#import "RCUserInfo+Addition.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonCrypto.h>
#import "HttpManager.h"
#import "ZCorderId.h"
#import "WMConversationViewController.h"
@implementation RCDataManager{
        NSMutableArray *dataSoure;
        NSString *_orderid;
    
    NSString *_dissId;
    
    
}

- (instancetype)init{
    if (self = [super init]) {
        [RCIM sharedRCIM].userInfoDataSource = self;
    }
    return self;
}

+ (RCDataManager *)shareManager{
    static RCDataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
   
    });
    return manager;
}

//-(void)noticeNew:(NSNotification *)sender {
//    
//    _orderid = [sender.userInfo objectForKey:@"orderid"];
//    
//}
/**
 *  从服务器同步好友列表
 */


//-(void)syncFriendList:(void (^)(NSMutableArray* friends,BOOL isSuccess))completion
//{
//    dataSoure = [[NSMutableArray alloc]init];
//    NSMutableArray *newArray = [NSMutableArray new];
//    
//    //     NSDictionary *ddd =   [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[_orderid intValue]],@"orderid", nil];
//    //
//    
//    [HttpManager postData:@{@"orderid": [ZCorderid share].orderid} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_orderalluser" success:^(NSDictionary *fanhuicanshu) {
//        
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//        [formatter setDateStyle:NSDateFormatterMediumStyle];
//        [formatter setTimeStyle:NSDateFormatterShortStyle];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要
//        NSInteger shijian = [fanhuicanshu[@"shijian"] integerValue];
//        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:shijian];
//        NSLog(@"1296035591  = %@",confromTimesp);
//        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//        NSLog(@"1296035591  = %@",confromTimespStr);
//        
//        
//        
//        NSArray *a = fanhuicanshu[@"chezhu"];
//        
//        [newArray addObject:fanhuicanshu[@"yonghu"]];
//        
//        for (NSInteger i =0 ; i<a.count; i++) {
//            [newArray addObject:a[i]];
//        }
//        
//        
//        for (NSInteger i =0 ; i<newArray.count; i++) {
//            
//            if (i== 0) {
//                
//                RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:fanhuicanshu[@"yonghu"][@"userid"] name:[NSString stringWithFormat:@"%@的%@",confromTimespStr,newArray[i][@"name"]] portrait:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",newArray[i][@"img"]] QQ:@"" sex:@""];
//                [dataSoure addObject:aUserInfo];
//                
//                
//            }else {
//                RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:newArray[i][@"userid"] name:newArray[i][@"name"] portrait:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",newArray[i][@"img"]] QQ:@"" sex:@""];
//                [dataSoure addObject:aUserInfo];
//            }
//        }
//        [AppDelegate shareAppDelegate].friendsArray = dataSoure;
//        completion(dataSoure,YES);
//        
//        
//        
//    } Error:^(NSString *cuowuxingxi) {
//        
//    }];
//    
//}

-(void)syncFriendList:(void (^)(NSMutableArray* friends,BOOL isSuccess))completion
{
    dataSoure = [[NSMutableArray alloc]init];
    NSMutableArray *newArray = [NSMutableArray new];
    
//     NSDictionary *ddd =   [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[_orderid intValue]],@"orderid", nil];
//
    
    [HttpManager postData:@{@"orderid": [ZCorderid share].orderid} andUrl:@"http://wx.leisurecarlease.com/api.php?op=api_orderalluser" success:^(NSDictionary *fanhuicanshu) {
        
        NSArray *a = fanhuicanshu[@"chezhu"];
        
        [newArray addObject:fanhuicanshu[@"yonghu"]];
        
         for (NSInteger i =0 ; i<a.count; i++) {
             [newArray addObject:a[i]];
         }
        
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
        
        for (NSInteger i =0 ; i<newArray.count; i++) {

            if (i== 0) {
                
                RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:fanhuicanshu[@"yonghu"][@"userid"] name:stringName portrait:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",newArray[i][@"img"]] QQ:@"" sex:@""];
                [dataSoure addObject:aUserInfo];
                
                
            }else {
                
                RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:newArray[i][@"userid"] name:[NSString stringWithFormat:@"%@%@师傅",newArray[i][@"plate"],[newArray[i][@"name"] substringWithRange:NSMakeRange(0, 1)]] portrait:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",newArray[i][@"img"]] QQ:@"" sex:@""];
                [dataSoure addObject:aUserInfo];
            }
        }
        [AppDelegate shareAppDelegate].friendsArray = dataSoure;
         completion(dataSoure,YES);

        
        
        } Error:^(NSString *cuowuxingxi) {
        
    }];

}


/**
 *  从服务器同步群组列表
 */
-(void) syncGroupList:(void (^)(NSMutableArray * groups,BOOL isSuccess))completion{
    if ([AppDelegate shareAppDelegate].groupsArray.count) {
        [[AppDelegate shareAppDelegate].groupsArray removeAllObjects];
    }
//    
//    NSMutableArray *array = [NSMutableArray new];
//    
//    [array removeAllObjects];
//
//    for (RCUserInfo *rcUser in [AppDelegate shareAppDelegate].friendsArray) {
//        
//        [array addObject:rcUser.userId];
//    }
    
    for (NSInteger i = 0; i<1; i++) {
        if (i==0) {
            RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:[NSString stringWithFormat:@"%@",[ZCorderid share].orderid] groupName:@"LEISURECAR" portraitUri:@"http://wx.leisurecarlease.com/uploadfile/2017/0714/20170714091023957.png"];
            [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];
        }
//        }else if (i==1){
//            RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:[NSString stringWithFormat:@"%ld",i] groupName:@"丐帮" portraitUri:@"http://farm2.staticflickr.com/1715/23815656639_ef86cf1498_m.jpg"];
//            [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];
//            
//        }else if (i==2){
//            RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:[NSString stringWithFormat:@"%ld",i] groupName:@"青龙帮" portraitUri:@"http://farm2.staticflickr.com/1455/23888379640_edf9fce919_m.jpg"];
//            [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];
//        }
    }
    completion([AppDelegate shareAppDelegate].groupsArray,YES);
    

}
#pragma mark
#pragma mark 根据userId获取RCUserInfo
-(RCUserInfo *)currentUserInfoWithUserId:(NSString *)userId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
            NSLog(@"current ＝ %@",aUser.name);
            return aUser;
        }
    }
    return nil;
}
#pragma mark
#pragma mark 根据userId获取RCGroup
-(RCGroup *)currentGroupInfoWithGroupId:(NSString *)groupId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].groupsArray.count; i++) {
        RCGroup *aGroup = [AppDelegate shareAppDelegate].groupsArray[i];
        if ([groupId isEqualToString:aGroup.groupId]) {
            return aGroup;
        }
    }
    return nil;
}
-(NSString *)currentNameWithUserId:(NSString *)userId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
            NSLog(@"current ＝ %@",aUser.name);
            return aUser.name;
        }
    }
    return nil;
}
#pragma mark
#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString*)userId completion:(void (^)(RCUserInfo*))completion
{
    NSLog(@"getUserInfoWithUserId ----- %@", userId);
    
    if (userId == nil || [userId length] == 0 )
    {
        [self syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {
            
        }];
        
        completion(nil);
        return ;
    }
    
    if ([userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
        RCUserInfo *myselfInfo = [[RCUserInfo alloc]initWithUserId:[RCIM sharedRCIM].currentUserInfo.userId name:[RCIM sharedRCIM].currentUserInfo.name portrait:[RCIM sharedRCIM].currentUserInfo.portraitUri QQ:[RCIM sharedRCIM].currentUserInfo.QQ sex:[RCIM sharedRCIM].currentUserInfo.sex];
        completion(myselfInfo);
        
    }
    
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
            completion(aUser);
            break;
        }
    }
}
#pragma mark
#pragma mark - RCIMGroupInfoDataSource
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].groupsArray.count; i++) {
        RCGroup *aGroup = [AppDelegate shareAppDelegate].groupsArray[i];
        if ([groupId isEqualToString:aGroup.groupId]) {
            completion(aGroup);
            break;
        }
    }
}
-(void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo withToken:(NSString *)token{
    
                [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
                    [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor redColor];
                    NSLog(@"login success with userId %@",userId);
//                    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//                    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//                    [center addObserver:self selector:@selector(noticeNew:) name:@"123456" object:nil];
                    NSLog(@" success 发送通知");
                    //同步好友列表
                    [self syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {
                        NSLog(@"%@",friends);
                        if (isSuccess) {
                            
                            [self syncGroupList:^(NSMutableArray *groups, BOOL isSuccess) {
                                if (isSuccess) {
//
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"eeeeeeeeee" object:nil];
                                    
                                }
                            }];
                           
                        }
                    }];
                    
                     [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
                    [[RCDataManager shareManager] refreshBadgeValue];
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"status = %ld",(long)status);
                } tokenIncorrect:^{
                    
                    NSLog(@"token 错误");
                }];

}


-(void)postURL:(NSString *)name {
    
    
    //获取Token的接口
    NSString *url = @"http://api.cn.ronghub.com/group/create.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"aApplication/x-www-form-urlencoded",@"text/html",@"application/json", @"text/json", @"text/JavaScript"]];
    NSString *string = [NSString stringWithFormat:@"%@",@"RC:TxtMsg"];
    
    NSDictionary *di =@{@"content":@"我是您的车主",@"extra":@"helloExtra"};
    NSData *dataContent = [NSJSONSerialization dataWithJSONObject:di options:NSJSONWritingPrettyPrinted error:nil];
     NSString *jsonString = [[NSString alloc] initWithData:dataContent encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"fromUserId":name,@"toUserId":@"wangye",@"objectName":string,@"content":jsonString};
    
    //content={@"content":@"c#hello\"}&fromUserId=2191&toUserId=2191&toUserId=2192&objectName=RC:TxtMsg&pushContent=thisisapush&pushData={\"pushData\":\"hello\"}
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
//    [manager.requestSerializer setValue:@"Kv26rgnvLRR" forHTTPHeaderField:@"appSecret"];
//    [manager.requestSerializer setValue:@"aApplication/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  //  调用POST方法
//    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
    [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"1");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
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

-(void)refreshBadgeValue{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger unreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];

        
        UINavigationController  *chatNav = [AppDelegate shareAppDelegate].tabbarVC.viewControllers[2];
        if (unreadMsgCount == 0) {
            chatNav.tabBarItem.badgeValue = nil;
        }else{
            chatNav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",(long)unreadMsgCount];
        }
    });
}
-(BOOL)hasTheFriendWithUserId:(NSString *)userId{
    if ([AppDelegate shareAppDelegate].friendsArray.count) {
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        
        for (RCUserInfo *aUserInfo in [AppDelegate shareAppDelegate].friendsArray) {
            [tempArray addObject:aUserInfo.userId];
        }
        
        if ([tempArray containsObject:userId]) {
            return YES;
        }
    }
    
    
    return NO;
}
@end

