//
//  XingchengTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/2/28.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "XcHistoryTableViewCell.h"
//#import "FMDB.h"
#import "Header.h"
#import "SDWebImage/UIImageView+WebCache.h"

#import "HttpManager.h"

@implementation XcHistoryTableViewCell {
    UIView *_bottomView;
    UIImageView *_imageView;
    UILabel *_carIdLable;
    UILabel *_yearLable;
    UILabel *_timeLable;
    UILabel *_whereLable;
    UIImageView *_rightImage;
    NSArray *_dataArray;
    NSArray *_commArray;
    NSMutableArray *dataSource;
    NSInteger flagTag;
    
    
    NSMutableArray *_dataArray1;
    
    NSMutableDictionary *_detailsDict;
    
    NSMutableArray *_gencheArray;
    NSMutableArray *_zhucheArray;
    
    
    
    NSString *_jieshuString;
    
    
    NSString *_s;
    
    UIView *_blackView;
    
    UILabel *_idLabel;
    
    UIView *bigView;
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
    
    
    _imageView = [UIImageView new];
    [_bottomView addSubview:_imageView];
    
    _blackView = [UIView new];
    _blackView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    //_blackView.backgroundColor = [UIColor redColor];
    [_bottomView addSubview:_blackView];
    
    
    
    _carIdLable = [UILabel new];
    [_bottomView addSubview:_carIdLable];
    
    _idLabel = [UILabel new];
    [_bottomView addSubview:_idLabel];
    
    
    _yearLable = [UILabel new];
    [_bottomView addSubview:_yearLable];
    _timeLable = [UILabel new];
    [_bottomView addSubview:_timeLable];
    
    _whereLable = [UILabel new];
    [self.contentView addSubview:_whereLable];
    
    _rightImage = [UIImageView new];
    [_bottomView addSubview:_rightImage];
    
}
-(void)setDict:(NSDictionary *)dict {
    
    _dict = dict;
    
    [self reallCell];
}

-(void)reallCell {
    
    if([_dict[@"carimgurl"] isKindOfClass:[NSNull class]]){
        
        _imageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
    }else {
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_dict[@"carimgurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    //    _idLabel.text = _dict[@"id"];
    //    _idLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //    _idLabel.textAlignment = NSTextAlignmentLeft;
    //    _idLabel.textColor = Color(7, 187, 177);
    //
    
    NSString *str1 = @"订单号: ";
    
    long len1 = [str1 length];
    
    NSString *nameStr = _dict[@"id"];
    
    NSString *str = [NSString stringWithFormat:@"订单号: %@",nameStr];
    
    
    
    long len2 = [nameStr length];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:7/255.0 green:187/255.0  blue:177/255.0  alpha:1] range:NSMakeRange(0,str2.length)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15 ] range:NSMakeRange(0,str2.length)];
    
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(len1,len2)];
    
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-boldMT" size:15] range:NSMakeRange(len1,len2)];
    
    
    _idLabel.attributedText = str2;
    
    
    
    _carIdLable.text = @"已取消";
    _carIdLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _carIdLable.textAlignment = NSTextAlignmentRight;
    _carIdLable.adjustsFontSizeToFitWidth = YES;
    _carIdLable.textColor = Color(7, 187, 177);
    
    _rightImage.image = [UIImage imageNamed:@"箭头右22.png"];
    _rightImage.alpha = 0.7;
    
    _yearLable.text = _dict[@"ntime"];
    _yearLable.adjustsFontSizeToFitWidth = YES;
    _yearLable.textColor = [UIColor whiteColor];
    _yearLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLable.text = _dict[@"ytime"];
    
    _timeLable.adjustsFontSizeToFitWidth = YES;
    
 
   
    _timeLable.textColor = [UIColor whiteColor];
    
    _timeLable.textAlignment = NSTextAlignmentCenter;
    
    _timeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];

    
    if ([_dict[@"address"] isKindOfClass:[NSNull class]]) {
        _whereLable.text = @"未确定地址";

    }else {
        _whereLable.text = _dict[@"address"];

    }
    _whereLable.textAlignment = NSTextAlignmentRight;
    _whereLable.textColor = [UIColor whiteColor];
    _whereLable.adjustsFontSizeToFitWidth = YES;
    _whereLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
}

-(UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *responder = [next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _bottomView.frame =CGRectMake(ScreenWidth*0.1, ScreenWidth*0.01, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    
    
    _imageView.frame = CGRectMake(0, 0, _bottomView.frame.size.width, ScreenWidth*0.8*8/11);
    
    
    _blackView.frame =CGRectMake(0, 0, ScreenWidth*0.8, ScreenWidth*0.8*8/11);
    // _imageView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    _carIdLable.frame = CGRectMake(ScreenWidth*0.55, ScreenWidth*0.01, ScreenWidth*0.2, ScreenWidth*0.05);
    _idLabel.frame = CGRectMake(ScreenWidth*0.01, ScreenWidth*0.01, ScreenWidth*0.3, ScreenWidth*0.05);
    _idLabel.adjustsFontSizeToFitWidth = YES;
    _idLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    //_carIdLable.backgroundColor = [UIColor greenColor];
    _idLabel.textAlignment = NSTextAlignmentCenter;
    _rightImage.frame = CGRectMake(ScreenWidth*0.75, CGRectGetMidY(_carIdLable.frame)-ScreenWidth*0.018, ScreenWidth*0.036, ScreenWidth*0.036);
    //_rightImage.backgroundColor = [UIColor redColor];
    
    _yearLable.frame = CGRectMake(0,  (ScreenWidth*0.8*8/11 -(ScreenWidth*0.18))/2, ScreenWidth*0.8, ScreenWidth*0.08);
    
    
    _timeLable.frame = CGRectMake(0, CGRectGetMaxY(_yearLable.frame)+ScreenWidth*0.02, ScreenWidth*0.8, ScreenWidth*0.08);
    ;
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
