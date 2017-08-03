//
//  DetailsCarXclTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"


//@protocol CustomCellDelegate <NSObject>
//
//- (void)pushToNewPage;
//
//@end

@interface DetailsCarXclTableViewCell : UITableViewCell<StarRatingViewDelegate> 

@property (nonatomic ,strong)NSDictionary *dict;
//@property (nonatomic ,assign)id<CustomCellDelegate>Delgete;

//@property (nonatomic,strong)WSStarRatingView *wsStraRating;
@property (nonatomic,strong)UILabel *scoreLabel;
@property (nonatomic ,strong)NSDictionary *plane_name;

@end
