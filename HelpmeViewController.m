//
//  HelpmeViewController.m
//  ZuChe
//
//  Created by apple  on 16/11/8.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "HelpmeViewController.h"

#import "Header.h"
#import "CoreMediaFuncManagerVC.h"

@interface HelpmeViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIImageView*erweimaimageView;

@end

@implementation HelpmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title = @"关于我们";
    
    //标志
    UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.3/2,ScreenWidth*0.05+64, ScreenWidth*0.3, ScreenWidth*0.3)];
    image.image =[UIImage imageNamed:@"Icon-60"];
    image.backgroundColor = [UIColor redColor];
    [self.view addSubview:image];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.4+64, ScreenWidth, ScreenHeight-65-ScreenWidth*0.4+64)];
    self.tableView.dataSource=self;
    self.tableView.delegate =self;
    self.tableView.backgroundColor =Color(245, 245, 249);
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num=0;
    if (section==0)
    {
        num=1;
    }
    if (section==1)
    {
        num=4;
    }if (section==2){
        num=1;
    }
    
    return  num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }else
    {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSMutableArray * array =[NSMutableArray arrayWithObject:@"给我评价"];
    NSMutableArray * array2=[NSMutableArray arrayWithObjects:@"客服专线：",@"官方公众号：",@"联系方式：",@"官方微信：", nil];
    NSMutableArray * array3 =[NSMutableArray arrayWithObject:@"分享二维码给好友"];
    
    UILabel* title =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.12/2-ScreenWidth*0.06/2, ScreenWidth*0.5, ScreenWidth*0.06)];
    //    [_view label:title isBold:NO isFont:13.0f];
    title.textColor =Color(32, 32, 32);
    [cell.contentView addSubview:title];
    
    NSMutableArray * array4 =[NSMutableArray arrayWithObjects:@"021-64700500",@"闲车",@"huangsensh",@"http://www.Hsenxc.com", nil];
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.08, ScreenWidth*0.13/2-ScreenWidth*0.03/2, ScreenWidth*0.03, ScreenWidth*0.03)];
    imageViewes.image=[UIImage imageNamed:@"right"];
    imageViewes.alpha =0.6;
    
    
    UILabel *text =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*(0.04+0.5), ScreenWidth*0.12/2-ScreenWidth*0.06/2, ScreenWidth*0.5, ScreenWidth*0.06)];
    text.textAlignment =NSTextAlignmentRight;
    text.textColor =Color(99, 99, 99);
    //    [_view label:text isBold:NO isFont:13.0f];
    
    if (indexPath.section==0)
    {
        title.text =[array objectAtIndex:indexPath.row];
        [cell.contentView addSubview:imageViewes];
    }
    if (indexPath.section==1)
    {
        title.text =[array2 objectAtIndex:indexPath.row];
        if (indexPath.row==2)
        {
            [cell.contentView addSubview:text];
            text.text =[array4 objectAtIndex:indexPath.row];
            
        }
        if (indexPath.row==1)
        {
            [cell.contentView addSubview:text];
            text.text =[array4 objectAtIndex:indexPath.row];
            
        }
        if (indexPath.row ==0)
        {
            text.frame =CGRectMake(ScreenWidth-ScreenWidth*(0.085+0.5), ScreenWidth*0.12/2-ScreenWidth*0.06/2, ScreenWidth*0.5, ScreenWidth*0.06);
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:text];
            text.text =[array4 objectAtIndex:indexPath.row];
        }
        
        if (indexPath.row==3)
        {
            [cell.contentView addSubview:text];
            text.text =[array4 objectAtIndex:indexPath.row];
        }
    }
    if (indexPath.section==2)
    {
        title.text =[array3 objectAtIndex:indexPath.row];
        
        UIButton *erWeiMa=[UIButton buttonWithType:UIButtonTypeSystem];
        erWeiMa.frame =CGRectMake(ScreenWidth/2-ScreenWidth*0.3/2, ScreenWidth*0.5/2-ScreenWidth*0.3/2, ScreenWidth*0.3, ScreenWidth*0.3);
        [erWeiMa addTarget:self action:@selector(erWeiBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.erweimaimageView =[[UIImageView alloc]init];
        self.erweimaimageView.image=[UIImage imageNamed:@" 假的二维码"];
        [erWeiMa setBackgroundImage:[UIImage imageNamed:@" 假的二维码"] forState:UIControlStateNormal];
        [cell.contentView addSubview:erWeiMa];
        
        float  nowHeight =ScreenWidth*0.5/2-ScreenWidth*0.3/2+ScreenWidth*0.3;
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.5/2, nowHeight, ScreenWidth*0.5, ScreenWidth*0.5/2-ScreenWidth*0.3/2)];
        //        label.backgroundColor =[UIColor redColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor =Color(100, 100, 100);
        label.text =@"当前版本号: v1.0.1";
        //        [_view label:label isBold:NO isFont:12.0f];
        [cell .contentView addSubview:label];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSString * appstoreUrlString = @"http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=1092600640";
        
        NSURL * url = [NSURL URLWithString:appstoreUrlString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            NSLog(@"can not open");
        }
        
    }if (indexPath.section==1) {
        if (indexPath.row==2) {
            [CoreMediaFuncManagerVC call:@"18056453943" inViewController:self failBlock:^{
                NSLog(@"模拟器不能打");
            }];
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2)
    {
        return ScreenWidth *0.5;
    }else
        return ScreenWidth *0.12;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击二维码

- (void)erWeiBtn:(UIButton *)btn
{
    UIActionSheet *actionSheet =[[UIActionSheet alloc]initWithTitle:@"是否保存图片到本地图库?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存图片" otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            UIImageWriteToSavedPhotosAlbum(self.erweimaimageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }
            break;
        default:
            break;
    }
    
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
        //        [_view xiaojiadeTishiTitle:@"保存成功"];
        
        
    }else
    {
        message = [error description];
        //        [_view xiaojiadeTishiTitle:@"保存失败"];
        
    }
    NSLog(@"message is %@",message);
}

@end
