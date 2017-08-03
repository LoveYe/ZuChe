//
//  CarOwnerCell.h
//  ZuChe
//
//  Created by apple  on 2017/2/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarListModel.h"

@interface CarOwnerCell : UITableViewCell

@property (nonatomic , strong)NSDictionary *model;
@property (nonatomic , copy)NSString *username;
@property (nonatomic , copy)NSString *sex;

@end
