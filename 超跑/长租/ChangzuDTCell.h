//
//  ChangzuDTCell.h
//  ZuChe
//
//  Created by apple  on 2017/7/14.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <RongIMKit/RongIMKit.h>

#import "iCarousel.h"
#import "WSStarRatingView.h"


@protocol CarDetailDelegate <NSObject>

- (void)sendPSG:(NSDictionary *)sender;
- (void)sendCarId:(NSString *)carID sendPSG:(NSString *)sender;
- (void)pinglunUserID:(NSString *)userID;
- (void)fuwuUserID;

@end

@interface ChangzuDTCell : UITableViewCell<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,UIScrollViewDelegate,iCarouselDelegate,iCarouselDataSource,RCIMUserInfoDataSource,StarRatingViewDelegate>

@property (nonatomic , strong)MAMapView *mapView;
@property (nonatomic , strong) AMapLocationManager *service;

@property (nonatomic , strong)NSDictionary *model;

@property (nonatomic , strong)id <CarDetailDelegate>dicDelegate;

@property (nonatomic,strong) iCarousel *iCarousel;

@property (nonatomic,strong)UILabel *scoreLabel;
@property (nonatomic,strong)UILabel *scoreLabel1;
@property (nonatomic,strong)UILabel *scoreLabel2;
@property (nonatomic,strong)UILabel *scoreLabel3;
@property (nonatomic,strong)UILabel *scoreLabel4;

@end
