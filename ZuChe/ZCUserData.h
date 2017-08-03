//
//  ZCUserData.h
//  ZuChe
//
//  Created by 佐途 on 15/11/9.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUserData : NSObject

@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSString *fuwu;
@property (strong, nonatomic) NSString *jiedan;
@property (strong, nonatomic) NSString *lianxi;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *yinxiang;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *thumb;
@property (strong, nonatomic) NSString *tiqian;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *xing;
@property (strong, nonatomic) NSString *xingqu;
@property (strong, nonatomic) NSString *xueli;
@property (strong, nonatomic) NSString *zhiye;

@property (assign, nonatomic) BOOL isLogin;
@property(strong,nonatomic)NSMutableDictionary * userInfoDic;

+(ZCUserData *)share;

-(void)saveUserInfoWithUserId:(NSString *)userId  username:(NSString*)username  descriptions:(NSString*)descriptions mobile:(NSString*)mobile fuwu:(NSString*)fuwu jiedan:(NSString *)jiedan lianxi:(NSString*)lianxi yinxiang:(NSString *)yinxiang nickname:(NSString *)nickname thumb:(NSString *)thumb tiqian:(NSString *)tiqian  xing:(NSString *)xing xingqu:(NSString *)xingqu xueli:(NSString *)xueli zhiye:(NSString *)zhiye  IsLogin:(BOOL)isLogin ;

@end
