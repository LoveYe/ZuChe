//
//  DituViewController.h
//  ZuChe
//
//  Created by apple  on 2017/7/12.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addressDelgate <NSObject>

-(void)postAddressString:(NSString *)addressString priceTag:(float)priceTag;

@end

@interface DituViewController : UIViewController

@property(nonatomic,weak)id<addressDelgate>delegate;
@property(nonatomic,copy)NSString *postIdString;

@property (nonatomic , assign)BOOL abc;
@property (nonatomic , assign)float price;

@end
