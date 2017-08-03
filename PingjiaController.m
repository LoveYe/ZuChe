//
//  PingjiaController.m
//  ZuChe
//
//  Created by apple  on 16/11/7.
//  Copyright © 2016年 佐途. All rights reserved.
//

#define Height(H) (H)/320.0*ScreenWidth

#import "PingjiaController.h"
#import "PingJiaXiangqingView.h"
//#import "GiveJudgeViewController.h"
#import "GetJudgeViewController.h"
#import "Header.h"
#import "SXFirsttableViewModel.h"
#import "UIImageView+WebCache.h"
#import "ZuChe/ZCUserData.h"
#import "AFHTTPRequestOperationManager.h"
#import "HttpManager.h"
#import "WSStarRatingView.h"

@interface PingjiaController ()<UITableViewDataSource,UITableViewDelegate,StarRatingViewDelegate>{
    
    UITableView *_tableView;
    
    WSStarRatingView *_wsStraRating;
    NSDictionary *_dict;
    NSMutableArray *_listArray;
    NSMutableArray *panduanarray;
    UIImageView*   _imageView;
    UILabel*_tishi;
    
    NSMutableArray *_PingJiaArray;
    
    CGFloat width;
}
@property (nonatomic,retain)UITableView *tableview;
@property (nonatomic , strong) UILabel *starLabel;

@end

@implementation PingjiaController


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    self.view.backgroundColor =Color(245, 245, 245);
    [self Tableview];
    _listArray=[NSMutableArray array];
    panduanarray=[NSMutableArray array];
    
    _PingJiaArray = [NSMutableArray array];
    
