//
//  ZCUserData.h
//  ZuChe
//
//  Created by 佐途 on 15/11/9.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCorderid : NSObject

@property (strong, nonatomic) NSString *orderid;

@property(strong,nonatomic)NSMutableDictionary * userInfoDic;

+(ZCorderid *)share;

-(void)saveUserInfoWithOrderId:(NSString *)orderid ;

@end
