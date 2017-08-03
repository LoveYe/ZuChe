//
//  MyHttpManager.h
//  ZuChe
//
//  Created by 佐途 on 15/10/29.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHttpManager : NSObject
+(void)isLoginWithYou:(void(^)(NSDictionary *xinxiArray))block;
@end
