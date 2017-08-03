//
//  PjDemoTableViewCell.m
//  PingJiaDemo
//
//  Created by MacBookXcZl on 2017/5/10.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "PjDemoTableViewCell.h"
//#import "SDWebImage/UIImageView+WebCache.h"
#import "Header.h"

@implementation PjDemoTableViewCell{
    
    UIImageView *_iconImage;
    UILabel *_nameLabel;
   // UILabel *_starLabel;
    
   
//    UIImageView *_carsImageView2;
//    UIImageView *_carsImageView3;
//    UIImageView *_carsImageView4;
    
    
    UIImageView *_starImg;
    UIImageView *_starImg2;
    UIImageView *_starImg3;
    UIImageView *_starImg4;
    UIImageView *_starImg5;
    
    UILabel *_textLabel;
    
    NSMutableArray *_array;
    
    WSStarRatingView *_wsStraRating;
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creat];
        _array = [NSMutableArray array];
    }
      return self;
}
-(void)creat{
    
    _textLabel = [UILabel new];
    [self.contentView addSubview:_textLabel];
    
    _iconImage = [UIImageView new];
    [self.contentView addSubview:_iconImage];
    
    _nameLabel = [UILabel new];
    [self.contentView addSubview:_nameLabel];
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10, 50, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating];
    
    _scoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_scoreLabel];
    
    _carsImageView = [UIImageView new];
    [self.contentView addSubview:_carsImageView];
    
    _carsImageView2 = [UIImageView new];
    [self.contentView addSubview:_carsImageView2];
    
    _carsImageView3 = [UIImageView new];
    [self.contentView addSubview:_carsImageView3];
    
    _carsImageView4 = [UIImageView new];
    [self.contentView addSubview:_carsImageView4];
    
    _carsImageView.userInteractionEnabled = YES;
    _carsImageView2.userInteractionEnabled = YES;
    _carsImageView3.userInteractionEnabled = YES;
    _carsImageView4.userInteractionEnabled = YES;
}
- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    
    [self creatCell];
}
-(void)creatCell {
    
    _textLabel.text = _model[@"pj_content"];
    _textLabel.textColor = Color(107, 107, 107);
    _textLabel.numberOfLines = 0;
    _textLabel.font = [UIFont systemFontOfSize:15];
    [_textLabel sizeToFit];
 
 //   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *iconImg = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"user_icon"]]];
        if ([[UIApplication sharedApplication] canOpenURL:iconImg]) {
            
            [_iconImage sd_setImageWithURL:iconImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }else{
            
            _iconImage.image = [UIImage imageNamed:@"头像.png"];
        }
          __block PjDemoTableViewCell *pjCell = self;
        _array = _model[@"pj_img"];
    
        for (int i = 0; i < _array.count; i++) {
            
            if (_array.count == 1) {
                
                NSURL *carImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][0]]];
                if ([[UIApplication sharedApplication] canOpenURL:carImage]) {
                    
                    [_carsImageView sd_setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    
                    [_carsImageView setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {

                        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage)];
                        [pjCell.carsImageView addGestureRecognizer:tap];
                        NSLog(@"加载完成了");
                        }];
                    
                }else{
                    
                    _carsImageView.image = [UIImage imageNamed:@"婚车1.png"];
                }
            }if (_array.count == 2) {
                
                NSURL *carImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][0]]];
                NSURL *carImage2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][1]]];
                if ([[UIApplication sharedApplication] canOpenURL:carImage]) {
                    
                    [_carsImageView sd_setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage)];
                        [pjCell.carsImageView addGestureRecognizer:tap];
                        NSLog(@"加载完成了");
                        
                    }];
                    
                }else{
                    
                    _carsImageView.image = [UIImage imageNamed:@"婚车1.png"];
                }
                if ([[UIApplication sharedApplication] canOpenURL:carImage2]) {
                    
                    [_carsImageView2 sd_setImageWithURL:carImage2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView2 setImageWithURL:carImage2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage2)];
                        [pjCell.carsImageView2 addGestureRecognizer:tap2];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView2.image = [UIImage imageNamed:@"婚车1.png"];
                }
            }if (_array.count == 3) {
                NSURL *carImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][0]]];
                NSURL *carImage2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][1]]];
                NSURL *carImage3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][2]]];
                if ([[UIApplication sharedApplication] canOpenURL:carImage]) {
                    
                    [_carsImageView sd_setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage)];
                        [pjCell.carsImageView addGestureRecognizer:tap];
                        NSLog(@"加载完成了");
                        
                    }];
                    
                }else{
                    
                    _carsImageView.image = [UIImage imageNamed:@"婚车1.png"];
                }
                if ([[UIApplication sharedApplication] canOpenURL:carImage2]) {
                    
                    [_carsImageView2 sd_setImageWithURL:carImage2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView2 setImageWithURL:carImage2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage2)];
                        [pjCell.carsImageView2 addGestureRecognizer:tap2];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView2.image = [UIImage imageNamed:@"婚车1.png"];
                }
                if ([[UIApplication sharedApplication] canOpenURL:carImage3]) {
                    
                    [_carsImageView3 sd_setImageWithURL:carImage3 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView3 setImageWithURL:carImage3 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap3  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage3)];
                        [pjCell.carsImageView3 addGestureRecognizer:tap3];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView3.image = [UIImage imageNamed:@"婚车1.png"];
                }
            }if (_array.count == 4) {
                NSURL *carImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][0]]];
                NSURL *carImage2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][1]]];
                NSURL *carImage3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][2]]];
                NSURL *carImage4 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"pj_img"][3]]];
                
                if ([[UIApplication sharedApplication] canOpenURL:carImage]) {
                    
                    [_carsImageView sd_setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView setImageWithURL:carImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage)];
                        [pjCell.carsImageView addGestureRecognizer:tap];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView.image = [UIImage imageNamed:@"婚车1.png"];
                }
                if ([[UIApplication sharedApplication] canOpenURL:carImage2]) {
                    
                    [_carsImageView2 sd_setImageWithURL:carImage2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView2 setImageWithURL:carImage2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage2)];
                        [pjCell.carsImageView2 addGestureRecognizer:tap2];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView2.image = [UIImage imageNamed:@"婚车1.png"];
                }
                if ([[UIApplication sharedApplication] canOpenURL:carImage3]) {
                    
                    [_carsImageView3 sd_setImageWithURL:carImage3 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView3 setImageWithURL:carImage3 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap3  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage3)];
                        [pjCell.carsImageView3 addGestureRecognizer:tap3];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView3.image = [UIImage imageNamed:@"婚车1.png"];
                }
                if ([[UIApplication sharedApplication] canOpenURL:carImage4]) {
                    
                    [_carsImageView4 sd_setImageWithURL:carImage4 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    [_carsImageView4 setImageWithURL:carImage4 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        UITapGestureRecognizer *tap4  = [[UITapGestureRecognizer alloc] initWithTarget:pjCell action:@selector(magnifyImage4)];
                        [pjCell.carsImageView4 addGestureRecognizer:tap4];
                        NSLog(@"加载完成了");
                        
                    }];
                }else{
                    
                    _carsImageView4.image = [UIImage imageNamed:@"婚车1.png"];
                }
            }

        }
 //   });
    
    _nameLabel.text = _model[@"nickname"];
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    _nameLabel.textColor = Color(87, 87, 87);
    _nameLabel.font = [UIFont systemFontOfSize:17];
    
