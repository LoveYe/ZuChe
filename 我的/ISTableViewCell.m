//
//  ISTableViewCell.m
//  ZuChe
//
//  Created by 佐途 on 15/11/10.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "ISTableViewCell.h"
#import "Header.h"

@implementation ISTableViewCell

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
    
    if (self)
    {
        self.title =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth *0.04, ScreenWidth*0.04, ScreenWidth*0.6, ScreenWidth*0.05)];
        //        self.title.backgroundColor =[UIColor yellowColor];
        [self addSubview:self.title];
        
        self.yue=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*(0.2-0.05-0.035), ScreenWidth*0.5, ScreenWidth*0.05)];
        //        self.yue.backgroundColor =[UIColor redColor];
        [self addSubview:self.yue];
        
        
        self.price =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.04-ScreenWidth*0.4, ScreenWidth*0.04, ScreenWidth*0.4, ScreenWidth*0.05)];
        self.price.textAlignment =NSTextAlignmentRight;
        [self addSubview: self.price];
        
        self.time =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.04-ScreenWidth*0.5, ScreenWidth*(0.2-0.05-0.035), ScreenWidth*0.5, ScreenWidth*0.05)];
        self.time.textAlignment =NSTextAlignmentRight;
        self.time.textColor =Color(100, 100, 100);
        [self addSubview: self.time];
        
        
    }
    return  self;
    
}
@end
