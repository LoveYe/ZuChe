//
//  CommentTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/3/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView1.h"



@interface NoPjDjmTableViewCell : UITableViewCell<StarRatingViewDelegate1>

@property (nonatomic ,strong)NSDictionary *dict;
@property (nonatomic,strong)UILabel *topScoreLabel;
@property (nonatomic,strong)UILabel *midScoreLabel;
@property (nonatomic,strong)UILabel *upScoreLabel;
@property (nonatomic,strong)NSString *plat_name;
@property (nonatomic,assign)NSInteger car_type;

@property (nonatomic,assign)NSInteger index;


@property (nonatomic ,strong)NSMutableArray *arry1;
@property (nonatomic ,strong)NSMutableArray *arry2;
@property (nonatomic ,strong)NSMutableArray *arry3;
@property(nonatomic,strong)NSMutableArray*lastArray;
@property(nonatomic,copy)NSMutableString*xingString;
@property(nonatomic,strong) UITextField *bottomTextField;


@end
