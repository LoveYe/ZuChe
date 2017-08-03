//
//  CarOwnerList2.m
//  ZuChe
//
//  Created by apple  on 2017/2/13.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "CarOwnerList2.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation CarOwnerList2{
    
    UILabel *nameLabel;
    UIImageView *iconImageView;
    UILabel *lastLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self reloadView];
    }
    return self;
}
- (void)reloadView{
    
    iconImageView = [UIImageView new];
    [self.contentView addSubview:iconImageView];
    
    nameLabel = [UILabel new];
    [self.contentView addSubview:nameLabel];
    
    lastLabel = [UILabel new];
    [self.contentView addSubview:lastLabel];
}
- (void)setModel:(CarListModel *)model{
    
    [self reloadCell];
}
- (void)reloadCell{
    
    [iconImageView setImage:[UIImage imageNamed:@"拍照.png"]];
    
    nameLabel.text = _model.cartype;
    
    lastLabel.text = [NSString stringWithFormat:@"%@·步，即可完成注册",_model.num];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    
    iconImageView.frame = CGRectMake(0, 0, width*0.35, self.contentView.frame.size.height);
    
    nameLabel.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame)+width*0.04, width*0.04, width*0.55, width*0.1);
    
    lastLabel.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame)+width*0.04, CGRectGetMaxY(nameLabel.frame)+width*0.04, width*0.55, width*0.1);
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
