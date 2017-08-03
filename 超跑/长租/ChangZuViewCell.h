//
//  ChangZuViewCell.h
//  ZuChe
//
//  Created by apple  on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"

@protocol SendTag <NSObject>

- (void)sendTag:(NSInteger )indexpath;

@end

@interface ChangZuViewCell : UITableViewCell<StarRatingViewDelegate>

@property (nonatomic , strong)NSDictionary *model;

@property (nonatomic , retain)UIImageView *cartu111;

@property (nonatomic , strong)id <SendTag>sendDelegate;

@property (nonatomic , assign)NSInteger index;

@end
