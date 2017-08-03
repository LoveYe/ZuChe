//
//  ShoucangViewCell.m
//  ZuChe
//
//  Created by apple  on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ShoucangViewCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@implementation ShoucangViewCell{
    
    UIImageView *cartu;
    UILabel *hei;
    UILabel *jiage;
    UILabel *da;
    UILabel *xiao;
    UILabel *type;
    UIButton *iconImage;
    UIImageView *star;
    UILabel *name;
    UILabel *pingjia;
    UIButton *shoucang;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cartu111 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width*2/3)];
        [self.contentView addSubview:self.cartu111];
        [self reloadView];
    }
    return self;
}
- (void)reloadView{
    
//    cartu = [UIImageView new];
//    [self.contentView addSubview:cartu];
    hei = [UILabel new];;
    [self.contentView addSubview:hei];
    
    jiage = [UILabel new];
    [self.contentView addSubview:jiage];
    
    da = [UILabel new];;
    [self.contentView addSubview:da];
    
    xiao = [UILabel new];
    [self.contentView addSubview:xiao];
    
    type = [UILabel new];
    [self.contentView addSubview:type];
    iconImage = [UIButton new];
    [self.contentView addSubview:iconImage];
    star = [UIImageView new];
    [self.contentView addSubview:star];
    name = [UILabel new];;
    [self.contentView addSubview:name];
    pingjia = [UILabel new];
    [self.contentView addSubview:pingjia];
    shoucang = [[UIButton alloc] init];
    [self.contentView addSubview:shoucang];
}
- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    [self customView];
}
- (void)customView{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"usericon"]]];
        
        NSData *data = [NSData dataWithContentsOfURL:iconURL];
        
        NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:data];
            
            if ([s isEqualToString:@""]) {
                
                [iconImage setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
            }else{
                
                [iconImage setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }
            
        });
    });
    
    [shoucang setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
    [shoucang addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
    
    hei.backgroundColor = [UIColor blackColor];
    hei.alpha = 0.8;
    
    if ([_model[@"cartype"] isEqualToString:@"3"]) {
        
        da.text = @"天";
        da.textColor = [UIColor whiteColor];
        da.textAlignment = NSTextAlignmentCenter;
        da.font = [UIFont boldSystemFontOfSize:20];
        da.adjustsFontSizeToFitWidth = YES;
    }else if ([_model[@"cartype"] isEqualToString:@"4"] || [_model[@"cartype"] isEqualToString:@"5"]){
        
        da.text = @"月";
        da.textColor = [UIColor whiteColor];
        da.textAlignment = NSTextAlignmentCenter;
        da.font = [UIFont boldSystemFontOfSize:20];
        da.adjustsFontSizeToFitWidth = YES;
    }
    
    jiage.text = [NSString stringWithFormat:@"¥%@",_model[@"jiage"]];
    jiage.textColor = [UIColor whiteColor];
    jiage.textAlignment = NSTextAlignmentLeft;
    jiage.font = [UIFont boldSystemFontOfSize:20];
    jiage.adjustsFontSizeToFitWidth = YES;
    
    name.text = [NSString stringWithFormat:@"%@ From %@师傅",_model[@"typemodeles"],_model[@"name"]];
    name.textColor = Color(77, 77, 77);
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont systemFontOfSize:19];
    name.adjustsFontSizeToFitWidth = YES;
    
    star.image = [UIImage imageNamed:@"五角星.png"];
    
    pingjia.text = [NSString stringWithFormat:@"%@ · %@条评价",_model[@"plate"],_model[@"pj_num"]];
    pingjia.textColor = Color(187, 187, 187);
    pingjia.textAlignment = NSTextAlignmentLeft;
    pingjia.font = [UIFont systemFontOfSize:17];
    pingjia.adjustsFontSizeToFitWidth = YES;
}
- (void)layoutSubviews{
    
    CGFloat width = self.contentView.frame.size.width;
//    cartu.frame = CGRectMake(0, 0, width, width*2/3);
    
    shoucang.frame = CGRectMake(width * 0.87, width*0.05, width*0.08, width*0.08);
    
    hei.frame = CGRectMake(0, width * 2/3- width*0.15, width*0.3, width*0.1);
    
    jiage.frame = CGRectMake(width*0.01, width * 2/3- width*0.15, width*0.2, width*0.1);
    
    da.frame = CGRectMake(width*0.2, width * 2/3- width*0.15, width*0.1, width*0.1);
    
    iconImage.frame = CGRectMake(width*0.75, width*2/3-width*0.075, width*0.15, width*0.15);
    
    name.frame = CGRectMake(width*0.05, CGRectGetMaxY(_cartu111.frame)+width*0.02, width*0.6, width*0.08);
    
    star.frame = CGRectMake(width*0.05, CGRectGetMaxY(name.frame)+width*0.01, width*0.04, width*0.04);
    
    pingjia.frame = CGRectMake(width*0.26, CGRectGetMaxY(name.frame)+width*0.01, width*0.35, width*0.08);
}
- (void)shoucangClick{
    
//    [shoucang setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
    if (_delDelegate && [_delDelegate respondsToSelector:@selector(deleteCollection: type:)]) {
        
        [_delDelegate deleteCollection:_model[@"carid"] type:_model[@"cartype"]];
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
