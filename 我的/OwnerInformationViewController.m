//
//  OwnerInformationViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/17.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "OwnerInformationViewController.h"
#import "AllPages.pch"
@interface OwnerInformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,retain)UITableView *tableView;

@end

@implementation OwnerInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViews];
    self.view.backgroundColor=Color(245, 245, 249);
}
- (void)tableViews
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor =Color(245, 245, 249);
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.navigationBarHidden = YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int  num = 0;
    if (section ==0)
    {
        num  =2;
    }
    if (section ==1)
    {
        num  =4;
    }
    if (section ==2)
    {
        num  =1;
    }
    if (section ==3)
    {
        num  =1;
    }
    
    return num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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
    if (indexPath.section ==0)
    {
        if (indexPath.row==0)
        {
            UIImageView*zoomImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.62)];
            zoomImageView.image =[UIImage imageNamed:@"个人中心背景.jpg"];
            //            _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
            //            UIImage *image=[UIImage imageByScaleAndCropingForSize:CGSizeMake(0, ScreenWidth*0.65) oldImage:_zoomImageView.image];
            //
            //            image =[UIImage imageCompressForSizeImage:_zoomImageView.image targetSize:CGSizeMake(0, ScreenWidth*0.65)];
            [cell.contentView addSubview:zoomImageView];
            
            
            UILabel *phone =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.5/2, ScreenWidth*0.07, ScreenWidth*0.5, ScreenWidth*0.1)];
            //            phone.backgroundColor =[UIColor yellowColor];
            phone.textAlignment =NSTextAlignmentCenter;
            phone.textColor =[UIColor whiteColor];
            phone.text =@"王师傅";
            //            [self label:phone isBold:NO isFont:18.0f];
            [self label:phone isBold:YES isFont:18.0f];
            [cell.contentView addSubview:phone];
            //  添加＊＊＊ 从第三个开始
            
            
            UIButton * popBtn =[UIButton buttonWithType:UIButtonTypeSystem];
            popBtn.frame =CGRectMake(ScreenWidth*0.03, ScreenWidth*0.1, ScreenWidth*0.05, ScreenWidth*0.05);
            [popBtn setBackgroundImage:[UIImage imageNamed:@"向左箭头"] forState:UIControlStateNormal];
            [popBtn addTarget:self action:@selector(popBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:popBtn];
            
            UIImageView *ph =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.24/2-1, ScreenWidth*(0.1+0.07+0.02)-1, ScreenWidth*0.24+2, ScreenWidth*0.24+2)];
            ph.image =[UIImage imageNamed:@"头像背景"];
            [cell.contentView addSubview:ph];
            
            
            UIButton *photo =[UIButton buttonWithType:UIButtonTypeSystem];
            photo.frame=CGRectMake(ScreenWidth/2-ScreenWidth*0.24/2, ScreenWidth*(0.1+0.07+0.02), ScreenWidth*0.24, ScreenWidth*0.24);
            photo.layer.masksToBounds =YES;
            photo.layer.cornerRadius=photo.frame.size.height/2;
            [photo setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
            [cell.contentView addSubview:photo];
            
            
            
            
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*(0.1+0.07+0.02+0.24+0.04)+2, ScreenWidth, 0.5)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
            
            
            UILabel *qianming =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*(0.1+0.07+0.02+0.24+0.04)+3, ScreenWidth-ScreenWidth*0.08, ScreenWidth*0.62-ScreenWidth*(0.1+0.07+0.02+0.24+0.04)-3)];
            qianming.text=@"本车可包月,可出省,随叫随到，价格合理，欢迎您随时租用，谢谢合作";
            [self  label:qianming isBold:NO isFont:13.0f];
            qianming.textColor =Color(153, 153, 153);
            qianming.numberOfLines=2;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:qianming.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:4];//调整行间距
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [qianming.text length])];
            qianming.attributedText = attributedString;
            [cell.contentView addSubview:qianming];
            
            
            
        }
        if (indexPath.row==1)
        {
            //            float fistWitdh =  ScreenWidth *0.247;
            //
            //            float fistHeight =  ScreenWidth *0.14-1;
            //
            //
            //            for (int i =0; i<3; i++)
            //            {
            //                UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/4*(i+1))-0.5, ScreenWidth*0.16/2-ScreenWidth*0.09/2, 1, ScreenWidth*0.09)];
            //                xian.backgroundColor =Color(225, 225, 225);
            //                [cell.contentView addSubview:xian];
            //
            //            }
            //
            //            UILabel *jdLv=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            jdLv.text =@"99.9%";
            //            jdLv.textColor =Color(50, 50, 50);
            //            jdLv.textAlignment =NSTextAlignmentCenter;
            //            [self label:jdLv isBold:NO isFont:13.0f];
            //            [cell.contentView addSubview:jdLv];
            //
            //
            //            UILabel *fuwu=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh+1, ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            fuwu.text =@"1225";
            //            fuwu.textColor =Color(50, 50, 50);
            //            fuwu.textAlignment =NSTextAlignmentCenter;
            //            [self label:fuwu isBold:NO isFont:13.0f];
            //            [cell.contentView addSubview:fuwu];
            //
            //
            //
            //            UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*2+2, ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            time.text =@"60分钟";
            //            time.textColor =Color(50, 50, 50);
            //            time.textAlignment =NSTextAlignmentCenter;
            //            [self label:time isBold:NO isFont:13.0f];
            //            [cell.contentView addSubview:time];
            //
            //
            //            UILabel *pf=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*3+3, ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            pf.text =@"4.8";
            //            pf.textColor =[UIColor redColor];
            //            pf.textAlignment =NSTextAlignmentCenter;
            //            [self label:pf isBold:NO isFont:13.0f];
            //            [cell.contentView addSubview:pf];
            //
            //
            //
            //            /*********************************************************事先说明：上面是服务器传来的活数据，下面是title**********************************************************************/
            //
            //            UILabel *jdLvs=[[UILabel alloc]initWithFrame:CGRectMake(0, fistHeight/2+ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            jdLvs.text =@"接单率";
            //            jdLvs.textColor =Color(100, 100, 100);
            //            jdLvs.textAlignment =NSTextAlignmentCenter;
            //            [self label:jdLvs isBold:NO isFont:13.0f];
            //            [cell.contentView addSubview:jdLvs];
            //
            //
            //
            //            UILabel *fuwus=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh+1, fistHeight/2+ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            fuwus.text =@"服务次数";
            //            fuwus.textColor =Color(100, 100, 100);
            //            [self label:fuwus isBold:NO isFont:13.0f];
            //            fuwus.textAlignment =NSTextAlignmentCenter;
            //            [cell.contentView addSubview:fuwus];
            //
            //
            //            UILabel *times=[[UILabel alloc]initWithFrame:CGRectMake(fistWitdh*2+2, fistHeight/2+ScreenWidth*0.01, fistWitdh, fistHeight/2)];
            //            times.text =@"平均提前";
            //            times.textColor =Color(100, 100, 100);
            //            [self label:times isBold:NO isFont:13.0f];
            //            times.textAlignment =NSTextAlignmentCenter;
            //            [cell.contentView addSubview:times];
            //
            //
            //
            //
            static NSString *addcell=@"CZXQCell";
//            CZXQCell *cell=[tableView dequeueReusableCellWithIdentifier:addcell];
//            if (!cell) {
//                cell=[[[NSBundle mainBundle] loadNibNamed:@"CZXQCell" owner:self options:nil] firstObject];
//            }
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        
        
    }
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04 , 0, ScreenWidth/2, ScreenWidth*0.13)];
    titleLable.textColor=[UIColor blackColor];
    //    titleLable.backgroundColor =[UIColor blueColor];
    [self label:titleLable isBold:NO isFont:14.0f];
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.04-ScreenWidth*0.04, ScreenWidth*0.13/2-ScreenWidth*0.04/2, ScreenWidth*0.04, ScreenWidth*0.04)];
    imageViewes.image=[UIImage imageNamed:@"right"];
    
    UILabel *ziliao =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.085-ScreenWidth*0.5, 0, ScreenWidth*0.5, ScreenWidth*0.13)];
    [self label:ziliao isBold:NO isFont:13.0f];
    ziliao.textColor =Color(100, 100, 100);
    ziliao.textAlignment=NSTextAlignmentRight;
    
    if (indexPath.section==1)
    {
        
        NSArray * array =[NSArray arrayWithObjects:@"手机号",@"学历",@"职业",@"兴趣爱好", nil];
        
        NSArray * array2 =[NSArray arrayWithObjects:@"123-4569-7896",@"本科",@"程序员",@"看书，旅行", nil];
        
        titleLable.text =[array objectAtIndex:indexPath.row];
        [cell.contentView addSubview:titleLable];
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:imageViewes];
        
        ziliao.text =[array2 objectAtIndex:indexPath.row];
        [cell.contentView addSubview:ziliao];
        
        if (indexPath.row==0)
        {
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==1)
        {
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==2)
        {
            [cell.contentView addSubview:xian];
            
        }
        if (indexPath.row==3)
        {
            xian.frame=CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1);
            [cell.contentView addSubview:xian];
            
        }
        
        
        
    }
    if (indexPath.section==2)
    {
        titleLable.text =@"紧急联系人";
        [cell.contentView addSubview:titleLable];
        ziliao.text =@"张亚飞";
        [cell.contentView addSubview:ziliao];
        
        [cell.contentView addSubview:imageViewes];
        
    }if (indexPath.section==3)
    {
        titleLable.text =@"车友印象";
        [cell.contentView addSubview:titleLable];
        
    }
    
    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    float myWidth;
    
    if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            return  myWidth =ScreenWidth *0.62;
            
        }else
        {
            return  myWidth=ScreenWidth*0.16;
            
        }
        
    }else
    {
        return  myWidth=ScreenWidth*0.13;
    }
    
    return  myWidth;
}
- (void)popBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==3)
    {
        return 0;
    }else
        
        return 10;
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
