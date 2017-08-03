//
//  ItineraryTableViewCell.m
//  ZuChe
//
//  Created by 佐途 on 15/10/30.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "ItineraryTableViewCell.h"
#import "Header.h"
#import "UILabel+SizeLabel.h"
@implementation ItineraryTableViewCell
{
    float  myWidth;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    float  old =ScreenWidth *0.26;
    
    if (self)
    {
        self.photo =[UIButton buttonWithType:UIButtonTypeSystem];
        self.photo.frame =CGRectMake(ScreenWidth*0.0769, old/2-ScreenWidth*0.21/(2*1.3), ScreenWidth*0.32/1.3, ScreenWidth*0.21/1.3);
        [self.photo setBackgroundImage:[UIImage imageNamed:@"奔驰.jpg"] forState:UIControlStateNormal];
        [self addSubview:self.photo];
        
        
        self.name =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth*0.382, ScreenWidth*0.04, ScreenWidth*0.3, ScreenWidth*0.06)];
        //        self.name.backgroundColor =[UIColor redColor];
        self.name.font=[UIFont boldSystemFontOfSize:0.0406*ScreenWidth];
        self.name.alpha=0.7;
        self.name .text = @"奔驰 G260L";
        myWidth =[UILabel width:self.name.text heightOfFatherView:self.name.frame.size.height textFont:self.name.font];
        self.name.frame= CGRectMake(ScreenWidth*0.382, ScreenWidth*0.04, myWidth+2, ScreenWidth*0.06);
        [self addSubview:self.name];
        
        self.date =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth*0.382, ScreenWidth*0.115, ScreenWidth*0.3, ScreenWidth*0.04)];
        //        self.date.backgroundColor =[UIColor blueColor];
        self.date.text =@"10.22 12:00";
        [self labelFont:self.date font:12.0f];
        self.date.textColor =[UIColor grayColor];
        [self addSubview:self.date];
        
        
//        _imageView3 =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.382, ScreenWidth*0.175, ScreenWidth*0.04, ScreenWidth*0.04)];
//        _imageView3.image =[UIImage imageNamed:@"地址.png"];
//        [self addSubview:_imageView3];
        
        
        
        self.address =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth*0.382, ScreenWidth*0.17, ScreenWidth*0.6, ScreenWidth*0.05)];
//      self.address.backgroundColor =[UIColor greenColor];
        self.address.text =@"上海市曹杨路联合大厦";
        [self labelFont:self.address font:12.0f];
        self.address.textColor =[UIColor grayColor];
        [self addSubview:self.address];
        
        self.price =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth-ScreenWidth*0.19-ScreenWidth*0.031, ScreenWidth*0.11, ScreenWidth*0.19, ScreenWidth*0.06)];
//        self.price.backgroundColor =Color(246, 99, 107)//红;
        self.price.textColor=Color(246, 99, 107)//红;
        self.price.text =@"¥250";
        self.price.textAlignment =NSTextAlignmentRight;
        [self labelFont:self.price boldfont:13.0f];
        [self addSubview:self.price];
        
        
        self.chepai =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth*0.382+myWidth+ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth*0.06, ScreenWidth*0.05)];
        self.chepai.backgroundColor =Color(0, 170, 238);
        self.chepai.textColor =[UIColor whiteColor];
        [self labelFont:self.chepai boldfont:11.0f];
        self.chepai.text =@"AO";
        self.chepai.textAlignment =NSTextAlignmentCenter;
        [self addSubview:self.chepai];
        
    }
    
    
    
    
    
    return  self;
}
-(void)labelFont :(UILabel *)label font:(float)labelfont
{
    label.font =[UIFont boldSystemFontOfSize:labelfont/320*ScreenWidth];
    
}
-(void)labelFont :(UILabel *)label boldfont:(float)labelfont
{
    label.font =[UIFont systemFontOfSize:labelfont/320*ScreenWidth];
}
@end
