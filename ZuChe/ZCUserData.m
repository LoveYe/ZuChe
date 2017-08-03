//
//  ZCUserData.m
//  ZuChe
//
//  Created by 佐途 on 15/11/9.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "ZCUserData.h"

@implementation ZCUserData
+(ZCUserData *)share;
{
    static ZCUserData * shareUserDataInstance = nil;
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
    
    _userId = _userInfoDic[@"userId"];
    _descriptions = _userInfoDic[@"description"];
    _mobile = _userInfoDic[@"mobile"];
    _jiedan = _userInfoDic[@"jiedan"];
    _lianxi = _userInfoDic[@"lianxi"];
    _yinxiang = _userInfoDic[@"yinxiang"];
    _nickname = _userInfoDic[@"nickname"];
    _tiqian = _userInfoDic[@"tiqian"];
    _thumb = _userInfoDic[@"thumb"];
    _username = _userInfoDic[@"username"];
    _xing = _userInfoDic[@"xing"];
    _xingqu = _userInfoDic[@"xingqu"];
    _xueli = _userInfoDic[@"xueli"];
    _zhiye = _userInfoDic[@"zhiye"];
    _fuwu = _userInfoDic[@"fuwu"];
    
    
    _isLogin = [_userInfoDic[@"isLogined"] boolValue];
    
}

