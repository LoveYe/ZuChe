//
//  SOUSUOViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/3/11.
//  Copyright © 2016年 佐途. All rights reserved.


//搜索结果页面

#import "SOUSUOViewController.h"
#import "AllPages.pch"
#import "SXFirsttableViewModel.h"
@interface SOUSUOViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *countarray;
    UIImageView *imageView;
    UILabel *tishi;
    NSMutableArray *aiaiai;
}
@property (nonatomic,retain)UITableView *tableview;
@end

@implementation SOUSUOViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    aiaiai=[NSMutableArray array];
    if (!countarray)
    {
        countarray=[NSMutableArray array];

    }
    [self addTitleViewWithTitle:[NSString stringWithFormat:@"搜索结果:%@",self.search]];
    self.view.backgroundColor=[UIColor whiteColor];
    
    

    [self Downwork];
    
    [self Tableview];

    
}
-(void)Downwork
{
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       self.search,@"search",nil];
    
    [HttpManager postData:dic andUrl:SEARCH_CAR success:^(NSDictionary *fanhuicanshu) {
        if (fanhuicanshu.count==0) {
            
            [self xiaojiadeTishiTitle:@"没有搜索到车辆"];
            [self tishixiaoche];
        }else
        {
            
            for (NSDictionary * dict in fanhuicanshu)
            {
                SXFirsttableViewModel *model=[SXFirsttableViewModel ViewWithDictionary:dict];
                [countarray addObject:model];
                [aiaiai addObject:dict];
            }
            [_tableview reloadData];
        }
        
        
        
        
    } Error:^(NSString *cuowuxingxi) {
        
        
    }];

}
-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height(44)) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.backgroundColor=Color(245, 245, 245);
    [self.view addSubview:_tableview];
    //小贾自定义刷新
    
    [self Refresh_JXY:_tableview VOID:^{
        countarray =[NSMutableArray array];

        [self Downwork];
        

    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return countarray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(100);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9.9;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *addcell=@"addcell";
//    AddchezhuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
//    
//    if (!cell) {
//        cell=[[[NSBundle mainBundle] loadNibNamed:@"AddchezhuTableViewCell" owner:self options:nil] firstObject];
//    }
//    cell.shenhe.hidden=YES;
//    cell.tuijian.layer.borderWidth=0.5;
//    cell.tuijian.layer.borderColor=[UIColor colorWithRed:82/255.0 green:203/255.0 blue:255/255.0 alpha:1].CGColor;
//    cell.tuijian.layer.cornerRadius = 3.0;
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.Yjiedan.hidden=YES;
//    [self label:cell.tuijian isBold:YES isFont:10.0f];
//    [self label:cell.urlTitle isBold:NO isFont:12.5f];
//    [self label:cell.paizhao isBold:NO isFont:9.5f];
//    [self label:cell.qian isBold:YES isFont:13];
//    [self label:cell.timeKm isBold:YES isFont:10.0f];
//    [self label:cell.baifenbi isBold:NO isFont:11.5f];
//    [self label:cell.fuwu isBold:NO isFont:11.5f];
//    [self label:cell.tiqian isBold:NO isFont:11.5f];
//    [self label:cell.wenzitiqian isBold:NO isFont:11.0f];
//    [self label:cell.wenzifuwu isBold:NO isFont:11.0f];
//    [self label:cell.wenzijiedan isBold:NO isFont:11.0f];
//    SXFirsttableViewModel *model=countarray[indexPath.section];
//    [cell confit:model];
//    
//    return cell;
//}

-(void)tishixiaoche
{
    imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.17, ScreenWidth*0.55,ScreenWidth*0.55)];
    imageView.image =[UIImage imageNamed:@"小车"];
    [self.view addSubview:imageView];
    
    tishi =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.6+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
    tishi.numberOfLines =0;
    tishi.textAlignment =NSTextAlignmentCenter;
    [self label:tishi isBold:YES isFont:14];
    tishi.textColor=Color(99,99, 99);
    tishi.text= @"没有筛选到相关车辆！";
    [self.view addSubview:tishi];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    InforFondViewController *infor=[[InforFondViewController alloc]init];
//    if (countarray.count==0) {
//        
//    }else
//    {
//        SXFirsttableViewModel *model=countarray[indexPath.section];
//        //获取carid
//        NSString *catidd=model.carid;
//        infor.carid=catidd;
//        NSString *listshop=[NSString stringWithFormat:@"%@",[[aiaiai objectAtIndex:indexPath.section] objectForKey:@"listshop"]];
//        infor.listshop=listshop;
//        [self.navigationController pushViewController:infor animated:YES];
//    }
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
