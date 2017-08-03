//
//  DetailsCarXclTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView1.h"


@interface PJTableViewCell : UITableViewCell<StarRatingViewDelegate1>

@property (nonatomic ,strong)NSDictionary *dict;
//@property (nonatomic ,assign)id<CustomCellDelegate>Delgete;

@property (nonatomic,strong)WSStarRatingView1 *wsStraRating;
@property (nonatomic,strong)UILabel *scoreLabel;


@end
