//
//  JSMapViewController.h
//  ZuChe
//
//  Created by apple  on 2017/7/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@protocol DituMapDelegate <NSObject>

- (void)dituSendMessage:(NSString *)sender PriceTag:(float)priceTag;

@end


@interface JSMapViewController : UIViewController

@property (nonatomic , weak)id <DituMapDelegate>delegate;
@property (nonatomic , copy)NSString *endAddress;
@property (nonatomic , copy)NSString *startAddrss;

@end
