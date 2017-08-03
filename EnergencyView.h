//
//  EnergencyView.h
//  ZuChe
//
//  Created by apple  on 2017/3/27.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol phoneNumberDelegate <NSObject>

- (void)sender:(NSString *)str;

@end

@interface EnergencyView : UIViewController

@property (nonatomic , weak)id <phoneNumberDelegate>delegate;

@end
