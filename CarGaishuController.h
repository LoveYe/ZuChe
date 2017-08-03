//
//  CarGaishuController.h
//  ZuChe
//
//  Created by apple  on 16/11/22.
//  Copyright © 2016年 佐途. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol SmallDelegate<NSObject>

- (void)sendMessage;

@end

@interface CarGaishuController : UIViewController

@property (nonatomic,retain)NSString *MIAOSHU_id;
@property (nonatomic,retain)NSString *miaoshu;
@property (nonatomic , copy)NSString *carid;

@property (nonatomic , copy) NSString *gaishu;

@property (nonatomic, assign)id <SmallDelegate>delegate;

@end
