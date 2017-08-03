//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "HotMenTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation HotMenTableViewCell {
    
    
    UIImageView *_ImageView;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customView];
    }
    return self;
}
-(void)customView {
    
    _ImageView = [UIImageView new];
    [self.contentView addSubview:_ImageView];
    
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self viewStateSet];
}
-(void)viewStateSet {
   [_ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlife.com%@",_dict[@"img"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
   }];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _ImageView.frame = CGRectMake(0, 0,self.contentView.frame.size.width, CGRectGetWidth(self.contentView.bounds)*2/3);
    // _leftImageView.backgroundColor = [UIColor blackColor];
    
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
