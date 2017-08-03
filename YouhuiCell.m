//
//  YouhuiCell.m
//  ZuChe
//
//  Created by apple  on 2017/6/5.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "YouhuiCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Header.h"

@implementation YouhuiCell{
    
    UIView *backView;
    UILabel *type;
    UILabel *quan;
    UILabel *time;
    
    UILabel *xian;
    UILabel *bukeyong;
    
    UIView *jiage;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creat];
    }
    return self;
}
- (void)creat{
    
    backView = [UIView new];
    [self.contentView addSubview:backView];
    
    type = [UILabel new];
    [backView addSubview:type];
    
    quan = [[UILabel alloc] init];
    [backView addSubview:quan];
    
    time = [UILabel new];
    [backView addSubview:time];
    
    xian = [UILabel new];
    [backView addSubview:xian];
    
    jiage = [[UIView alloc] init];
    [backView addSubview:jiage];
}
- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    [self reloadCell];
}
- (void)reloadCell{
    
    CGFloat width = self.contentView.frame.size.width;
    
    backView.backgroundColor = Color(7, 187, 177);
    backView.layer.cornerRadius = width*0.03;
    
    type.text = _model[@"name"];
    type.textColor = [UIColor whiteColor];
    type.textAlignment = NSTextAlignmentLeft;
    type.adjustsFontSizeToFitWidth= YES;
    type.font = [UIFont systemFontOfSize:12];
    
    quan.text = [NSString stringWithFormat:@"%@元 %@",_model[@"total"],_model[@"name"]];
    quan.textAlignment = NSTextAlignmentLeft;
    quan.textColor = [UIColor whiteColor];
    quan.adjustsFontSizeToFitWidth = YES;
    quan.font = [UIFont boldSystemFontOfSize:17];
    
    xian.backgroundColor = [UIColor whiteColor];
    
    time.text = [NSString stringWithFormat:@"有效期:%@ 至 %@",_model[@"starttime"],_model[@"deltime"]];
    time.textColor = [UIColor whiteColor];;
    time.textAlignment = NSTextAlignmentLeft;
    time.adjustsFontSizeToFitWidth = YES;
//    time.font = [UIFont systemFontOfSize:12];
    
//    [jiage setTitle:[NSString stringWithFormat:@"¥ %@",_model[@"total"]] forState:UIControlStateNormal];
//    [jiage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jiage.backgroundColor = Color(0, 127, 127);
//    jiage.titleLabel.font = [UIFont boldSystemFontOfSize:24];
//    jiage.titleLabel.adjustsFontSizeToFitWidth = YES;
    jiage.layer.cornerRadius = width*0.03;
    
    
}
- (void)layoutSubviews{
    
    CGFloat width = self.contentView.frame.size.width;
    
    backView.frame = CGRectMake(width*0.05, width*0.02, width*0.9, width*0.24);
    
    type.frame = CGRectMake(backView.frame.size.width*0.03, backView.frame.size.width*0.03, backView.frame.size.width/3*2, backView.frame.size.height/4-width*0.01);
    
    quan.frame = CGRectMake(backView.frame.size.width*0.03, CGRectGetMaxY(type.frame), backView.frame.size.width/3*2, backView.frame.size.height/3);
    
    xian.frame = CGRectMake(backView.frame.size.width*0.03, CGRectGetMaxY(quan.frame)+width*0.01, backView.frame.size.width/3*2-width*0.06, 0.5);
    
    time.frame = CGRectMake(backView.frame.size.width*0.03, CGRectGetMaxY(quan.frame)+width*0.02, backView.frame.size.width/3*2-width*0.06, backView.frame.size.height/4-width*0.01);
    
    jiage.frame = CGRectMake(CGRectGetMaxX(quan.frame)-width*0.02, backView.frame.size.height/2-width*0.1, width*0.265, width*0.2);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, jiage.frame.size.width, jiage.frame.size.height)];
    label.text = [NSString stringWithFormat:@"¥ %@",_model[@"total"]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:24];
    [jiage addSubview:label];
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
