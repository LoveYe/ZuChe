//
//  DetailsCarXclTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"
#import "VPImageCropperViewController.h"



//@protocol CustomCellDelegate <NSObject>
//
//- (void)pushToNewPage;
//
//@end

@protocol toushuDelgate <NSObject>

-(void)imageButtonClick:(NSDictionary *)dict AndchePai:(NSDictionary*)cheopaiDict;

@end


@interface TousuTableViewCell : UITableViewCell<StarRatingViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,VPImageCropperDelegate>

@property (nonatomic ,strong)NSDictionary *dict;
@property (nonatomic ,assign)id<toushuDelgate>delgete;

//@property (nonatomic,strong)WSStarRatingView *wsStraRating;
@property (nonatomic,strong)UILabel *scoreLabel;
@property (nonatomic ,strong)NSDictionary *plane_name;
@end
