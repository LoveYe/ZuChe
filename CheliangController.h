//
//  CheliangController.h
//  ZuChe
//
//  Created by apple  on 16/12/5.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheliangDelegate <NSObject>

- (void)JianShaoshuzi:(int)a;

@end

@interface CheliangController : UIViewController

@property (retain ,nonatomic)NSString *carid;

@property (nonatomic , weak)id <CheliangDelegate>delegate;

@end
