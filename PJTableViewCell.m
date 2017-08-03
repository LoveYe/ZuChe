//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "PJTableViewCell.h"
#import "Header.h"
#import "SDWebImage/UIImageView+WebCache.m"
//#import "SDWebImage/UIImageView+WebCache.h"

@implementation PJTableViewCell {
    
    UIImageView *_leftImageView;
    UILabel *_nameAndCarIdLabel;
    UILabel *_rightStateLabel;
    UIButton *_stateButton;
    
    //__block UILabel *_scoreLabel;
    WSStarRatingView1 *_wsStraRating;
    UIView *_gayView;
    UIView *bigView;
    
    UILabel *_numberLabel;
    UIImageView *_rightImageView;
    UIView *_dangXingView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customView];
    }
    return self;
}
-(void)customView {
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    
    _nameAndCarIdLabel = [UILabel new];
    [self.contentView addSubview:_nameAndCarIdLabel];
    
    _rightStateLabel = [UILabel new];
    [self.contentView addSubview:_rightStateLabel];
    
    _stateButton = [UIButton new];
    [self.contentView addSubview: _stateButton];
    
    _wsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(ScreenWidth*0.05+0.13*ScreenHeight+0.03*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating];
    
    _scoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_scoreLabel];
    
    _gayView = [UIView new];
    [self.contentView addSubview:_gayView];
    
    _numberLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_numberLabel];
    
    
    _rightImageView = [UIImageView new];
    [self.contentView addSubview:_rightImageView];
    _dangXingView = [UIView new];
    [self.contentView addSubview:_dangXingView];
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self viewStateSet];
}


-(void)viewStateSet {
    
    
    
    if([_dict[@"thumb"] isKindOfClass:[NSNull class]]){
                _leftImageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
            }else {
                [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_dict[@"thumb"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
    }

        _nameAndCarIdLabel.text = [NSString stringWithFormat:@"· %@",_dict[@"plate"]];
        _nameAndCarIdLabel.textColor = Color(107, 107, 107);
        _nameAndCarIdLabel.adjustsFontSizeToFitWidth = YES;
        _nameAndCarIdLabel.font = [UIFont systemFontOfSize:15];
    
    
    _scoreLabel.textColor = Color(107, 107, 107);
    _scoreLabel.font = [UIFont systemFontOfSize:15];
    
    
    _wsStraRating.delegate = self;
    
    __block PJTableViewCell *detaCell = self;
    
    NSInteger pingxing = [_dict[@"pingjunxing"] integerValue];
    
    [_wsStraRating setScore:pingxing/5.0 withAnimation:YES completion:^(BOOL finished) {
        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",pingxing/5.0 * 5 ];
    }];
    _gayView.backgroundColor = Color(233, 233, 233);
    _rightImageView.image = [UIImage imageNamed:@"右(1).png"];
    _rightImageView.alpha = 0.7;

    
    _numberLabel.text = [NSString stringWithFormat:@"%@条",_dict[@"num"]];
    _numberLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    _numberLabel.textColor = Color(107, 107, 107);
    _numberLabel.adjustsFontSizeToFitWidth = YES;
    _numberLabel.textAlignment = NSTextAlignmentRight;
    
    
    
   // _dangXingView.userInteractionEnabled = NO;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _leftImageView.frame = CGRectMake(ScreenWidth*0.05, 0.02*ScreenHeight, 0.13*ScreenHeight, 0.09*ScreenHeight);
    // _leftImageView.backgroundColor = [UIColor blackColor];
    
    _nameAndCarIdLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.03*ScreenHeight, 0.01*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);

    _rightStateLabel.frame = CGRectMake(0.7*ScreenWidth, 0.01*ScreenHeight, 0.2*ScreenWidth, 0.05*ScreenHeight);

    _stateButton.frame = CGRectMake(0.8*ScreenWidth-0.025*ScreenHeight, CGRectGetMaxY(_rightStateLabel.frame), 0.05*ScreenHeight, 0.05*ScreenHeight);
    // _stateButton.backgroundColor = [UIColor purpleColor];
    _stateButton.layer.cornerRadius = 0.025*ScreenHeight;
    
    
    //    _wsStraRating.frame = CGRectMake(0.13*ScreenHeight+0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight);
    //
    _scoreLabel.frame = CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, 0.09*ScreenHeight, 0.14*ScreenHeight, 0.02*ScreenHeight);
    //_wsStraRating.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.07*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
    _gayView.frame = CGRectMake(0.05*ScreenWidth, 0.13*ScreenHeight, 0.9*ScreenWidth, 1);
 
    _rightImageView.frame = CGRectMake(ScreenWidth*0.9-20,ScreenHeight*0.13/2-10, 20, 20);
 //   _rightImageView.backgroundColor = [UIColor redColor];
    
    _numberLabel.frame = CGRectMake(ScreenWidth*0.9-60-20,ScreenHeight*0.13/2-20, 60, 40);
    
  //  _numberLabel.backgroundColor = [UIColor blueColor];
    _dangXingView.frame = CGRectMake(ScreenWidth*0.05+0.13*ScreenHeight+0.03*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight);
    
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