//    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
//    [HttpManager postData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=my_pingjia",NowUrl] success:^(NSDictionary *fanhuicanshu) {
//        
//        NSLog(@"%@",fanhuicanshu);
//        NSDictionary *dict =fanhuicanshu;
//        _dict =[dict objectForKey:@"memberinfo"];
//        panduanarray=[dict objectForKey:@"my_pingjia"];
//        if ([[dict objectForKey:@"my_pingjia"] isKindOfClass:[NSArray class]]) {
//            
//            for (NSDictionary * dict1 in [dict objectForKey:@"my_pingjia"])
//            {
//                SXFirsttableViewModel *model5=[SXFirsttableViewModel ViewWithDictionary:dict1];
//                [_listArray addObject:model5];
//            }
//        }
//        
//        
//        [self.tableview reloadData];
//        if (_listArray.count==0)
//        {
//            [self.tableview removeFromSuperview];
//            _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.17, ScreenWidth*0.55,ScreenWidth*0.55)];
//            _imageView.image =[UIImage imageNamed:@"小车"];
//            _tishi =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.6+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
//            
//            
//            
//            _tishi.numberOfLines =0;
//            _tishi.textAlignment =NSTextAlignmentCenter;
////            [self label:_tishi isBold:YES isFont:14];
//            _tishi.textColor=Color(99,99, 99);
//            _tishi.text= @"还没有租客给你评价";
//            [self.view addSubview:_imageView];
//            [self.view addSubview:_tishi];
//            
//        }
//        
//    } Error:^(NSString *cuowuxingxi) {
//        
//        NSLog(@"%@",cuowuxingxi);
//        
//    }];
}
-(void)Tableview{
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,ScreenWidth*0.125, ScreenWidth, ScreenHeight-ScreenWidth*0.125-64) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableview];
    _tableView.tableFooterView = [UIView new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _PingJiaArray.count;
//    NSInteger  num =0;
//    if (section ==0)
//    {
//        num=1;
//    }else
//    {
//        num=[_listArray count];
//    }
//    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGFloat height = 0.0;
////    if (indexPath.section==0) {
////        
////        height=ScreenWidth*0.14;
////    }else{
////        
////        if ([[[panduanarray objectAtIndex:indexPath.row] objectForKey:@"thumbs"] isEqualToString:@""]) {
////            height=Height(130);
////        }else
////        {
////            height=Height(183);
////        }
////        
////    }
//    return height;
    
    
    NSString *string = _PingJiaArray[indexPath.row][@"pj_content"];
    CGFloat height1 = [string boundingRectWithSize:CGSizeMake(self.view.frame.size.width-width*0.1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.height;
    
    CGFloat wid = width *0.9;
    
    return height1+wid* 0.05*4 +0.15*wid + wid*0.2*2/3;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellId=@"cellId1";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell==nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }else
//    {
//        for (UIView *sub in cell.contentView.subviews) {
//            [sub removeFromSuperview];
//        }
//    }
//    if (indexPath.section==0) {
//        static NSString *addcell=@"CZXQCell";
//        CZXQCell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
//        if (!cell) {
//            cell=[[[NSBundle mainBundle] loadNibNamed:@"CZXQCell" owner:self options:nil] firstObject];
//        }
//        
//        
//        
//        cell.jiedan.text =[NSString stringWithFormat:@"%@",[_dict objectForKey:@"jiedan"]];
//        
//        cell.fuwucishu.text=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"fuwu"]];
//        cell.xingxing =[NSString stringWithFormat:@"%@",[_dict objectForKey:@"xing"]];
//        cell.pingfen.text =cell.xingxing;
//        NSString * str=[NSString stringWithFormat:@"%@",[_dict objectForKey:@"tiqian"]];
//        
//        
//        
//        if (cell.xingxing==nil||[cell.xingxing isKindOfClass:[NSNull class]]||[cell.xingxing isEqualToString:@""] ){
//            
//            cell.pingfen.text =@"0";
//        }else{
//            
//            cell.pingfen.text =cell.xingxing;
//        }
//        if (str==nil||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]) {
//            
//            cell.tiqianshijian.text =@"0";
//        }
//        else{
//            
//            cell.tiqianshijian.text =str;
//        }
//        
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.14-0.5, ScreenWidth, 0.3)];
//        xian.backgroundColor=[UIColor lightGrayColor];
//        [cell.contentView addSubview:xian];
//        return cell;
//        
//        
//    }else
//    {
//        static NSString *addcell=@"CHEzhu_XQ_Cell";
//        CHEzhu_XQ_Cell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
//        if (!cell) {
//            cell=[[[NSBundle mainBundle] loadNibNamed:@"CHEzhu_XQ_Cell" owner:self options:nil] firstObject];
//        }
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        cell.Urlimage.layer.masksToBounds=YES;
//        cell.Urlimage.layer.cornerRadius=cell.Urlimage.frame.size.width/2;
//        NSLog(@"indexPath.row:%ld",indexPath.row);
//        SXFirsttableViewModel *momodel=_listArray[indexPath.row];
//        [cell confit3:momodel];
//        
//        return cell;
//    }
//    return cell;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat width = self.view.frame.size.width;
    
    UIView *headVCiew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, width*0.2)];
    headVCiew.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, 0, width*0.9, width*0.1)];
    numberLabel.text = [NSString stringWithFormat:@"%ld条评价",_PingJiaArray.count];
    numberLabel.font = [UIFont boldSystemFontOfSize:25];
    numberLabel.textColor = Color(107, 107, 107);
    [headVCiew addSubview:numberLabel];
    
    //      int a = [_STAR floatValue]*10;
    //    if (a%10 == 0) {
    //        _starLabel.text = [NSString stringWithFormat:@"%@.0",_STAR];
    //    }else{
    //        _starLabel.text = [NSString stringWithFormat:@"%@",_STAR];
    //    }
    
//    float x = [_STAR doubleValue];
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(numberLabel.frame)+width*0.05/4, 0.085*ScreenHeight*1.7, 0.02*ScreenHeight*1.5) numberOfStar:5];
    [headVCiew addSubview:_wsStraRating];
    
    _starLabel = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, CGRectGetMaxY(numberLabel.frame)+width*0.05/4, 0.085*ScreenHeight, 0.03*ScreenHeight)];
    _starLabel.adjustsFontSizeToFitWidth = YES;
    _starLabel.textColor = Color(107, 107, 107);
    _starLabel.font = [UIFont systemFontOfSize:18];
    [headVCiew addSubview:_starLabel];
    
    _wsStraRating.delegate = self;
//    [_wsStraRating setScore:x/5 withAnimation:YES completion:^(BOOL finished) {
//        NeedSelf.starLabel.text = [NSString stringWithFormat:@"%0.1f",x/5 * 5 ];
//    }];
    
    return headVCiew;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 64;
//    width*0.19
}






@end
