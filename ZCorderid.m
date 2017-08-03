//
//  ZCUserData.m
//  ZuChe
//
//  Created by 佐途 on 15/11/9.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "ZCorderId.h"

@implementation ZCorderid
+(ZCorderid *)share;
{
    static ZCorderid * shareUserDataInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareUserDataInstance = [[self alloc]init];
    });
    
    return shareUserDataInstance;
}
- (id)init
{
    self = [super init];
    
    if(self)
    {
        [self initData];
    }
    
    return self;
}
-(void) initData
{
    _userInfoDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInformation"]];
    
    _orderid = _userInfoDic[@"orderId"];
    

    
}

-(void)saveUserInfoWithOrderId:(NSString *)orderid
{
    [_userInfoDic setObject:orderid?orderid:@"" forKey:@"orderId"];
    
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"userInformation"];
    [setting setObject:_userInfoDic forKey:@"userInformation"];
    [setting synchronize];
    
    _orderid = orderid;
   
    
    
}
@end
