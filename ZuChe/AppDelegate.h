//
//  AppDelegate.h
//  ZuChe
//
//  Created by 佐途 on 15/10/20.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewcontroller.h"
#import "SecondTabbar.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;
 


@property(nonatomic,retain) NSMutableArray *friendsArray;
@property(nonatomic,retain) NSMutableArray *groupsArray;
@property (nonatomic, retain)RootViewcontroller *tabbarVC;

@property (nonatomic, retain)SecondTabbar *secTabbarVC;
/// func
+ (AppDelegate* )shareAppDelegate;

@end


