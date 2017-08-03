//
//  TheOwnerViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/13.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "TheOwnerViewController.h"
#import "AllPages.pch"
#import "AboutUsViewController.h"
#import "ServiceContentViewController.h"
#import "UIImageView+WebCache.h"

@interface TheOwnerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSArray *listArray;

@end

@implementation TheOwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self tableViews];
    
    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"model", nil];
    [HttpManager arrayPostData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=fuwu",NowUrl] Arraysuccess:^(NSArray *arrayfanhui) {
        NSLog(@"%@",arrayfanhui);
        _listArray =arrayfanhui;
        [self.tableView reloadData];
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@",cuowuxingxi);
        
    }];

}
- (void)tableViews
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.125, ScreenWidth, ScreenHeight-ScreenWidth*0.125-64)];
    self.tableView.delegate= self;
    self.tableView.dataSource=self;
    self.tableView.scrollEnabled =NO;
    self.tableView.backgroundColor =Color(245, 245, 249);
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear: animated];
//    self.tabBarController.tabBar.hidden=YES;
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden=NO;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num=0;
    if (section==0)
    {
        num =_listArray.count;
    }else
    {
        num=1;
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return 10;
    }else
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth*0.13;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }else
    {
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
        
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.14, 0, ScreenWidth/2, ScreenWidth*0.13)];
    titleLable.textColor=Color(64, 64, 64);
    [self label:titleLable isBold:NO isFont:13.0f];
    
    UIImageView*imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13/2-ScreenWidth*0.055/2, ScreenWidth*0.055, ScreenWidth*0.055)];
    
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.07-ScreenWidth*0.02, ScreenWidth*0.13/2-ScreenWidth*0.03/2, ScreenWidth*0.03, ScreenWidth*0.03)];
    
    imageViewes.image=[UIImage imageNamed:@"right"];
    imageViewes.alpha =0.6;
    
    if (indexPath.section==0)
    {
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[_listArray objectAtIndex:indexPath.row] objectForKey:@"image"]]];
        
        imageView.image = [UIImage imageWithData:data];
        
        
        
        titleLable.text=[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.row] objectForKey:@"catname"]];

        [cell.contentView addSubview:titleLable];
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:imageViewes];
        
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 1)];
            xian.backgroundColor =Color(225, 225, 225);
        if (indexPath.row==_listArray.count-1)
        {
            xian.frame=CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1);
        }
        [cell.contentView addSubview:xian];

        
    }else
    {
        titleLable.frame =CGRectMake(ScreenWidth/2-ScreenWidth*0.4/2, 0, ScreenWidth*0.4, ScreenWidth*0.12);
        titleLable.text=@"客服中心";
        titleLable.textAlignment =NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLable];
        
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:xian];
        
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        ServiceContentViewController *vc =[[ServiceContentViewController alloc]init];
        vc.catid =[[_listArray objectAtIndex:indexPath.row] objectForKey:@"catid"];
        [self.navigationController pushViewController:vc animated:YES] ;
        
        
    }
    else
    {
        AboutUsViewController *vc= [[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
