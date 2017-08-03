//
//  JxzTableViewCell.h
//  ZuChe
//
//  Created by home on 2017/3/3.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol commonMenuDelgate <NSObject>
//
//-(void)creatCommonMenuColloner:(CGPoint)commMePoint ;
//
//@end
@interface JxzTableViewCell : UITableViewCell

@property (nonatomic,assign) BOOL flag;
@property (nonatomic,assign) int itemCount;

@property(nonatomic , strong) NSDictionary *dict;

@property (nonatomic,strong)NSString *groupId;

//@property (nonatomic,weak)id <commonMenuDelgate>delgate;
//@property(nonatomic,assign)NSInteger tagId;

@end
