//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation  CommentTableViewCell{
    
    
    UIImageView *_leftImageView;
    UILabel *_nameAndCarIdLabel;
    UILabel *_carTypeLabel;
    
    UILabel *_bottomTextField;
    
    
    UILabel *_rightStateLabel;
  //  UIButton *_stateButton;
    
    WSStarRatingView1 *_topWsStraRating;
    WSStarRatingView1 *_midWsStraRating;
    WSStarRatingView1 *_upWsStraRating;
    
    UILabel *_wgLabel;
    UILabel *_nsLabel;
    UILabel *_fwLabel;
    
    UIView *_gayView;
    
    NSMutableArray *_sratArray;
    
    NSInteger flag;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customView];
    }
    return self;
}
-(void)customView {
    
    _sratArray = [NSMutableArray new];
    
    flag = 0;
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    
    _nameAndCarIdLabel = [UILabel new];
    [self.contentView addSubview:_nameAndCarIdLabel];

    _carTypeLabel = [UILabel new];
    [self.contentView addSubview:_carTypeLabel];
    
    _bottomTextField = [UILabel new];
    [self.contentView addSubview:_bottomTextField];
    
    _rightStateLabel = [UILabel new];
    [self.contentView addSubview:_rightStateLabel];
    
//    _stateButton = [UIButton new];
//    [self.contentView addSubview: _stateButton];
    
    _topWsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.018*ScreenHeight, 75, 0.03*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_topWsStraRating];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.018*ScreenHeight, 75, 0.03*ScreenHeight)];
     [self.contentView addSubview:view];
    
    _midWsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.049*ScreenHeight, 75, 0.03*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_midWsStraRating];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.049*ScreenHeight, 75, 0.03*ScreenHeight)];
    [self.contentView addSubview:view2];
    
    
    
    _upWsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.08*ScreenHeight, 75, 0.03*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_upWsStraRating];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.08*ScreenHeight, 75, 0.03*ScreenHeight)];
    [self.contentView addSubview:view3];
    
    _topScoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_topScoreLabel];
    _midScoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_midScoreLabel];
    _upScoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_upScoreLabel];
    
    _wgLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_wgLabel];
    _nsLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_nsLabel];
    _fwLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_fwLabel];
    
    _gayView = [UIView new];
    [self.contentView addSubview:_gayView];
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self viewStateSet];
}
-(void)viewStateSet {
    
    
    if([_dict[@"carimgurl"] isEqualToString:@""]){
        
        _leftImageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
    }else {
        
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com/%@",_dict[@"cartu"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    
    NSArray *stringArray = [_dict[@"plate_name"] componentsSeparatedByString:@"·"];
    _nameAndCarIdLabel.text = [NSString stringWithFormat:@"%@",_dict[@"name"]];
    _nameAndCarIdLabel.textColor = Color(180, 180, 180);
    _nameAndCarIdLabel.adjustsFontSizeToFitWidth = YES;
//    _nameAndCarIdLabel.backgroundColor  = [UIColor redColor];
    _nameAndCarIdLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    _carTypeLabel.text = [NSString stringWithFormat:@"%@",stringArray[1]];
//        _carTypeLabel.backgroundColor  = [UIColor redColor];
    _carTypeLabel.textColor = Color(180, 180, 180);
    _carTypeLabel.adjustsFontSizeToFitWidth = YES;
    _carTypeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
//    [_bottomTextField setTitle:@"服务很好，车子也很新———点击修改评价" forState:UIControlStateNormal];
////    _bottomButton.tintColor = Color(170, 170, 170);
//    [_bottomButton addTarget:self action:@selector(ButtonUpdate:) forControlEvents:UIControlEventTouchUpInside];
//    //_bottomButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    _bottomButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    UIColor *color = Color(237, 237, 237);
//    [_bottomTextField setTitleColor:color forState:UIControlStateNormal];
//    _bottomTextField.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//    _bottomTextField.placeholder = @"服务很好，车子也很新———点击修改评价";
      _bottomTextField.textAlignment = NSTextAlignmentLeft;
    
    //    UIColor *color = Color(237, 237, 237);
    //    [_bottomTextField setTitleColor:color forState:UIControlStateNormal];
    //    _bottomTextField.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //    _bottomTextField.placeholder = @"服务很好，车子也很新———点击修改评价";

    _topWsStraRating.delegate = self;
    _midWsStraRating.delegate = self;
    _upWsStraRating.delegate = self;
    
    __block CommentTableViewCell *detaCell = self;
    
    
    NSString *chexing = _dict[@"chexing"];
    NSString *fuwu = _dict[@"fuwuxing"];
    NSString *shouxng = _dict[@"shouxing"];
    
    _bottomTextField.text = _dict[@"content"];
    _bottomTextField.textColor = Color(197, 197, 197);
    _bottomTextField.textAlignment = NSTextAlignmentLeft;
    _bottomTextField.font = [UIFont systemFontOfSize:15];
    _bottomTextField.adjustsFontSizeToFitWidth = YES;
    _bottomTextField.userInteractionEnabled = NO;
    
    [_topWsStraRating setScore:[chexing floatValue]/5 withAnimation:YES completion:^(BOOL finished) {
        detaCell.topScoreLabel.text = [NSString stringWithFormat:@"%0.1f",[chexing floatValue]/5 * 5 ];
    }];
    [_midWsStraRating setScore:[fuwu floatValue]/5 withAnimation:YES completion:^(BOOL finished) {
        detaCell.midScoreLabel.text = [NSString stringWithFormat:@"%0.1f",[fuwu floatValue]/5* 5 ];
    }];
    [_upWsStraRating setScore:[shouxng floatValue]/5 withAnimation:YES completion:^(BOOL finished) {
        detaCell.upScoreLabel.text = [NSString stringWithFormat:@"%0.1f",[shouxng floatValue]/5 * 5 ];
    }];
    UIColor *borderColor = Color(197, 197, 197);
    _wgLabel.text = @"外观";
    _wgLabel.layer.borderColor = [borderColor CGColor];
    _wgLabel.layer.borderWidth = 1.3;
    _wgLabel.textAlignment = NSTextAlignmentCenter;
    _wgLabel.layer.cornerRadius = 3;
    _wgLabel.textColor = Color(197, 197, 197);
    _wgLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    
    _nsLabel.text = @"内饰";
    _nsLabel.layer.borderColor = [borderColor CGColor];
    _nsLabel.layer.borderWidth = 1.3;
    _nsLabel.layer.cornerRadius = 3;
    _nsLabel.textAlignment = NSTextAlignmentCenter;
    _nsLabel.textColor = Color(197, 197, 197);
    _nsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    
    _fwLabel.text = @"服务";
    _fwLabel.layer.borderColor = [borderColor CGColor];
    _fwLabel.layer.borderWidth = 1.3;
    _fwLabel.layer.cornerRadius = 3;
    _fwLabel.textAlignment = NSTextAlignmentCenter;
    _fwLabel.textColor = Color(197, 197, 197);
    _fwLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    _gayView.backgroundColor = Color(170, 170, 170);
//    if ([_topWsStraRating respondsToSelector:@selector(starRatingView:score:)]) {
//        NSLog(@"1");
//    }
//    if ([_midWsStraRating respondsToSelector:@selector(starRatingView:score:)]) {
//        NSLog(@"2");
//    }
//    if ([_upWsStraRating respondsToSelector:@selector(starRatingView:score:)]) {
//        NSLog(@"3");
//    }
   // [self starRatingView:_topWsStraRating score:1.0];
//    [self starRatingView:_midWsStraRating score:1.0];
//    [self starRatingView:_upWsStraRating score:1.0];
}

- (void)starRatingView:(WSStarRatingView1 *)view score:(float)score
{
    if (_topWsStraRating == view) {
        _topScoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
        NSLog(@"%@---------------------->",_topScoreLabel.text);
    }
    if (_midWsStraRating == view) {
        _midScoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
        NSLog(@"%@<----------------------",_midScoreLabel.text);
    }
    if (_upWsStraRating == view) {
        _upScoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
        NSLog(@"%@<---------------------->",_upScoreLabel.text);
    }
//    if ([_bottomTextField.text isEqualToString:@""]) {
//        _bottomTextField.text = @"服务很好,车子也很新";
//    }
//    
    
//    NSString *starString = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",_dict[@"carid"],_upScoreLabel.text,_topScoreLabel.text, _midScoreLabel.text,_bottomTextField.text];
//    
//    NSLog(@"%@",starString);
//    
////    if( [_topScoreLabel.text floatValue] == 5.0  &&   [_midScoreLabel.text floatValue] == 5.0 && [_bottomTextField.text floatValue] == 5.0) {
////        starString =  [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %ld",@"5.0",@"5.0",@"5.0",_bottomTextField.text,_dict[@"carid"],_index];
////    }
//    
//    [_sratArray addObject:starString];
////    
//  //  NSLog(@"%@////////////////////////////////////%ld",_sratArray,_sratArray.count);
//// 
//    NSDictionary *dict = @{ @"starSring":_sratArray};
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeString" object:nil userInfo:dict];
//
}

//0.13*screeHeight

-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    _leftImageView.frame = CGRectMake(0, 0.02*ScreenHeight, 0.13*ScreenHeight, 0.09*ScreenHeight);
    // _leftImageView.backgroundColor = [UIColor blackColor];
    
    _bottomTextField.frame = CGRectMake(0, CGRectGetMaxY(_leftImageView.frame)+0.01*ScreenHeight, 0.9*ScreenWidth, 0.03*ScreenHeight);
    
    //_bottom    _gayView.frame = CGRectMake(0, CGRectGetMaxY(_bottomTextField.frame), 0.9*ScreenWidth, 1);
    
    _nameAndCarIdLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.01*ScreenHeight, 0.12*ScreenHeight, 0.05*ScreenHeight);
    //_nameAndCarIdLabel.backgroundColor = [UIColor greenColor];
    
    _carTypeLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, CGRectGetMaxY(_nameAndCarIdLabel.frame)+5, 0.12*ScreenHeight, 0.05*ScreenHeight);
    //_nameAndCarIdLabel.backgroundColor = [UIColor greenColor];
    
    _rightStateLabel.frame = CGRectMake(0.7*ScreenWidth, 0.01*ScreenHeight, 0.2*ScreenWidth, 0.05*ScreenHeight);
    //  _rightStateLabel.backgroundColor = [UIColor greenColor];
    _rightStateLabel.font = [UIFont systemFontOfSize:13];
    
