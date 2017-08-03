//
//  GetJudgeViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/10.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "GetJudgeViewController.h"
#import "AllPages.pch"
#import "SXFirsttableViewModel.h"
#import "UIImageView+WebCache.h"
@interface GetJudgeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *_dict;
    NSMutableArray *_listArray;
    NSMutableArray *panduanarray;
    UIImageView*   _imageView;
    UILabel*_tishi;
}
@property (nonatomic,retain)UITableView *tableview;

@end

@implementation GetJudgeViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =Color(245, 245, 249);
    [self Tableview];
    _listArray=[NSMutableArray array];
     panduanarray=[NSMutableArray array];
    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
    [HttpManager postData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=my_pingjia",NowUrl] success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"%@",fanhuicanshu);
        NSDictionary *dict =fanhuicanshu;
        _dict =[dict objectForKey:@"memberinfo"];
        panduanarray=[dict objectForKey:@"my_pingjia"];
        if ([[dict objectForKey:@"my_pingjia"] isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary * dict1 in [dict objectForKey:@"my_pingjia"])
            {
                SXFirsttableViewModel *model5=[SXFirsttableViewModel ViewWithDictionary:dict1];
                [_listArray addObject:model5];
            }
        }
        
        
        [self.tableview reloadData];
        if (_listArray.count==0)
        {
            [self.tableview removeFromSuperview];
            _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.17, ScreenWidth*0.55,ScreenWidth*0.55)];
            _imageView.image =[UIImage imageNamed:@"小车"];
            _tishi =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.6+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
            
            

            _tishi.numberOfLines =0;
            _tishi.textAlignment =NSTextAlignmentCenter;
            [self label:_tishi isBold:YES isFont:14];
            _tishi.textColor=Color(99,99, 99);
            _tishi.text= @"还没有租客给你评价";
            [self.view addSubview:_imageView];
            [self.view addSubview:_tishi];
            
        }
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
        
    }];
}
-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,ScreenWidth*0.125, ScreenWidth, ScreenHeight-ScreenWidth*0.125-64) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger  num =0;
    if (section ==0)
    {
        num=1;
    }else
    {
        num=[_listArray count];
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0.0;
    if (indexPath.section==0) {
        height=ScreenWidth*0.14;
    }else
    {
         
        if ([[[panduanarray objectAtIndex:indexPath.row] objectForKey:@"thumbs"] isEqualToString:@""]) {
            height=Height(130);
        }else
        {
           height=Height(183); 
        }
        
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cellId1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }else
    {
        for (UIView *sub in cell.contentView.subviews) {
            [sub removeFromSuperview];
        }
    }
    if (indexPath.section==0) {
        static NSString *addcell=@"CZXQCell";
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
//        if (cell.xingxing==nil||[cell.xingxing isKindOfClass:[NSNull class]]||[cell.xingxing isEqualToString:@""] )
//        {
//            cell.pingfen.text =@"0";
//        }else
//        {
//            cell.pingfen.text =cell.xingxing;
//        }
//        if (str==nil||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]) {
//            cell.tiqianshijian.text =@"0";
//        }
//        else
//        {
//            cell.tiqianshijian.text =str;
//        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.14-0.5, ScreenWidth, 0.3)];
        xian.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:xian];
        return cell;
        
        
    }else
    {
        static NSString *addcell=@"CHEzhu_XQ_Cell";
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
        
        return cell;
    }
    return cell;
}




@end
