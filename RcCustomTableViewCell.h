//
//  RcCustomTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/4/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPDragDropBadgeView.h"
#define kCellHeight 80

@interface RcCustomTableViewCell : UITableViewCell
///头像
@property (nonatomic,retain) UIImageView *avatarIV;
///真实姓名
@property (nonatomic,retain) UILabel *nameLabel;
///时间
@property (nonatomic,retain) UILabel *timeLabel;
///内容
@property (nonatomic,retain) UILabel *contentLabel;
///角标（UIView）
@property (nonatomic,retain) PPDragDropBadgeView *ppBadgeView;
@end
