//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "NoPjDjmTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "ZJD_StarEvaluateView.h"

@implementation  NoPjDjmTableViewCell{
    
    
    UIImageView *_leftImageView;
    UILabel *_nameAndCarIdLabel;
    UILabel *_carTypeLabel;
    

    
    UILabel *_rightStateLabel;
    UIButton *_stateButton;
    
//    WSStarRatingView1 *_topWsStraRating;
//    WSStarRatingView1 *_midWsStraRating;
//    WSStarRatingView1 *_upWsStraRating;
    
    UILabel *_wgLabel;
    UILabel *_nsLabel;
    UILabel *_fwLabel;
    
    UIView *_gayView;
    
    NSMutableArray *_sratArray;
    
    NSInteger flag;
    
    ZJD_StarEvaluateView *_starView;
    ZJD_StarEvaluateView *_starView1;
    ZJD_StarEvaluateView *_starView2;
    
    
//    
//    NSMutableArray *_array1;
//    NSMutableArray *_array2;
//    NSMutableArray *_array3;
    //UIView *bigView;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customView];
    }
    return self;
}
-(void)customView {
    
    _sratArray = [NSMutableArray new];
    _xingString = [NSMutableString new];
    self.arry1 = [NSMutableArray new];
    self.arry2 = [NSMutableArray new];
    self.arry3 = [NSMutableArray new];
    self.lastArray = [NSMutableArray new];
    flag = 0;
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    
    _nameAndCarIdLabel = [UILabel new];
    [self.contentView addSubview:_nameAndCarIdLabel];
    
    _carTypeLabel = [UILabel new];
    [self.contentView addSubview:_carTypeLabel];
    
    _bottomTextField = [UITextField new];
    [self.contentView addSubview:_bottomTextField];
    
    _rightStateLabel = [UILabel new];
    [self.contentView addSubview:_rightStateLabel];
    
    _stateButton = [UIButton new];
    [self.contentView addSubview: _stateButton];
    

    CGFloat starWidth = 15.f;
    CGFloat space = 0.3;
    BOOL isCanTap = YES;
    _starView = [[ZJD_StarEvaluateView alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.019*ScreenHeight, 75, 0.03*ScreenHeight) starIndex:5 starWidth:starWidth space:space defaultImage:nil lightImage:nil isCanTap:isCanTap];
    
   // _starView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_starView];
    
    _starView1 = [[ZJD_StarEvaluateView alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.05*ScreenHeight, 75, 0.03*ScreenHeight) starIndex:5 starWidth:starWidth space:space defaultImage:nil lightImage:nil isCanTap:isCanTap];
      // _starView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_starView1];
    
    
    _starView2 = [[ZJD_StarEvaluateView alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-85, 0.081*ScreenHeight, 75, 0.03*ScreenHeight) starIndex:5 starWidth:starWidth space:space defaultImage:nil lightImage:nil isCanTap:isCanTap];
    
   // _starView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_starView2];
    
   // _topWsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-0.085*ScreenHeight, 0.02*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
   // [self.contentView addSubview:_topWsStraRating];
//    _midWsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-0.085*ScreenHeight, 0.05*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
//    [self.contentView addSubview:_midWsStraRating];
//    _upWsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(0.9*ScreenWidth-0.085*ScreenHeight, 0.08*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
//    [self.contentView addSubview:_upWsStraRating];
//    
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
    _nameAndCarIdLabel.text = [NSString stringWithFormat:@"%@",stringArray[0]];
    _nameAndCarIdLabel.textColor = Color(180, 180, 180);
    //    _nameAndCarIdLabel.backgroundColor  = [UIColor redColor];
    _nameAndCarIdLabel.adjustsFontSizeToFitWidth = YES;
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
//    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"服务很好并且车子也很新———点击修改评价"];
//    UIColor *syColor =Color(237, 237, 237);
//    [attributedStr addAttribute:NSForegroundColorAttributeName value:syColor range:NSMakeRange(0, attributedStr.length)];
//    [_bottomTextField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    

    
    self.bottomTextField.textAlignment = NSTextAlignmentLeft;
    self.bottomTextField.placeholder = @"服务很好车子也很新";
    self.bottomTextField.textAlignment = NSTextAlignmentLeft;
    
    //    UIColor *color = Color(237, 237, 237);
    //    [_bottomTextField setTitleColor:color forState:UIControlStateNormal];
    //    _bottomTextField.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    //    _bottomTextField.placeholder = @"服务很好，车子也很新———点击修改评价";
    
//    _topWsStraRating.delegate = self;
//    _midWsStraRating.delegate = self;
//    _upWsStraRating.delegate = self;
//    
//    __block NoPjDjmTableViewCell *detaCell = self;
//    
//    [_topWsStraRating setScore:1.0 withAnimation:YES completion:^(BOOL finished) {
//        detaCell.topScoreLabel.text = [NSString stringWithFormat:@"%0.1f",1.0 * 5 ];
//    }];
//    [_midWsStraRating setScore:1.0 withAnimation:YES completion:^(BOOL finished) {
//        detaCell.midScoreLabel.text = [NSString stringWithFormat:@"%0.1f",1.0 * 5 ];
//    }];
//    [_upWsStraRating setScore:1.0 withAnimation:YES completion:^(BOOL finished) {
//        detaCell.upScoreLabel.text = [NSString stringWithFormat:@"%0.1f",1.0 * 5 ];
//    }];
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
    
    _gayView.backgroundColor = Color(233, 233, 233);

   
    NSString *carid = [NSString stringWithFormat:@"%@|%@",self.dict[@"carid"],@"5"];
    NSString *pl = [NSString stringWithFormat:@"|5|%@",@"服务很好车子也很新"];
    [self.lastArray addObjectsFromArray:[NSMutableArray arrayWithArray:@[carid,@"|5",pl]]];
    
    __block NoPjDjmTableViewCell *dell = self;
  //  NSString *starString;
    
    _starView.starEvaluateBlock = ^(ZJD_StarEvaluateView * starView, NSInteger starIndex){
        NSLog(@"%ld",starIndex);
        [dell.arry1 removeAllObjects];
        [dell.arry1 addObject: [NSString stringWithFormat:@"%@|%ld",dell.dict[@"carid"],starIndex]];
        [dell.lastArray replaceObjectAtIndex:0 withObject:dell.arry1.lastObject];
          NSLog(@"%@111",dell.arry1);
    };
    _starView1.starEvaluateBlock = ^(ZJD_StarEvaluateView * starView, NSInteger starIndex){
        NSLog(@"%ld",starIndex);
        [dell.arry2 removeAllObjects];
        [dell.arry2 addObject:[NSString stringWithFormat:@"|%ld",starIndex]];
        NSLog(@"%@222",dell.arry2);
        
        
        [dell.lastArray replaceObjectAtIndex:1 withObject:dell.arry2.lastObject];
        NSLog(@"%@111",dell.arry1);
    };
//    NSString *a = _bottomTextField.placeholder;
//    NSString *b = _bottomTextField.text;
    _starView2.starEvaluateBlock = ^(ZJD_StarEvaluateView * starView, NSInteger starIndex){
        NSLog(@"%ld",starIndex);
         [dell.arry3 removeAllObjects];
        [dell.arry3 addObject:[NSString stringWithFormat:@"|%ld|%@",starIndex,dell.bottomTextField.text]];
        NSLog(@"%@333",dell.arry3);
        
       [dell.lastArray replaceObjectAtIndex:2 withObject:dell.arry3.lastObject];
        NSLog(@"%@111",dell.arry1);
        
        };
    

    
        NSDictionary *dict = @{@"starSring":dell.lastArray,@"content":_bottomTextField.text};
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeString" object:nil userInfo:dict];
  
    //
    
}

