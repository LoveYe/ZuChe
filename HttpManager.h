//
//  HttpManager.h
//  封装方法
//
//  Created by 佐途 on 15/12/25.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"


//typedef void (^RequestSuccessBlock)(NSDictionary *dicData,AFHTTPRequestOperation *operation);
//typedef void (^RequestSuccessArrayBlock)(NSArray *arrData);
//typedef void (^RequestFailBlock)(NSString *error);
typedef void (^RequestSylarBlock)(NSDictionary*fanhuicanshu);
typedef void (^RequsetArrayBlock)(NSArray*arrayfanhui);

typedef void (^RequestSylarErrorBlock)(NSString *cuowuxingxi);

@interface HttpManager : NSObject


//+(void)postData:(NSDictionary *)dict url:(NSString *)url success:(void(^)(id responseDict))success faile :(void(^)(NSError*error))fail;
//
//+(void)getData:(NSDictionary *)dict url:(NSString *)url success:(void(^)(id responseDict))success faile :(void(^)(NSError*error))fail;


//+(void)postWithURL:(NSString *)resource params:(NSDictionary *)params success:(RequestSuccessBlock)successBlock failure:(RequestFailBlock)failureBlock;
+(void)liuLanpostData:(NSDictionary *)parames andUrl:(NSString *)Url success:(RequsetArrayBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock;

+(void)postData:(NSDictionary *)parames andUrl:(NSString *)Url success:(RequestSylarBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock;

+(void)arrayPostData:(NSDictionary *)parames andUrl:(NSString *)Url Arraysuccess:(RequsetArrayBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock;


+(void)getData:(NSDictionary *)parames andUrl:(NSString *)Url success:(RequestSylarBlock)successBlock Error:(RequestSylarErrorBlock)errorBlock;



@end
