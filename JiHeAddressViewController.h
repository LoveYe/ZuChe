//
//  JiHeAddressViewController.h
//  CarHead
//
//  Created by MacBookXcZl on 2017/6/19.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol addressDelgate <NSObject>

-(void)postAddressString:(NSString *)addressString AndNameString:(NSString *)nameString;

@end

@interface JiHeAddressViewController : UIViewController

@property(nonatomic,weak)id<addressDelgate>delegate;
@property(nonatomic,copy)NSString *postIdString;
@end