//- (void)starRatingView:(WSStarRatingView1 *)view score:(float)score
//{
//    if (_topWsStraRating == view) {
//        _topScoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
//        NSLog(@"%@---------------------->",_topScoreLabel.text);
//    }
//    if (_midWsStraRating == view) {
//        _midScoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
//        NSLog(@"%@<----------------------",_midScoreLabel.text);
//    }
//    if (_upWsStraRating == view) {
//        _upScoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
//        NSLog(@"%@<---------------------->",_upScoreLabel.text);
//    }
//    if ([_bottomTextField.text isEqualToString:@""]) {
//        _bottomTextField.text = @"服务很好并且车子也很新";
//    }
//    
//    
//    NSString *starString = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",_dict[@"carid"],_upScoreLabel.text,_topScoreLabel.text, _midScoreLabel.text,_bottomTextField.text];
//    
//    NSLog(@"%@",starString);
//    
//    //    if( [_topScoreLabel.text floatValue] == 5.0  &&   [_midScoreLabel.text floatValue] == 5.0 && [_bottomTextField.text floatValue] == 5.0) {
//    //        starString =  [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %ld",@"5.0",@"5.0",@"5.0",_bottomTextField.text,_dict[@"carid"],_index];
//    //    }
//    
//    [_sratArray addObject:starString];
//    //
//    //  NSLog(@"%@////////////////////////////////////%ld",_sratArray,_sratArray.count);
//    //
//    NSDictionary *dict = @{ @"starSring":_sratArray};
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeString" object:nil userInfo:dict];
//    
//}

