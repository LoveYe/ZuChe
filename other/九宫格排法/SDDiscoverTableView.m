//
//  SDDiscoverTableViewHeaderItemButton.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 GSD. All rights reserved.
//
#import "SDWebImageDownloader.h"

#define Color(a,b,c)  [UIColor colorWithRed:a/255.0 green:b/255.0  blue:c/255.0  alpha:1.0];
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define Font(F) [UIFont systemFontOfSize:(F)/320.0*ScreenWidth]
#define Height(H) (H)/320.0*ScreenWidth
#import "SDDiscoverTableView.h"
#import "UIButton+WebCache.h"
@implementation SDDiscoverTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIColor *coloo=Color(62, 62, 62);
        [self setTitleColor:coloo forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = Font(11);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = (contentRect.size.width-(contentRect.size.width - contentRect.size.width * 0.15 *2.5))/2;
    CGFloat y = contentRect.size.height * 0.04;
    CGFloat w = contentRect.size.width - contentRect.size.width * 0.15 *2.5;
    CGFloat h = contentRect.size.height * 0.7;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0,contentRect.size.height-Height(40), contentRect.size.width, contentRect.size.height * 0.3);
    return rect;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
        
        UIImage *image=[UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                [self setImage:image forState:UIControlStateNormal];
            }
        });
    });
    UIImageView *imagee=[[UIImageView alloc]init];
    imagee.contentMode=UIViewContentModeScaleToFill;
    UIImage *back=[UIImage imageNamed:@"Home_btn_back_image"];
    imagee.image=back;
    [self setBackgroundImage:imagee.image forState:UIControlStateHighlighted];
//    [self setImage:image forState:UIControlStateNormal];
//    [self sd_setImageWithURL:[NSURL URLWithString:imageName] forState:UIControlStateNormal];
//    [self sd_setImageWithURL:[NSURL URLWithString:imageName]  forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
    NSLog(@"11111");
    
}

-(void)setCatid:(NSString *)catid
{
    _catid=catid;
}


@end