//
    
  
//    
//     UITapGestureRecognizer *tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage2)];
//    
//    [_carsImageView2 addGestureRecognizer:tap1];
//    
//     UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage3)];
//    [_carsImageView3 addGestureRecognizer:tap2];
//    
//     UITapGestureRecognizer *tap3  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage4)];
//    [_carsImageView4 addGestureRecognizer:tap3];

    _scoreLabel.textAlignment = NSTextAlignmentLeft;
    _scoreLabel.font = [UIFont systemFontOfSize:10];
    _scoreLabel.textColor = Color(107, 107, 107);
    _scoreLabel.adjustsFontSizeToFitWidth = YES;
    
    float a = [_model[@"pj_xing"] doubleValue];
    
    _wsStraRating.delegate = self;
    
    __block PjDemoTableViewCell *detaCell = self;
    
    [_wsStraRating setScore:a/5 withAnimation:YES completion:^(BOOL finished) {
        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",a/5 * 5 ];
    }];
//    _carsImageView.image = [[UIImage imageNamed:@"V7.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    
    _iconImage.frame = CGRectMake(width*0.05, width*0.05, width*0.15, width*0.15);
    _iconImage.layer.cornerRadius = width*0.5*0.15;
    _iconImage.layer.masksToBounds = YES;
    //_iconImage.backgroundColor = [UIColor redColor];
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_iconImage.frame), CGRectGetMidY(_iconImage.frame), width*0.35, width*0.08);
   // _starLabel.frame = CGRectMake(width*0.9, CGRectGetMidY(_iconImage.frame), width*0.06, width*0.08);
    
    _textLabel.frame = CGRectMake(width*0.05, CGRectGetMaxY(_iconImage.frame)+width*0.05, width*0.9, [self heightForRow]);
    
    if (_array.count == 4) {
        _carsImageView.frame = CGRectMake(width*0.05, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView2.frame = CGRectMake(width*0.25+width*0.1/3, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView3.frame = CGRectMake(width*0.45+width*0.1/3*2, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView4.frame = CGRectMake(width*0.75, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
    }else if (_array.count == 3){
        _carsImageView.frame = CGRectMake(width*0.05, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView2.frame = CGRectMake(width*0.25+width*0.1/3, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView3.frame = CGRectMake(width*0.45+width*0.1/3*2, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView4.frame = CGRectMake(0, 0, 0, 0);
    }else if(_array.count == 2){
        _carsImageView.frame = CGRectMake(width*0.05, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView2.frame = CGRectMake(width*0.25+width*0.1/3, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView3.frame = CGRectMake(0, 0, 0, 0);
        _carsImageView4.frame = CGRectMake(0, 0, 0, 0);
    }else if(_array.count == 1) {
        

                self.carsImageView .frame = CGRectMake(width*0.05, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
                self.carsImageView2.frame = CGRectMake(0, 0, 0, 0);
                self.carsImageView3.frame = CGRectMake(0, 0, 0, 0);
                self.carsImageView4.frame = CGRectMake(0, 0, 0, 0);
        }else if (_array.count == 0){
       
            _carsImageView.frame = CGRectMake(0, 0, 0, 0);
            _carsImageView2.frame = CGRectMake(0, 0, 0, 0);
            _carsImageView3.frame = CGRectMake(0, 0, 0, 0);
            _carsImageView4.frame = CGRectMake(0, 0, 0, 0);
    }
    

    
    
    _wsStraRating.frame = CGRectMake(self.contentView.frame.size.width*0.95 - 0.085*ScreenHeight-10 , 50, 0.085*ScreenHeight, 0.02*ScreenHeight);

    _scoreLabel.frame = CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+5, 50, ScreenWidth*0.05, 0.02*ScreenHeight);


}
-(void)magnifyImage{
        [self showImage:_carsImageView];
        NSLog(@"fangda");
}
-(void)magnifyImage2{
    
    [self showImage:_carsImageView2];
    NSLog(@"fangda");
}
-(void)magnifyImage3{
    
    [self showImage:_carsImageView3];
    NSLog(@"fangda");
}

-(void)magnifyImage4{
    
    [self showImage:_carsImageView4];
    NSLog(@"fangda");
}

//然后根据具体的业务场景去写逻辑就可以了,比如
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    if ([NSStringFromClass([touch.view class])  isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return YES;
    }
    
    return NO;
}

static CGRect oldframe;


- (void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    

    if ( image.size.width!=0) {
        [UIView animateWithDuration:0.2 animations:^{
            
            imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) / 2, [UIScreen mainScreen].bounds.size.width, image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width);
            backgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
   
}

- (void)hideImage:(UITapGestureRecognizer *)tap{
    
    UIView *backgroundView = tap.view;
    UIImageView *imageView=(UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.2 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}


- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock{
    
}


-(CGFloat)heightForRow{
    

    CGFloat height =   [_textLabel.text boundingRectWithSize:CGSizeMake(ScreenWidth*0.81, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.height;
    
    return height;
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
