//
//  CarOwnerCell.m
//  ZuChe
//
//  Created by apple  on 2017/2/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CarOwnerCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Header.h"

@implementation CarOwnerCell{
    
    UIImageView *imageXing;
    UIImageView *iconImage;
    UILabel *nameLabel;
    UILabel *levelLabel;
    
    UILabel *wait;
    UILabel *wait2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customView];
    }
    return self;
}
- (void)customView{
    
    iconImage = [UIImageView new];
    [self.contentView addSubview:iconImage];
    
    nameLabel = [UILabel new];
    [self.contentView addSubview:nameLabel];
    
    levelLabel = [UILabel new];
    [self.contentView addSubview:levelLabel];
    
    wait = [UILabel new];
    [self.contentView addSubview:wait];
    
    wait2 = [UILabel new];
    [self.contentView addSubview:wait2];
}

- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    [self reloadView];
}
- (void)setUsername:(NSString *)username{
    
    _username = username;
}
- (void)reloadView{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_model[@"imgurl"]]]]) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_model[@"imgurl"]]];
        
        [iconImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    else{
        
        iconImage.image = [UIImage imageNamed:@"相机照.png"];
    }
    
    nameLabel.text = [NSString stringWithFormat:@"%@%@的%@",_sex,_username,_model[@"cartype"]];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    nameLabel.textColor = Color(75, 75, 75);
    
    levelLabel.text = [NSString stringWithFormat:@"%@.0",[_model[@"pj"] stringValue]];
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.adjustsFontSizeToFitWidth = YES;
    levelLabel.font = [UIFont systemFontOfSize:12];
    
    wait.text = [NSString stringWithFormat:@"%@步 · 即可发布",_model[@"num"]];
    wait.textAlignment = NSTextAlignmentLeft;
    wait.adjustsFontSizeToFitWidth = YES;
    wait.textColor = Color(100, 100, 100);
    wait.font = [UIFont systemFontOfSize:15];
    
    wait2.text = @"审核中·审核完成自动发布";
    wait2.adjustsFontSizeToFitWidth = YES;
    wait2.textColor = Color(195, 195, 195);
    wait2.textAlignment = NSTextAlignmentLeft;
    wait2.font = [UIFont systemFontOfSize:15];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    
    iconImage.frame = CGRectMake(0, 0, width*0.2125*3/2, self.contentView.frame.size.height);
//    iconImage.backgroundColor = [UIColor redColor];
    
    nameLabel.frame = CGRectMake(CGRectGetMaxX(iconImage.frame)+width*0.04, width*0.02, width*0.55, width*0.08);
//    nameLabel.backgroundColor = [UIColor redColor];
    
    if ([_model[@"status"] intValue] == 1||[_model[@"status"] isEqualToString:@""]) {
        
        wait.frame = CGRectMake(CGRectGetMaxX(iconImage.frame)+width*0.04, CGRectGetMaxY(nameLabel.frame)+width*0.02, width*0.55, width*0.08);
        
    }else if ([_model[@"status"] intValue] == 2) {
        
        wait2.frame = CGRectMake(CGRectGetMaxX(iconImage.frame)+width*0.04, CGRectGetMaxY(nameLabel.frame)+width*0.02, width*0.55, width*0.08);
    }else{
        
        for (int i = 0; i < 5; i++) {
            
            imageXing  = [UIImageView new];
            
            imageXing.image = [UIImage imageNamed:@"五角星.png"];
            
            imageXing.frame = CGRectMake(CGRectGetMaxX(iconImage.frame)+width*0.04+i*width*0.03, CGRectGetMaxY(nameLabel.frame)+width*0.02, width*0.03, width*0.03);
            
            [self.contentView addSubview:imageXing];
        }
        levelLabel.frame = CGRectMake(width*0.55, CGRectGetMaxY(nameLabel.frame)+width*0.01, width*0.2, width*0.06);
    }
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
