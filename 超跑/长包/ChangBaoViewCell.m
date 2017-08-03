//
//  ChangBaoViewCell.m
//  ZuChe
//
//  Created by apple  on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "ChangBaoViewCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "ZCUserData.h"
#import "HttpManager.h"

@implementation ChangBaoViewCell{
    
    UIButton *usericon111;
    UILabel *jiage111;
    UILabel *cartype111;
    UILabel *pingjia111;
    UILabel *dizhi111;
    
    UIImageView *xing;
    UIImageView *xing1;
    UIImageView *xing2;
    UIImageView *xing3;
    UIImageView *xing4;
    
    UILabel *da;
    UILabel *xiao;
    UIImageView *shandian;
    
    UIImageView *heitu;
    
    UIButton *shoucang;
    
    WSStarRatingView *_wsStraRating;
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
    
    cartype111 = [UILabel new];
    [self.contentView addSubview:cartype111];
    
    pingjia111 = [UILabel new];
    [self.contentView addSubview:pingjia111];
    
    dizhi111 = [UILabel new];
    [self.contentView addSubview:dizhi111];
    
    heitu = [UIImageView new];
    [self.contentView addSubview:heitu];
    
    jiage111 = [UILabel new];
    [heitu addSubview:jiage111];
    
    da = [UILabel new];
    [heitu addSubview:da];
    
    shandian = [UIImageView new];
    [heitu addSubview:shandian];
    
    shoucang = [UIButton new];
    [self.contentView addSubview:shoucang];
    
    usericon111= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:usericon111];
    
    xing2 = [UIImageView new];
    [self.contentView addSubview:xing];
    
    xing3 = [UIImageView new];
    [self.contentView addSubview:xing];
    
    xing4 = [UIImageView new];
    [self.contentView addSubview:xing];
    
    xing1 = [UIImageView new];
    [self.contentView addSubview:xing];
    
    for (int i = 0; i < 5; i++) {
        
        xing = [UIImageView new];
        xing.tag = 1000+i;
        [self.contentView addSubview:xing];
    }
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10, -5000, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating];
}

- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    [self customView];
}
- (void)customView{
    
    heitu.backgroundColor = [UIColor blackColor];
    heitu.alpha = 0.8;
    
    jiage111.text = [NSString stringWithFormat:@"¥%@",_model[@"jiage1"]];
    
    cartype111.text = [NSString stringWithFormat:@"%@ From %@",_model[@"cartype"],_model[@"usernickname"]];
    
    dizhi111.text = [NSString stringWithFormat:@"%@ · %@条评价",_model[@"plate"],_model[@"pj"]];
    
    da.text = @"月";
    
    
    shandian.image = [UIImage imageNamed:@"闪电.png"];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"usericon"]]];
        
        NSData *data = [NSData dataWithContentsOfURL:iconURL];
        
        NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:data];
            
            if ([s isEqualToString:@""]) {
                
                [usericon111 setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
            }else{
                
                [usericon111 setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }
            
        });
    });
