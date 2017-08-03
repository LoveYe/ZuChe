//
//  MyHttpManager.m
//  ZuChe
//
//  Created by 佐途 on 15/10/29.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "MyHttpManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation MyHttpManager

+(void)isLoginWithYou:(void (^)(NSDictionary *xinxiArray))block
{
      NSString * string =@"";
    AFHTTPRequestOperationManager * manger =[AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"model",@"我曾穿过山和大海",@"username",@"111",@"passwprds", nil];
    [manger  POST:string parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSDictionary * dic =responseObject;
    
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败信息");

    }];

}
@end
