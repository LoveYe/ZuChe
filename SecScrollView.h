//
//  SecScrollView.h
//  ZuChe
//
//  Created by apple  on 2017/2/27.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecDelegate <NSObject>

- (void)sendtype:(NSString *)str price:(NSString *)pri color:(NSString *)col price1:(NSString *)price1 price2:(NSString *)price2;

@end


@protocol PingjiaDelegate2 <NSObject>

- (void)openPingjia2:(NSString *)str carid2:(NSString *)carID;

@end

@interface SecScrollView : UIView<UIScrollViewDelegate>

- (id)initWithframe:(CGRect)frame ImgArray:(NSArray *)array carType:(NSArray *)carArray buZhou:(NSArray *)buzhouArray jiage:(NSArray *)price chaoshi:(NSArray *)chaoshiArray chaoKM:(NSArray *)chaoKMArray carID:(NSArray *)carIDArray;;

@property (nonatomic , weak)id <SecDelegate>delegate;
@property (nonatomic , weak)id <PingjiaDelegate2>pjDelegate;

@end