-(void)saveUserInfoWithUserId:(NSString *)userId username:(NSString *)username descriptions:(NSString *)descriptions mobile:(NSString *)mobile fuwu:(NSString *)fuwu jiedan:(NSString *)jiedan lianxi:(NSString *)lianxi yinxiang:(NSString *)yinxiang nickname:(NSString *)nickname thumb:(NSString *)thumb tiqian:(NSString *)tiqian xing:(NSString *)xing xingqu:(NSString *)xingqu xueli:(NSString *)xueli zhiye:(NSString *)zhiye  IsLogin:(BOOL)isLogin
{
    [_userInfoDic setObject:userId?userId:@"" forKey:@"userId"];
    //
    //        [_userInfoDic setObject:descriptions?descriptions:@"" forKey:@"description"];
    //
    //        [_userInfoDic setObject:fuwu?fuwu:@"" forKey:@"fuwu"];
    //
    //        [_userInfoDic setObject:jiedan?jiedan:@"" forKey:@"jiedan"];
    //
    //        [_userInfoDic setObject:lianxi?lianxi:@"" forKey:@"lianxi"];
    //
    //        [_userInfoDic setObject:mobile?mobile:@"" forKey:@"mobile"];
    //
    //        [_userInfoDic setObject:yinxiang?yinxiang:@"" forKey:@"yinxiang"];
    //
    //        [_userInfoDic setObject:nickname?nickname:@"" forKey:@"nickname"];
    //
    //        [_userInfoDic setObject:tiqian?tiqian:@"" forKey:@"tiqian"];
    //
    //        [_userInfoDic setObject:username?username:@"" forKey:@"username"];
    //
    //        [_userInfoDic setObject:xing?xing:@"" forKey:@"xing"];
    //
    //        [_userInfoDic setObject:xingqu?xingqu:@"" forKey:@"xingqu"];
    //
    //        [_userInfoDic setObject:xueli?xueli:@"" forKey:@"xueli"];
    //
    //        [_userInfoDic setObject:zhiye?zhiye:@"" forKey:@"zhiye"];
    //
    //
    if (!thumb||[thumb isKindOfClass:[NSNull class]]||[thumb isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"thumb"];
        _thumb =@" ";
    }else
    {
        [_userInfoDic setObject:thumb forKey:@"thumb"];
        _thumb=thumb;
    }
    
    if (!descriptions||[descriptions isKindOfClass:[NSNull class]]||[descriptions isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"description"];
        _descriptions =@"";
    }else
    {
        [_userInfoDic setObject:descriptions forKey:@"description"];
        _descriptions =descriptions;
        
    }
    
    if (!fuwu||[fuwu isKindOfClass:[NSNull class]]||[fuwu isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"fuwu"];
        _fuwu=@" ";
        
    }else
    {
        [_userInfoDic setObject:fuwu forKey:@"fuwu"];
        _fuwu =fuwu;
    }
    
    
    if (!jiedan||[jiedan isKindOfClass:[NSNull class]]||[jiedan isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"jiedan"];
        
        _jiedan =@" ";
    }else
    {
        [_userInfoDic setObject:jiedan forKey:@"jiedan"];
        _jiedan =jiedan;
    }
    
    
    if (!lianxi||[lianxi isKindOfClass:[NSNull class]]||[lianxi isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"lianxi"];
        
        _lianxi =@" ";
    }else
    {
        [_userInfoDic setObject:lianxi forKey:@"lianxi"];
        _lianxi =lianxi;
    }
    
    
    if (!mobile||[mobile isKindOfClass:[NSNull class]]||[mobile isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"mobile"];
        
        _mobile = @" ";
    }else
    {
        [_userInfoDic setObject:mobile forKey:@"mobile"];
        
        _mobile =mobile;
    }
    
    
    if (!yinxiang||[yinxiang isKindOfClass:[NSNull class]]||[yinxiang isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"yinxiang"];
        _yinxiang =@" ";
    }else
    {
        [_userInfoDic setObject:yinxiang forKey:@"yinxiang"];
        _yinxiang =yinxiang ;
    }
    
    
    
    if (!nickname||[nickname isKindOfClass:[NSNull class]]||[nickname isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"nickname"];
        
        _nickname =@" ";
        
    }else
    {
        [_userInfoDic setObject:nickname forKey:@"nickname"];
        
        _nickname =nickname;
    }
    
    
    
    
    
    if (!tiqian||[tiqian isKindOfClass:[NSNull class]]||[tiqian isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"tiqian"];
        
        _tiqian =@" ";
    }else
    {
        [_userInfoDic setObject:tiqian forKey:@"tiqian"];
        
        _tiqian =tiqian;
    }
    
    
    
    if (!username||[username isKindOfClass:[NSNull class]]||[username isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"username"];
        
        _username =@" ";
    }else
    {
        [_userInfoDic setObject:username forKey:@"username"];
        
        _username =username;
    }
    
    
    if (!xing||[xing isKindOfClass:[NSNull class]]||[xing isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"xing"];
        
        _xing =@" ";
    }else
    {
        [_userInfoDic setObject:xing forKey:@"xing"];
        
        _xing =xing;
    }
    
    
    if (!xingqu||[xingqu isKindOfClass:[NSNull class]]||[xingqu isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"xingqu"];
        
        _xingqu =@" ";
    }else
    {
        [_userInfoDic setObject:xingqu forKey:@"xingqu"];
        _xingqu =xingqu;
    }
    
    
    
    if (!xueli||[xueli isKindOfClass:[NSNull class]]||[xueli isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"xueli"];
        _xueli =@" ";
        
    }else
    {
        [_userInfoDic setObject:xueli forKey:@"xueli"];
        
        _xueli =xueli;
    }
    
    if (!zhiye||[zhiye isKindOfClass:[NSNull class]]||[zhiye isMemberOfClass:[NSNull class]])
    {
        [_userInfoDic setObject:@"" forKey:@"zhiye"];
        
        _zhiye =@" ";
    }else
    {
        [_userInfoDic setObject:zhiye forKey:@"zhiye"];
        _zhiye = zhiye;
    }
    
    
    
    
    
    [_userInfoDic setObject:isLogin?@"1":@"0" forKey:@"isLogined"];
    
    
    
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"userInformation"];
    [setting setObject:_userInfoDic forKey:@"userInformation"];
    [setting synchronize];
    
    _userId =userId;
    _isLogin =isLogin;
    
    
}
@end
