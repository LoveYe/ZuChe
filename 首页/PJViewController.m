//
//  PJViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/2/26.
//  Copyright © 2016年 佐途. All rights reserved.
//

//首页车辆详情最下面按钮“点击查看更多图片”的页面

#import "PJViewController.h"
#import "AllPages.pch"
@interface PJViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableview;
@end

@implementation PJViewController
-(void)viewWillAppear:(BOOL)animated
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
    [GiFHUD setGifWithImageName:@"加载动画.gif"];
    [GiFHUD showWithOverlay];
    
    [self addTitleViewWithTitle:self.CarPJName];
    self.view.backgroundColor=[UIColor whiteColor];
    [self Tableview];
    
}
-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height(44)) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
    [GiFHUD dismiss];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listarr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(185);
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
//    static NSString *addcell=@"CHEzhu_XQ_Cell";
////    CHEzhu_XQ_Cell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
////    if (!cell) {
////        cell=[[[NSBundle mainBundle] loadNibNamed:@"CHEzhu_XQ_Cell" owner:self options:nil] firstObject];
////    }
////    cell.selectionStyle=UITableViewCellSelectionStyleNone;
////    cell.Urlimage.layer.masksToBounds=YES;
////    cell.Urlimage.layer.cornerRadius=cell.Urlimage.frame.size.width/2;
////    NSLog(@" %@",self.listarr);
////    SXFirsttableViewModel *momodel=self.listarr[indexPath.row];
////    [cell confit3:momodel];
//    return cell;
//}
@end
