//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "DengDaiPpTableViewCell.h"
#import "Header.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation DengDaiPpTableViewCell {
    
    
    UIImageView *_leftImageView;
    UILabel *_nameAndCarIdLabel;
    UILabel *_rightStateLabel;
    UIButton *_stateButton;
    
    //__block UILabel *_scoreLabel;
    WSStarRatingView *_wsStraRating;
    UIView *_gayView;
    UIView *bigView;
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
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(0.13*ScreenHeight+0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating];
    
    _scoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_scoreLabel];
    
    _gayView = [UIView new];
    [self.contentView addSubview:_gayView];
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self viewStateSet];
}

-(void)setPlane_name:(NSDictionary *)plane_name {
    _plane_name  = plane_name;
    
    if([_plane_name[@"cartu"] isKindOfClass:[NSNull class]]){
        _leftImageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
    }else {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_plane_name[@"cartu"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    _nameAndCarIdLabel.text = [NSString stringWithFormat:@"%@",_plane_name[@"plate_name"]];
    _nameAndCarIdLabel.textColor = Color(140, 140, 140);
    _nameAndCarIdLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    
    
    _rightStateLabel.text = [NSString stringWithFormat:@"%@",_plane_name[@"state"]];
    _rightStateLabel.textColor = Color(7, 187, 177);
    _rightStateLabel.textAlignment = NSTextAlignmentCenter;
    _rightStateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    
}
-(void)viewStateSet {
    
    
    
    [_stateButton setBackgroundImage:[UIImage imageNamed:@"BigBen.jpg"] forState:UIControlStateNormal];
    [_stateButton addTarget:self action:@selector(receiveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_stateButton setTitleColor:[UIColor colorWithRed:170 green:170 blue:170 alpha:1] forState:UIControlStateNormal] ;
//    电话222
    [_stateButton setBackgroundImage:[UIImage imageNamed:@"电话灰.png"] forState:UIControlStateNormal];
    // [_stateButton setTitle:[NSString stringWithFormat:@"%@%@",_dict[@""],@"接"] forState:UIControlStateNormal];
    
    //_scoreLabel.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0  blue:arc4random()%256/255.0  alpha:1];
    //    _scoreLabel.font = [UIFont systemFontOfSize:13];
    _scoreLabel.textColor = Color(170, 170, 170);
    _scoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    
    
    _wsStraRating.delegate = self;
    
    __block DengDaiPpTableViewCell *detaCell = self;
    
    [_wsStraRating setScore:1.0 withAnimation:YES completion:^(BOOL finished) {
        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",1.0 * 5 ];
    }];
    _gayView.backgroundColor = Color(233, 233, 233);
    
}
//- (void)starRatingView:(WSStarRatingView *)view score:(float)score
//{
//    _scoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
//    
//}

//0.13*screeHeight

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _leftImageView.frame = CGRectMake(0, 0.02*ScreenHeight, 0.13*ScreenHeight, 0.09*ScreenHeight);
    // _leftImageView.backgroundColor = [UIColor blackColor];
    
    _nameAndCarIdLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.01*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
    //_nameAndCarIdLabel.backgroundColor = [UIColor greenColor];
    _nameAndCarIdLabel.font = [UIFont systemFontOfSize:13];
    
    _rightStateLabel.frame = CGRectMake(0.7*ScreenWidth, 0.01*ScreenHeight, 0.2*ScreenWidth, 0.05*ScreenHeight);
    //  _rightStateLabel.backgroundColor = [UIColor greenColor];
    _rightStateLabel.font = [UIFont systemFontOfSize:13];
    
    _stateButton.frame = CGRectMake(0.8*ScreenWidth-0.025*ScreenHeight, CGRectGetMaxY(_rightStateLabel.frame), 0.05*ScreenHeight, 0.05*ScreenHeight);
    // _stateButton.backgroundColor = [UIColor purpleColor];
    _stateButton.layer.cornerRadius = 0.025*ScreenHeight;
    
    
    _wsStraRating.frame = CGRectMake(0.13*ScreenHeight+0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight);
    
    _scoreLabel.frame = CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, 0.09*ScreenHeight, 0.14*ScreenHeight, 0.02*ScreenHeight);
    //_wsStraRating.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.07*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
    _gayView.frame = CGRectMake(0, 0.13*ScreenHeight, 0.9*ScreenWidth, 1);
    
}
-(void)receiveButtonClick:(UIButton *)butto {
    NSLog(@"我让你打电话啊");
    [self AlertView];
}
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    bigView.tag = 1000;
    [self.window addSubview:bigView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenHeight/2- ScreenWidth*0.3/2, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"匹配车辆后才能联系";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
- (void)moveAll{
    
    [bigView removeFromSuperview];
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