//    [usericon111 addTarget:self action:@selector(chezhuMain) forControlEvents:UIControlEventTouchUpInside];
    xing.image = [UIImage imageNamed:@"五角星.png"];
    
    _wsStraRating.delegate = self;
    
    float a = [_model[@"pj"] doubleValue];
    
    if (a == 0) {
        
        a = 5;
    }
    //    __block PjDemoTableViewCell *detaCell = self;
    
    [_wsStraRating setScore:a/5 withAnimation:YES completion:^(BOOL finished) {
        //        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",a/5 * 5 ];
    }];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    
    heitu.frame = CGRectMake(0, width*0.54, width*0.4, width*0.1);
    
    jiage111.frame = CGRectMake(0, 0, width*0.25, width*0.1);
    //    jiage111.textColor = Color(255, 97, 57);
    jiage111.textColor = [UIColor whiteColor];
    jiage111.textAlignment = NSTextAlignmentLeft;
    jiage111.adjustsFontSizeToFitWidth = YES;
    jiage111.font = [UIFont systemFontOfSize:24];
    
    cartype111.frame = CGRectMake(width*0.05, width*2/3+width*0.03, width, width*0.06);
    cartype111.textColor = Color(77, 77, 77);
    cartype111.textAlignment = NSTextAlignmentLeft;
    cartype111.adjustsFontSizeToFitWidth = YES;
    cartype111.font = [UIFont systemFontOfSize:16];
    
    
    usericon111.frame = CGRectMake(width*0.75, width/3*2-width*0.075, width*0.15, width*0.15);
    //    usericon111.layer.borderWidth = 1;
    //    usericon111.layer.borderColor = [[UIColor whiteColor] CGColor];
    usericon111.layer.masksToBounds = YES;
    usericon111.layer.cornerRadius = width*0.075;
    usericon111.alpha = 1;
    
    shoucang.frame = CGRectMake(width*0.88, width*0.05, width*0.08, width*0.08);
    [shoucang addTarget:self action:@selector(shoucangClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([_model[@"shoucang"] isEqualToString:@"0"]) {
        
        [shoucang setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
        shoucang.selected = NO;
    }else{
        
        [shoucang setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
        shoucang.selected = YES;
    }
    
    _wsStraRating.frame = CGRectMake(width*0.05, CGRectGetMaxY(cartype111.frame)+width*0.03, width*0.2, width*0.04);
    
//    UIImageView *buton = (UIImageView *)[self.contentView viewWithTag:1000];
//    buton.frame = CGRectMake(width*0.05, CGRectGetMaxY(cartype111.frame)+width*0.03, width*0.04, width*0.04);
//    buton.image = [UIImage imageNamed:@"五角星.png"];
//    
//    UIImageView *buton1 = (UIImageView *)[self.contentView viewWithTag:1001];
//    buton1.frame = CGRectMake(width*0.05+width*0.04, CGRectGetMaxY(cartype111.frame)+width*0.03, width*0.04, width*0.04);
//    buton1.image = [UIImage imageNamed:@"五角星.png"];
//    
//    UIImageView *buton2 = (UIImageView *)[self.contentView viewWithTag:1002];
//    buton2.frame = CGRectMake(width*0.05+2*width*0.04, CGRectGetMaxY(cartype111.frame)+width*0.03, width*0.04, width*0.04);
//    buton2.image = [UIImage imageNamed:@"五角星.png"];
//    
//    UIImageView *buton3 = (UIImageView *)[self.contentView viewWithTag:1003];
//    buton3.frame = CGRectMake(width*0.05+3*width*0.04, CGRectGetMaxY(cartype111.frame)+width*0.03, width*0.04, width*0.04);
//    buton3.image = [UIImage imageNamed:@"五角星.png"];
//    
//    UIImageView *buton4 = (UIImageView *)[self.contentView viewWithTag:1004];
//    buton4.frame = CGRectMake(width*0.05+4*width*0.04, CGRectGetMaxY(cartype111.frame)+width*0.03, width*0.04, width*0.04);
//    buton4.image = [UIImage imageNamed:@"五角星.png"];
    
    

    dizhi111.frame = CGRectMake(width*0.26, CGRectGetMaxY(cartype111.frame)+width*0.01, width*0.6, width*0.08);
    dizhi111.textAlignment = NSTextAlignmentLeft;
    dizhi111.adjustsFontSizeToFitWidth = YES;
    dizhi111.textColor = Color(157, 157, 157);
    dizhi111.font = [UIFont systemFontOfSize:14];
    
    
    da.frame = CGRectMake(CGRectGetMaxX(jiage111.frame)+width*0.01, width*0.01, width*0.07, width*0.08);
    da.textAlignment = NSTextAlignmentCenter;
    da.adjustsFontSizeToFitWidth = YES;
    da.textColor = [UIColor whiteColor];
    da.font = [UIFont systemFontOfSize:17];
    
    shandian.frame = CGRectMake(width*0.32, width*0.01, width*0.08, width*0.08);
}
- (void)shoucangClick:(UIButton *)sender{
    
    if ([[ZCUserData share].userId isEqualToString:@""] || [ZCUserData share].userId == nil) {
        
        return ;
    }else{
        
        if (shoucang.selected == NO) {
            
            shoucang.selected = YES;
            
            NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":_model[@"carid"],@"model":@"insert",@"cartype":@"4"};
            
            [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
                
//                NSLog(@"tainjia --- %@",fanhuicanshu);
                [shoucang setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
                
                if (_cbDelegate && [_cbDelegate respondsToSelector:@selector(changbaoCollect)]) {
                    
                    [_cbDelegate changbaoCollect];
                }
                
            } Error:^(NSString *cuowuxingxi) {
                
                
            }];
        }else{
            
            shoucang.selected = NO;
            
            NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":_model[@"carid"],@"model":@"delete",@"cartype":@"4"};
            
            [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
                
//                NSLog(@"quxiao --- %@",fanhuicanshu);
                [shoucang setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
                
                if (_cbDelegate && [_cbDelegate respondsToSelector:@selector(changbaoCollect)]) {
                    
                    [_cbDelegate changbaoCollect];
                }
                
            } Error:^(NSString *cuowuxingxi) {
                
            }];
        }
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
