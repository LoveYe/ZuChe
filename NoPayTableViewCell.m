//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "NoPayTableViewCell.h"
#import "Header.h"

@implementation NoPayTableViewCell {
    
    UIImageView *_leftImageView;
    UILabel *_nameAndCarIdLabel;
    UILabel *_rightStateLabel;
    UIButton *_stateButton;
    UIView *_gayView;
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
    
    
    _gayView = [UIView new];
    [self.contentView addSubview:_gayView];
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self viewStateSet];
}
-(void)viewStateSet {
    _leftImageView.image = [UIImage imageNamed:@"BigBen.jpg"];
    _nameAndCarIdLabel.text = [NSString stringWithFormat:@"%@",_nameDict[@"plate_name"]];
    _nameAndCarIdLabel.textColor = Color(140, 140, 140);
    _nameAndCarIdLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _nameAndCarIdLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _rightStateLabel.text = [NSString stringWithFormat:@"%@%@",_dict[@""],@"服务中"];
    _rightStateLabel.textColor = Color(7, 187, 177);
    _rightStateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _rightStateLabel.adjustsFontSizeToFitWidth = YES;
    
    
    [_stateButton setBackgroundImage:[UIImage imageNamed:@"BigBen,jpg"] forState:UIControlStateNormal];
    [_stateButton addTarget:self action:@selector(wzfButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_stateButton setTitleColor:[UIColor colorWithRed:170 green:170 blue:170 alpha:1] forState:UIControlStateNormal] ;
    [_stateButton setBackgroundImage:[UIImage imageNamed:@"电话222.png"] forState:UIControlStateNormal];
    // [_stateButton setTitle:[NSString stringWithFormat:@"%@%@",_dict[@""],@"接"] forState:UIControlStateNormal];

}
-(void)wzfButtonClick: (UIButton *)button {
    NSLog(@"点击了未支付页面的button");
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
    
    _gayView.frame = CGRectMake(0, 0.13*ScreenHeight, 0.9*ScreenWidth, 1);
    
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
