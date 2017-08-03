//
//  RZController.h
//  ZuChe
//
//  Created by apple  on 16/12/6.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol RenZhengZLDelegate<NSObject>

- (void)SendNewNumber:(NSString *)str;

@end

@interface RZController : UIViewController

@property (nonatomic , weak)id <RenZhengZLDelegate>delegate1;
@property (nonatomic , copy)NSString *carid;

@end
