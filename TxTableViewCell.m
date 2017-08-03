//
//  DchuliTableViewCell.m
//  XiancheHead
//
//  Created by MacBookXcZl on 2017/5/12.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#import "TxTableViewCell.h"

@implementation TxTableViewCell {
    
    UILabel *_starNumberLabel;
    
    UILabel *_yearLabel;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatViews];
    }
    return self;
}
-(void)creatViews {
    
    _starNumberLabel = [UILabel new];
    [self.contentView addSubview:_starNumberLabel];
    
    _yearLabel = [UILabel new];
    [self.contentView addSubview:_yearLabel];
}
-(void)setDict:(NSDictionary *)dict {
    
    _dict = dict;
    
    [self recell];
    
}
-(void)recell {
    
    _starNumberLabel.text = @"8日, 周一";
    _starNumberLabel.textAlignment = NSTextAlignmentLeft;
    _starNumberLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    _starNumberLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.f];
    //  _starNumberLabel.textColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    
    
    _yearLabel.text = @"+500 >";
    _yearLabel.textAlignment = NSTextAlignmentRight;
    _yearLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    _yearLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.f];
    // _yearLabel.textColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    float width = self.contentView.frame.size.width;
    
    _starNumberLabel.frame = CGRectMake(width*0.05, 0, width*0.4, width*0.1);
    _yearLabel.frame = CGRectMake(width*0.55, 0, width*0.4, width*0.1);
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
