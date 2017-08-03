//
//  PjDemoTableViewCell.m
//  PingJiaDemo
//
//  Created by MacBookXcZl on 2017/5/10.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "DetailPjTableViewCell.h"
//#import "SDWebImage/UIImageView+WebCache.h"
#import "Header.h"

@implementation DetailPjTableViewCell{
    
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
    
    UIView *_xianlabel;
    UILabel *_timeLabel;
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
    
    _xianlabel = [UIView new];
     [self.contentView addSubview:_xianlabel];
    _timeLabel = [UILabel new];
    [self.contentView addSubview:_timeLabel];
    
}
- (void)setModel:(NSDictionary *)model{
    
    _model = model;
    
    [self creatCell];
}
-(void)creatCell {
    
    _textLabel.text = _model[@"content"];
    _textLabel.textColor = Color(107, 107, 107);
    _textLabel.numberOfLines = 0;
    _textLabel.font = [UIFont systemFontOfSize:15];
    [_textLabel sizeToFit];
    
    //   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    
    if ([_model[@"thumb"] isKindOfClass:[NSNull class]]) {
        
    }else {
        
        NSURL *iconImg = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_model[@"thumb"]]];
        if ([[UIApplication sharedApplication] canOpenURL:iconImg]) {
            
            [_iconImage sd_setImageWithURL:iconImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }else{
            
            _iconImage.image = [UIImage imageNamed:@"头像.png"];
        }
    }
    _timeLabel.text = _model[@"inputtime"];
    _timeLabel.textColor = Color(107, 107, 107);
    _timeLabel.numberOfLines = 0;
    _timeLabel.font = [UIFont systemFontOfSize:20];
    
    
    __block DetailPjTableViewCell *pjCell = self;
    
    NSURL *carImage = [NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com/%@",_model[@"pic1"]]];
    NSURL *carImage2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com/%@",_model[@"pic2"]]];
    NSURL *carImage3 = [NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com/%@",_model[@"pic3"]]];
    
    
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

    _nameLabel.text = _model[@"nickname"];
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    _nameLabel.textColor = Color(87, 87, 87);
    _nameLabel.font = [UIFont systemFontOfSize:17];
    
    
    _xianlabel.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    
}

-(void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    
    _iconImage.frame = CGRectMake(width*0.05, width*0.05, width*0.15, width*0.15);
    _iconImage.layer.cornerRadius = width*0.5*0.15;
    _iconImage.layer.masksToBounds = YES;
    //_iconImage.backgroundColor = [UIColor redColor];
    
    _timeLabel.frame = CGRectMake(width*0.23, width*0.15, width*0.5,width*0.05);
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_iconImage.frame), CGRectGetMidY(_iconImage.frame), width*0.35, width*0.08);
    // _starLabel.frame = CGRectMake(width*0.9, CGRectGetMidY(_iconImage.frame), width*0.06, width*0.08);
    
    _textLabel.frame = CGRectMake(width*0.05, CGRectGetMaxY(_iconImage.frame)+width*0.05, width*0.9, [self heightForRow]);

        _carsImageView.frame = CGRectMake(width*0.05, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView2.frame = CGRectMake(width*0.25+width*0.1/3, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView3.frame = CGRectMake(width*0.45+width*0.1/3*2, CGRectGetMaxY(_textLabel.frame)+width*0.05, width*0.2, width*0.2*2/3);
        _carsImageView4.frame = CGRectMake(0, 0, 0, 0);
    
    _xianlabel.frame =  CGRectMake(0,  CGRectGetMaxY(_carsImageView.frame)-1.3+width*0.05, ScreenWidth, 1.3);
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
    
    
    CGFloat height =   [_textLabel.text boundingRectWithSize:CGSizeMake(ScreenWidth*0.9, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.height;
    
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
