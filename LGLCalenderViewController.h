//
//  LGLCalenderViewController.h
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import <UIKit/UIKit.h>


@protocol RiliDeleGate <NSObject>

- (void)riliChuli:(NSString *)sender;

@end

typedef void(^SelectDateBalock)(NSMutableDictionary * paramas);


@interface LGLCalenderViewController : UIViewController

@property (nonatomic, copy) SelectDateBalock block;
- (void)seleDateWithBlock:(SelectDateBalock)block;

@property (nonatomic,retain)NSString *carid;
@property (nonatomic,retain)NSString *bukezutime;

@property (nonatomic , weak)id <RiliDeleGate>delegate;

@end
