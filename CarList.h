//
//  CarList.h
//  ZuChe
//
//  Created by apple  on 2017/3/1.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"
#import "UIImageView+WebCache.h"

@protocol PaiSheDelegate <NSObject>

- (void)paiSheCollect;

@end

@interface CarList : UITableViewCell<StarRatingViewDelegate,SDWebImageManagerDelegate>

//@property (nonatomic,strong)UILabel *scoreLabel;

@property (nonatomic , strong)NSDictionary *model;

@property (nonatomic , retain)UIImageView *cartu111;

@property (nonatomic , weak)id <PaiSheDelegate>pcDelegate;

@end