//    _stateButton.frame = CGRectMake(0.8*ScreenWidth-0.025*ScreenHeight, CGRectGetMaxY(_rightStateLabel.frame), 0.05*ScreenHeight, 0.05*ScreenHeight);
//    // _stateButton.backgroundColor = [UIColor purpleColor];
//    _stateButton.layer.cornerRadius = 0.025*ScreenHeight;
    _wgLabel.frame =  CGRectMake(0.9*ScreenWidth-0.21*ScreenHeight, 0.019*ScreenHeight+ScreenHeight*0.0025, 0.05*ScreenHeight, 0.025*ScreenHeight) ;
    _nsLabel.frame = CGRectMake(0.9*ScreenWidth-0.21*ScreenHeight, 0.05*ScreenHeight+ScreenHeight*0.0025, 0.05*ScreenHeight, 0.025*ScreenHeight);
    _fwLabel.frame = CGRectMake(0.9*ScreenWidth-0.21*ScreenHeight, 0.081*ScreenHeight+ScreenHeight*0.0025, 0.05*ScreenHeight, 0.025*ScreenHeight) ;
    // _.frame = CGRectMake(0.13*ScreenHeight+0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight);
    
   // _scoreLabel.frame = CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, 0.09*ScreenHeight, 0.14*ScreenHeight, 0.02*ScreenHeight);
    //_wsStraRating.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.07*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
  
}
-(void)receiveButtonClick:(UIButton *)butto {
    NSLog(@"我让你打电话啊");
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
