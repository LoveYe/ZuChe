//
//  ChaoPaoMapController.h
//  ZuChe
//
//  Created by apple  on 2017/7/12.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DituMapDelegate <NSObject>

- (void)dituSendMessage:(NSString *)sender;

@end

@interface ChaoPaoMapController : UIViewController

@property (nonatomic , weak)id <DituMapDelegate>delegate;

@end
