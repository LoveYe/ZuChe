//
//  ChangBaoViewCell.h
//  ZuChe
//
//  Created by apple  on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"

@protocol ChangBaoDelegate <NSObject>

- (void)changbaoCollect;

@end

@interface ChangBaoViewCell : UITableViewCell<StarRatingViewDelegate>

@property (nonatomic , strong)NSDictionary *model;

@property (nonatomic , retain)UIImageView *cartu111;

@property (nonatomic , weak)id <ChangBaoDelegate>cbDelegate;

@end
