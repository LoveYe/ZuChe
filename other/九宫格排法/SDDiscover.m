//
//  SDDiscoverTableViewHeader.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#define Height(H) (H)/320.0*ScreenWidth
#define ScreenWidth self.frame.size.width
#define ScreenHeight self.frame.size.height
#import "SDDiscover.h"
#import "SDDiscoverTableView.h"
#import "UIButton+WebCache.h"

@implementation SDDiscover

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setSd_height:(CGFloat)sd_height
{
    CGRect temp = self.frame;
    temp.size.height = sd_height;
    self.frame = temp;
}
-(void)setSd_width:(CGFloat)sd_width
{
    CGRect temp = self.frame;
    temp.size.width = sd_width;
    self.frame = temp;
}
- (void)setHeaderItemModelsArray:(NSArray *)headerItemModelsArray
{
    _headerItemModelsArray = headerItemModelsArray;
    
    [headerItemModelsArray enumerateObjectsUsingBlock:^(SDDiscoverTableView *model, NSUInteger idx, BOOL *stop) {
        SDDiscoverTableView *button = [[SDDiscoverTableView alloc] init];
        button.tag = idx;
        button.title = model.title;
        button.imageName = model.imageName;
        button.catid=model.catid;
//        [button sd_setImageWithURL:[NSURL URLWithString:model.imageName]  forState:UIControlStateNormal];

        [button addTarget:self action:@selector(buttonClickd:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.subviews.count == 0) return;
        [self.subviews enumerateObjectsUsingBlock:^(UIView *button, NSUInteger idx, BOOL *stop) {
//        button.frame = CGRectMake(idx * self.frame.size.width/4, 0, self.frame.size.width/4,self.frame.size.width/4);
      button.frame=CGRectMake(idx%3*(ScreenWidth/3),idx/3*(self.frame.size.height/3), ScreenWidth/3,(self.frame.size.height/3));
            
    }];
}

- (void)buttonClickd:(SDDiscoverTableView *)button
{
    if (button.highlighted) {
        button.frame=CGRectMake(103,10,button.frame.size.width-20,button.frame.size.height-20);
    }
    if (self.buttonClickedOperationBlock) {
        self.buttonClickedOperationBlock(button.tag);
    }
}

@end


@implementation SDDiscoverTableViewHeaderItemModel1

+ (instancetype)modelWithTitle:(NSString *)title imageName:(NSString *)imageName catid:(NSString *)catid destinationControllerClass:(Class)destinationControllerClass
{
    SDDiscoverTableViewHeaderItemModel1 *model = [[SDDiscoverTableViewHeaderItemModel1 alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.catid=catid;
    model.destinationControllerClass = destinationControllerClass;
    return model;
}

@end