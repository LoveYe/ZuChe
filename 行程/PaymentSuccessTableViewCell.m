//
//  PaymentSuccessTableViewCell.m
//  ZuChe
//
//  Created by 佐途 on 15/11/2.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "PaymentSuccessTableViewCell.h"
#import "Header.h"
#import "UILabel+SizeLabel.h"

@implementation PaymentSuccessTableViewCell
{
    float myWidth;
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
    
    float  zuo = ScreenWidth*0.031;
    float  hangGao =ScreenWidth *0.32;
    
    if (self)
    {
        self.photo =[[UIImageView alloc]initWithFrame:CGRectMake(zuo, hangGao/2-ScreenWidth*0.28/2, ScreenWidth*0.42, ScreenWidth*0.28)];
        self.photo.backgroundColor =[UIColor yellowColor];
        self.photo.image=[UIImage imageNamed:@"玛莎拉蒂.jpg"];
        [self addSubview:self.photo];
        
        
        self.title =[[UILabel alloc]initWithFrame: CGRectMake(zuo*2+ScreenWidth*0.42, ScreenWidth*0.02, ScreenWidth*0.49, ScreenWidth*0.05)];
        //                self.title.backgroundColor =[UIColor redColor];
        [self labelFont:self.title font:13.0f];
        self.title .text = @"玛莎拉蒂GC";
        [self addSubview:self.title];
        //
        
        float   nowWidth=zuo*2+ScreenWidth*0.42;
        
        self.chepai =[[UILabel alloc]initWithFrame: CGRectMake(nowWidth, ScreenWidth*0.085, ScreenWidth*0.06, ScreenWidth*0.038)];
        self.chepai.backgroundColor =Color(0, 170, 238);
        self.chepai.textColor =[UIColor whiteColor];
        [self labelFont:self.chepai boldfont:10.0f];
        self.chepai.text =@"AO";
        self.chepai.textAlignment =NSTextAlignmentCenter;
        [self addSubview:self.chepai];
        
        
        
        self.jiage  =[[UILabel alloc]initWithFrame:CGRectMake(nowWidth, ScreenWidth*0.138, ScreenWidth*0.1, ScreenWidth*0.05)];
        //        self.jiage.backgroundColor =[UIColor yellowColor];
        self.jiage.text =@"¥ 1110";
        [self labelFont:self.jiage font:16.0f];
        self.jiage.textColor =[UIColor redColor];
        myWidth =[UILabel width:self.jiage.text heightOfFatherView:self.jiage.frame.size.height textFont:self.jiage.font];
        [self addSubview:self.jiage];
        self.jiage.frame =CGRectMake(nowWidth, ScreenWidth*0.138, myWidth, ScreenWidth*0.05);
        
        
        self.lucheng =[[UILabel alloc]initWithFrame:CGRectMake(nowWidth+myWidth+1, ScreenWidth*0.143, ScreenWidth*0.34, ScreenWidth*0.04)];
        //        self.lucheng.backgroundColor =[UIColor grayColor];
        self.lucheng.text =@"/5小时/50公里";
        self.lucheng.textColor =[UIColor redColor];
        [self labelFont:self.lucheng font:12.0f];
        [self addSubview:self.lucheng];
        
        
        self.jiedanlv =[[UILabel  alloc]initWithFrame:CGRectMake(nowWidth, ScreenWidth*0.138+ScreenWidth*0.07, ScreenWidth*0.12, ScreenWidth*0.04)];
        self.jiedanlv.text =@"99.9%";
        [self labelFont:self.jiedanlv font:12.0f];
        self.jiedanlv.textAlignment =NSTextAlignmentCenter;
        
        //        self.jiedanlv.backgroundColor =[UIColor yellowColor];
        [self addSubview:self.jiedanlv];
        
        
        
        
        self.fuwu =[[UILabel  alloc]initWithFrame:CGRectMake(nowWidth+ScreenWidth*0.15, ScreenWidth*0.138+ScreenWidth*0.07, ScreenWidth*0.12, ScreenWidth*0.04)];
        self.fuwu.text =@"1188";
        [self labelFont:self.fuwu font:12.0f];
        self.fuwu.textAlignment =NSTextAlignmentCenter;
        //        self.fuwu.backgroundColor =[UIColor yellowColor];
        [self addSubview:self.fuwu];
        
        
        self.time =[[UILabel  alloc]initWithFrame:CGRectMake(nowWidth+ScreenWidth*0.17+ScreenWidth*0.12, ScreenWidth*0.138+ScreenWidth*0.07, ScreenWidth*0.16, ScreenWidth*0.04)];
        self.time.text =[NSString stringWithFormat:@"120分钟"];
        [self labelFont:self.time font:12.0f];
        self.time.textAlignment =NSTextAlignmentCenter;
        
        //        self.time.backgroundColor =[UIColor yellowColor];
        [self addSubview:self.time];
        
        
        
        
        self.jiedanlvss =[[UILabel  alloc]initWithFrame:CGRectMake(nowWidth, ScreenWidth*0.138+ScreenWidth*0.07+ScreenWidth*0.045, ScreenWidth*0.12, ScreenWidth*0.04)];
        self.jiedanlvss.text =@"接单率";
        [self labelFont:self.jiedanlvss font:11.0f];
        self.jiedanlvss.textAlignment =NSTextAlignmentCenter;
        
        self.jiedanlvss.textColor =[UIColor grayColor];
        [self addSubview:self.jiedanlvss];
        
        self.fuwuss =[[UILabel  alloc]initWithFrame:CGRectMake(nowWidth+ScreenWidth*0.15, ScreenWidth*0.138+ScreenWidth*0.07+ScreenWidth*0.045, ScreenWidth*0.12, ScreenWidth*0.04)];
        self.fuwuss.text =@"接单率";
        [self labelFont:self.fuwuss font:11.0f];
        self.fuwuss.textAlignment =NSTextAlignmentCenter;
        self.fuwuss.textColor =[UIColor grayColor];
        [self addSubview:self.fuwuss];
        
        self.timess =[[UILabel  alloc]initWithFrame:CGRectMake(nowWidth+ScreenWidth*0.17+ScreenWidth*0.12, ScreenWidth*0.138+ScreenWidth*0.07+ScreenWidth*0.045, ScreenWidth*0.14, ScreenWidth*0.04)];
        self.timess.text =[NSString stringWithFormat:@"平均提前"];
        [self labelFont:self.timess font:11.0f];
        self.timess.textAlignment =NSTextAlignmentCenter;
        self.timess.textColor =[UIColor grayColor];
        [self addSubview:self.timess];
        
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.32-1, ScreenWidth, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        [self addSubview:xian];
        
        
    }
    
    
    
    
    
    return  self;
}

-(void)labelFont :(UILabel *)label font:(float)labelfont
{
    label.font =[UIFont fontWithName:@"STHeitiSC-Light" size:labelfont/320*ScreenWidth];
}
-(void)labelFont :(UILabel *)label boldfont:(float)labelfont
{
    label.font =[UIFont fontWithName:@"Helvetica" size:labelfont/320*ScreenWidth];
}

@end
