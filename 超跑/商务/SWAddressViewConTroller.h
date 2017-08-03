//
//  SWAddressViewConTroller.h
//  ZuChe
//
//  Created by apple  on 2017/7/12.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DituMapDelegate2 <NSObject>

- (void)dituSendMessage2:(NSString *)sender PriceTag:(float)priceTag;

@end

@interface SWAddressViewConTroller : UIViewController

@property (nonatomic , weak)id <DituMapDelegate2>delegate;
@property (nonatomic , copy)NSString *startAddress;

@end
