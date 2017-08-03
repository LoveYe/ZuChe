//
//  ShoucangViewCell.h
//  ZuChe
//
//  Created by apple  on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  DeleteDelegate <NSObject>

- (void)deleteCollection:(NSString *)carid type:(NSString *)type;

@end

@interface ShoucangViewCell : UITableViewCell

@property (nonatomic , strong)NSDictionary *model;

@property (nonatomic , retain)UIImageView *cartu111;

@property (nonatomic , weak)id <DeleteDelegate>delDelegate;

@end
