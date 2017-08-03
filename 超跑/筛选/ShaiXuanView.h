//
//  ShaiXuanView.h
//  ZuChe
//
//  Created by apple  on 2017/6/22.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShaiXuanDelegate <NSObject>

- (void)sendtime:(NSString *)time auto:(NSString *)autolist duoshao:(NSString *)duoshao;

@end

@interface ShaiXuanView : UIViewController

@property (nonatomic , copy)NSString *titleText;
@property (nonatomic , strong)id<ShaiXuanDelegate>delegate;

@property (nonatomic , copy)NSString *state;
@property (nonatomic , copy)NSString *bukezutime;
@property (nonatomic , copy)NSString *jiedan;

@end
