//
//  ItineraryTableViewCell.h
//  ZuChe
//
//  Created by 佐途 on 15/10/30.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItineraryTableViewCell : UITableViewCell
@property (nonatomic,retain)UIButton * photo;
@property (nonatomic,retain)UILabel * name  ;
@property (nonatomic,retain)UILabel * date  ;
@property (nonatomic,retain)UILabel * time  ;
@property (nonatomic,retain)UILabel * price  ;
@property (nonatomic,retain)UILabel * address  ;
@property (nonatomic,retain)UILabel * jiage  ;
@property (nonatomic,retain)UILabel * jiliang  ;
@property (nonatomic,retain)UILabel * heji  ;
@property (nonatomic,retain)UILabel * shijian  ;
@property (nonatomic,retain)UILabel * chepai  ;
@property (nonatomic,retain)UIImageView *imageView3;
@property (nonatomic,copy)NSString *carid;
@property (nonatomic,copy)NSString *orderids;
@property (nonatomic,copy)NSString *dingdanhao888;

@end
