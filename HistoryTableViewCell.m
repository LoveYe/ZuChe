//
//  XingchengTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/2/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"



@implementation HistoryTableViewCell {
    UIView *_bottomView;
    UIImageView *_imageView;
    UILabel *_carIdLable;
    UILabel *_yearLable;
    UILabel *_timeLable;
//    UIButton *_receiveButton;
//    UIButton *_refuseButton;
    
    UILabel *_statueLable;
    UIImageView *_rightImageView;
    
    UILabel *_whereLable;
    UIView *_blackView;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self  customTables];
        
    }
    return self;
}
-(void)customTables {
    
    
   
    
    _bottomView = [UIView new];
    [self.contentView addSubview:_bottomView];
    
  
    _blackView = [UIView new];
    _blackView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    //_blackView.backgroundColor = [UIColor redColor];
    [_bottomView addSubview:_blackView];

    
    _imageView = [UIImageView new];
    [_bottomView addSubview:_imageView];
    _carIdLable = [UILabel new];
    [_bottomView addSubview:_carIdLable];
    _yearLable = [UILabel new];
    [_bottomView addSubview:_yearLable];
    _timeLable = [UILabel new];
    [_bottomView addSubview:_timeLable];
    
//    _receiveButton = [UIButton new];
//    [self.contentView addSubview:_receiveButton];
//    _refuseButton = [UIButton new];
//    [self.contentView addSubview:_refuseButton];
    
    _whereLable = [UILabel new];
    [self.contentView addSubview:_whereLable];
    
    _statueLable = [UILabel new];
    [_bottomView addSubview:_statueLable];
    
    _rightImageView = [UIImageView new];
    [_bottomView addSubview:_rightImageView];
    
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self reallCell];
}

-(void)reallCell {
    if ([_dict[@"cartu1"] isKindOfClass:[NSNull class]]) {
        
    }else {
        
        NSString *cartuString = [NSString stringWithFormat:@"%@%@",@"http://wx.leisurecarlease.com",_dict[@"cartu1"]];
        
        BOOL let =  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:cartuString]];
        
        if (let) {
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:cartuString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            
        }else {
            
            _imageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
        }
    }
    
    NSString *str1 = @"订单号: ";
    
    long len1 = [str1 length];
    
    NSString *nameStr = _dict[@"orderid"];
    
    NSString *str = [NSString stringWithFormat:@"订单号: %@",nameStr];
    
    long len2 = [nameStr length];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:7/255.0 green:187/255.0  blue:177/255.0  alpha:1] range:NSMakeRange(0,str2.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15 ] range:NSMakeRange(0,str2.length)];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(len1,len2)];
    
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15] range:NSMakeRange(len1,len2)];
    
    _carIdLable.attributedText = str2;
    
    _yearLable.text =[NSString stringWithFormat:@"%@",_dict[@"ntime"]];
    _yearLable.textColor = [UIColor whiteColor];
    _yearLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLable.text =  [NSString stringWithFormat:@"%@",_dict[@"ytime"]];
    _timeLable.textColor = [UIColor whiteColor];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];

    _whereLable.text = _dict[@"address"];
    _whereLable.textAlignment = NSTextAlignmentRight;
    _whereLable.textColor = [UIColor whiteColor];
    _whereLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
 
    
    if ([_dict[@"state"] isKindOfClass:[NSNull class]]) {
         _statueLable.text = @"已取消";
    }else {
         _statueLable.text = _dict[@"state"];
    }
   
    _statueLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _statueLable.textAlignment = NSTextAlignmentRight;
    _statueLable.textColor = Color(7, 187, 177);
   // _statueLable.backgroundColor = [UIColor redColor];
    
    _rightImageView.image = [UIImage imageNamed:@"箭头右22.png"];
    _rightImageView.alpha = 0.7;
   // _rightImageView.backgroundColor = [UIColor purpleColor];
    
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    _bottomView.frame =CGRectMake(ScreenWidth*0.1, ScreenWidth*0.01, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    
    _imageView.frame = CGRectMake(0, 0, _bottomView.frame.size.width, ScreenWidth*0.8*8/11);
    
    _blackView.frame =CGRectMake(0, 0, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    
    _yearLable.frame = CGRectMake(0,  (ScreenWidth*0.8*8/11 -(ScreenWidth*0.18))/2, ScreenWidth*0.8, ScreenWidth*0.08);
    
    
    _timeLable.frame = CGRectMake(0, CGRectGetMaxY(_yearLable.frame)+ScreenWidth*0.02, ScreenWidth*0.8, ScreenWidth*0.08);
    ;
    
    _statueLable.frame = CGRectMake(ScreenWidth*0.55, ScreenWidth*0.01, ScreenWidth*0.2, ScreenWidth*0.05);
    
    _carIdLable.frame = CGRectMake(ScreenWidth*0.01, ScreenWidth*0.01, ScreenWidth*0.3, ScreenWidth*0.05);
    _carIdLable.adjustsFontSizeToFitWidth = YES;
    _carIdLable.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    //_carIdLable.backgroundColor = [UIColor greenColor];
    _carIdLable.textAlignment = NSTextAlignmentCenter;
    
    _rightImageView.frame = CGRectMake(ScreenWidth*0.75, CGRectGetMidY(_statueLable.frame)-ScreenWidth*0.018, ScreenWidth*0.036, ScreenWidth*0.036);
    _rightImageView.image = [UIImage imageNamed:@"箭头右22.png"];
    
    
    _whereLable.frame = CGRectMake(ScreenWidth*0.06, ScreenWidth*0.54, ScreenWidth*0.8, ScreenWidth*0.04);

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
