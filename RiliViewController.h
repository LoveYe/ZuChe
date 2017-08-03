//
//  RiliViewController.h
//  ZuChe
//
//  Created by apple  on 2017/7/17.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectDateBalock)(NSMutableDictionary * paramas);

@interface RiliViewController : UIViewController

@property (nonatomic, copy) SelectDateBalock block;
- (void)seleDateWithBlock:(SelectDateBalock)block;

@property (nonatomic , copy)NSString *carid;
@property (nonatomic , copy)NSString *bukezuTime;

@end