//0.13*screeHeight

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _leftImageView.frame = CGRectMake(0, 0.02*ScreenHeight, 0.13*ScreenHeight, 0.09*ScreenHeight);
    // _leftImageView.backgroundColor = [UIColor blackColor];
    
    _bottomTextField.frame = CGRectMake(0, CGRectGetMaxY(_leftImageView.frame)+0.01*ScreenHeight, 0.9*ScreenWidth, 0.03*ScreenHeight);
    
    //_bottomButton.backgroundColor = [UIColor redColor];
    
    _gayView.frame = CGRectMake(0, CGRectGetMaxY(_bottomTextField.frame), 0.9*ScreenWidth, 1);
    
    _nameAndCarIdLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.01*ScreenHeight, 0.12*ScreenHeight, 0.05*ScreenHeight);
    //_nameAndCarIdLabel.backgroundColor = [UIColor greenColor];
    
    _carTypeLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, CGRectGetMaxY(_nameAndCarIdLabel.frame)+5, 0.12*ScreenHeight, 0.05*ScreenHeight);
    //_nameAndCarIdLabel.backgroundColor = [UIColor greenColor];
    
    _rightStateLabel.frame = CGRectMake(0.7*ScreenWidth, 0.01*ScreenHeight, 0.2*ScreenWidth, 0.05*ScreenHeight);
    //  _rightStateLabel.backgroundColor = [UIColor greenColor];
    _rightStateLabel.font = [UIFont systemFontOfSize:13];
    
    _stateButton.frame = CGRectMake(0.8*ScreenWidth-0.025*ScreenHeight, CGRectGetMaxY(_rightStateLabel.frame), 0.05*ScreenHeight, 0.05*ScreenHeight);
    // _stateButton.backgroundColor = [UIColor purpleColor];
    _stateButton.layer.cornerRadius = 0.025*ScreenHeight;
    
    _wgLabel.frame =  CGRectMake(0.9*ScreenWidth-0.21*ScreenHeight, 0.019*ScreenHeight+ScreenHeight*0.0025, 0.05*ScreenHeight, 0.025*ScreenHeight) ;
    _nsLabel.frame = CGRectMake(0.9*ScreenWidth-0.21*ScreenHeight, 0.05*ScreenHeight+ScreenHeight*0.0025, 0.05*ScreenHeight, 0.025*ScreenHeight);
    _fwLabel.frame = CGRectMake(0.9*ScreenWidth-0.21*ScreenHeight, 0.081*ScreenHeight+ScreenHeight*0.0025, 0.05*ScreenHeight, 0.025*ScreenHeight) ;
    
    // _.frame = CGRectMake(0.13*ScreenHeight+0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight);
    
    // _scoreLabel.frame = CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, 0.09*ScreenHeight, 0.14*ScreenHeight, 0.02*ScreenHeight);
    //_wsStraRating.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.07*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
    
}
-(void)receiveButtonClick:(UIButton *)butto {
    NSLog(@"我让你打电话啊");
  //  [self AlertView];
    
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
