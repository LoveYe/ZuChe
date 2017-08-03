//
//  XQyemianViewController.h
//  ZuChe
//
//  Created by J.X.Y on 16/1/12.
//  Copyright © 2016年 佐途. All rights reserved.
//
#import "WXApi.h"
#import "WXApiObject.h"
#import "ParentsViewController.h"
#import "SHBQRView.h"
@protocol ParentsDelegate <NSObject>
@optional
@end
//
//测试商品信息封装在Product中,外部商户可以根据自己商品实际情况定义
//
@interface Product : NSObject{
    
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end
@interface XQyemianViewController : ParentsViewController <WXApiDelegate,SHBQRViewDelegate>
@property (nonatomic,retain)NSString *orderid;
@property (nonatomic,retain)NSString *dingdanhao8;
@property (nonatomic, assign) id<ParentsDelegate> delegate;
+ (instancetype)sharedManager;
@end
