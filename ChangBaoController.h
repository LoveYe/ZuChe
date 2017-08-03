//
//  ChangBaoController.h
//  ZuChe
//
//  Created by apple  on 16/11/22.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChangBaoDelegate <NSObject>

- (void)sendNews:(NSString *)str;

@end

@interface ChangBaoController : UIViewController

@property (nonatomic , weak)id <ChangBaoDelegate>delegate;

@property (nonatomic , assign)NSInteger numBer;

@property (nonatomic , assign)NSInteger tag;

@property (nonatomic , copy)NSString *carid;

@end
