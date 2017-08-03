//
//  AllPointsViewController.h
//  CarHead
//
//  Created by MacBookXcZl on 2017/5/17.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
// 既采用自定义气泡，也使用自定义的大头针标记

#import <MAMapKit/MAMapKit.h>
@interface AliMapViewCustomAnnotationView : MAAnnotationView
@property (strong,nonatomic)UIView *calloutView;//自定义气泡

@property (nonatomic, strong)UIImage *tuImage;
@property (nonatomic, strong)UIImage *telImage;

@property(nonatomic,copy)NSString *xingString;

@end
