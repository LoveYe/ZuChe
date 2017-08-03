//
//  PjDemoTableViewCell.h
//  PingJiaDemo
//
//  Created by MacBookXcZl on 2017/5/10.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"
#import "UIImageView+WebCache.h"


@interface PjDemoTableViewCell : UITableViewCell<StarRatingViewDelegate,SDWebImageManagerDelegate>

@property (nonatomic , strong)NSDictionary *model;


@property(nonatomic,copy)NSString *textString;


@property (nonatomic,strong)UILabel *scoreLabel;


 @property (nonatomic,strong)UIImageView *carsImageView;
 @property (nonatomic,strong)UIImageView *carsImageView2;
 @property (nonatomic,strong)UIImageView *carsImageView3;
 @property (nonatomic,strong)UIImageView *carsImageView4;



@end
