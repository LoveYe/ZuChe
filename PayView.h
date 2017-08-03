//
//  PayView.h
//  ZuChe
//
//  Created by apple  on 2017/4/10.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayView : UIViewController

@property (nonatomic , copy)NSString *Dingdan;
@property (nonatomic , copy)NSString *jiage;

@property (nonatomic , strong)NSDictionary *weChatDic;
@property (nonatomic , copy)NSString *orderString;

@property (nonatomic , copy)NSString *baoxianName;
@property (nonatomic , copy)NSString *phoneNumber;
@property (nonatomic , copy)NSString *baoxianAddress;
@property (nonatomic , copy)NSString *baoxianYouBian;

@end
