//
//  MyAnnomationView.h
//  Dmeo
//
//  Created by Liyn on 2017/7/3.
//  Copyright © 2017年 WYJdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyAnnomationView : UIImageView
@property (nonatomic, copy)NSString* typeString;
- (instancetype)initWithFrame:(CGRect)frame typeString:(NSString*)typeString;
//- (void)becomeBig;
- (void)becomeLittle;
- (void)transForm;
@end
