//
//  UseWayViewController.h
//  ZuChe
//
//  Created by apple  on 16/10/14.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuedingJiaGeDelegate <NSObject>

- (void)sendAString:(NSString *)str;

@end

@interface UseWayViewController : UIViewController

@property (nonatomic , copy)NSString *fanhuiPrice;
@property (nonatomic , assign) NSInteger *Price;

@property (nonatomic , weak) id <QuedingJiaGeDelegate>delegate;

@property (nonatomic , copy)NSString *allName;
@property (nonatomic , copy)NSString *carid;

@end
