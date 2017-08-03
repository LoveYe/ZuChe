//
//  MessageCenterViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/9.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "AllPages.pch"
#import "UILabel+SizeLabel.h"
#import "XQyemianViewController.h"
@interface MessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float mHeight;
}
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSArray *array;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"消息中心"];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    
 
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([ZCUserData share].isLogin ==NO)
    {
        [self.tableView removeFromSuperview];
        [self wenxintishiTitle:@"您还没有登录哟!"];
        
    }else
    {
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
        NSDictionary*parameter =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
        [manager POST:[NSString stringWithFormat:@"%@api.php?op=tongzhilist",NowUrl] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.array =responseObject;
            NSLog(@"responseObject=%@",responseObject);
            
            if (self.array==nil ||[self.array isKindOfClass:[NSNull class]])
            {
                [self wenxintishiTitle:@"对不起,暂时没有小喇叭消息!"];
                
                
            }else
            {
                [self horn];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error%@",error);
            [self wenxintishiTitle:@"没拿到数据呢,刷新一下就好呢!"];
            
        }];
    }
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
}
-(void)horn
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-65)];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
        
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel * yuan =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, 5, 5)];
    yuan.layer.cornerRadius=yuan.frame.size.height/2;
    yuan.layer.masksToBounds=YES;
    
    NSString *str =[NSString stringWithFormat:@"%@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"redstatus"]];
    if ([str isEqualToString:@"0"] )
    {
        
        yuan.backgroundColor = Color(0, 170, 238);
    }else
    {
        yuan.backgroundColor = [UIColor grayColor];
        
    }
    [cell.contentView addSubview:yuan];
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.08, ScreenWidth*0.03, ScreenWidth*0.3, ScreenWidth*0.05)];
    //    title.backgroundColor =[UIColor yellowColor];
    title.text =[[self.array objectAtIndex:indexPath.row]objectForKey:@"title"];
    [self label:title isBold:NO isFont:13.0f];
    [cell.contentView addSubview:title];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.07, ScreenWidth-ScreenWidth*0.1, ScreenWidth*0.1)];
    label.text =[[self.array objectAtIndex:indexPath.row] objectForKey:@"msg"];
    label.textColor =[UIColor grayColor];
    label.numberOfLines =0;
    [self label:label isBold:NO isFont:12.0f];
    [cell.contentView addSubview:label];
    
    mHeight =[UILabel height:label.text widthOfFatherView:label.frame.size.width textFont:label.font];
    label.frame =CGRectMake(ScreenWidth*0.05, ScreenWidth*0.07, ScreenWidth-ScreenWidth*0.1, mHeight+20);
    
    
    UILabel *time =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.05-ScreenWidth*0.4, ScreenWidth*0.04, ScreenWidth*0.4, ScreenWidth*0.03)];
    [self label:time isBold:NO isFont:11.0f];
    time.text  =[[self.array objectAtIndex:indexPath.row] objectForKey:@"inputtime"];
    time.textColor =[UIColor grayColor];
    time.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:time];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  ScreenWidth*0.08+mHeight+20;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *orderid=[NSString stringWithFormat:@"%@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"orderid"]];
    NSString *panduan=[NSString stringWithFormat:@"%@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"model"]];
    NSString *tid=[NSString stringWithFormat:@"%@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"tid"]];
    
    [HttpManager postData:@{@"tid":tid}andUrl:@"http://zuche.ztu.wang/api.php?op=redtongzhi" success:^(NSDictionary *fanhuicanshu) {
        
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    if ([panduan isEqualToString:@"chezhu"]) {
        //车主的跳转
//        OrderDetailsViewController *order=[[OrderDetailsViewController alloc]init];
//        order.orderid=orderid;
//        order.titlename=@"";
//        [self.navigationController pushViewController:order animated:YES];
    }else
    {
        //租客的跳转
        XQyemianViewController *xqorder=[[XQyemianViewController alloc]init];
        xqorder.orderid=orderid;
        xqorder.dingdanhao8=@"";
        [self.navigationController pushViewController:xqorder animated:YES];
    }
    
    
    
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
