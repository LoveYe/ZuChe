//
//  XingchengTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/2/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WB_Stopwatch.h"

@interface XingchengTableViewCell : UITableViewCell

@property(nonatomic , strong) NSDictionary *dict;
@property(nonatomic,strong) WB_Stopwatch *stopWatch;
@end
