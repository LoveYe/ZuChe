//
//  HttpManager.m
//  封装方法
//
//  Created by 佐途 on 15/12/25.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager
+(void)liuLanpostData:(NSDictionary *)parames andUrl:(NSString *)Url success:(RequsetArrayBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:Url parameters:parames success:^(AFHTTPRequestOperation *operation, id rersponseObject) {
        
        NSLog(@"%@",rersponseObject);
        
        NSDictionary *dic =(NSDictionary*)rersponseObject;
        
        if ([dic[@"shop_list"] isKindOfClass:[NSArray class]])
        {
           NSArray*array=dic[@"shop_list"];
            successBlock(array);
        }
        else
        {
            NSArray*array=[NSArray array];
            successBlock(array);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString * errorString =[NSString stringWithFormat:@"%@",error];
        
        errorBlock(errorString);
        
    }];

}
+(void)postData:(NSDictionary *)parames andUrl:(NSString *)Url success:(RequestSylarBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:Url parameters:parames success:^(AFHTTPRequestOperation *operation, id rersponseObject) {
        
        NSDictionary *dic =rersponseObject;
        
        successBlock(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString * errorString =[NSString stringWithFormat:@"%@",error];
        
        errorBlock(errorString);
        
    }];
    
}

+(void)arrayPostData:(NSDictionary *)parames andUrl:(NSString *)Url Arraysuccess:(RequsetArrayBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:Url parameters:parames success:^(AFHTTPRequestOperation *operation, id rersponseObject) {
        
        NSArray *array =rersponseObject;
        
        successBlock(array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString * errorString =[NSString stringWithFormat:@"%@",error];
        
        errorBlock(errorString);
        
    }];
    
}
+(void)getData:(NSDictionary *)parames andUrl:(NSString *)Url success:(RequestSylarBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    
    [manager GET:Url parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic =responseObject;
        
        successBlock(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString * errorString =[NSString stringWithFormat:@"%@",error];
        
        errorBlock(errorString);
        
    }];
    
}
@end
