//
//  MyScrollView.h
//  ScrollViewTest1
//
//  Created by 吕中威 on 16/8/9.
//  Copyright © 2016年 吕中威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol View1Delegate <NSObject>

- (void)sendstr:(NSString *)str;

@end

@protocol PingjiaDelegate <NSObject>

- (void)openPingjia:(NSString *)str carid:(NSString *)carID;

@end

@interface MyScrollView : UIView <UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr carType:(NSArray *)carArray buZhou:(NSArray *)buzhouArray jiage:(NSArray *)price chaoshi:(NSArray *)chaoshiArray chaoKM:(NSArray *)chaoKMArray carID:(NSArray *)carIDArray;

@property (nonatomic , weak)id <View1Delegate>delegate;
@property (nonatomic , weak)id <PingjiaDelegate>pjDelegate;

@end
