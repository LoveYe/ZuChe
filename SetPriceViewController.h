//
//  SetPriceViewController.h
//  ZuChe
//
//  Created by apple  on 16/10/18.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendPriceDelegate <NSObject>

- (void)sendMessage:(NSString *)str sendNUm:(NSInteger)num;

@end


@interface SetPriceViewController : UIViewController

@property (nonatomic , assign)NSInteger number;
@property (weak , nonatomic)id <SendPriceDelegate>delegate;

@property (nonatomic , assign)NSInteger tag;
@property (nonatomic , copy)NSString *carid;

@end
