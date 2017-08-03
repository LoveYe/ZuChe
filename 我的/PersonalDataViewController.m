//
//  PersonalDataViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/9.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "Header.h"
#import "AlterUserNameViewController.h"
#import "EmergencyContactViewController.h"
#import "ZCUserData.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIButton+WebCache.h"
#import "HFStretchableTableHeaderView.h"
#import "IndividualitySignViewController.h"
#import "HobbyViewController.h"
#import "OccupationViewController.h"
#import "ForgetPSWView.h"


@interface PersonalDataViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIImagePickerController*imagePicker;
    UIImage * newHeadImg;
    UIView *contentView;
    UIButton *photo;
    NSArray *_listArray;
}
@property (nonatomic,retain)UITableView *tableView;
@property(nonatomic,strong)UIImageView *zoomImageView;
@property (nonatomic,strong)HFStretchableTableHeaderView *stretchHeaderView;

@end

@implementation PersonalDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =Color(245, 245, 249);
    [self addTitleViewWithTitle:@"我的"];
    
    NSLog(@"学历是：%@",[ZCUserData share].xueli);
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int  num = 0;
    if (section ==0)
    {
        num  =5;
    }
    if (section ==1)
    {
        num  =1;
    }
    if (section ==2)
    {
        num  =2;
    }
    
    
    return num;
}
- (void)initStretchHeader
{
    _zoomImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.62)];
    _zoomImageView.image =[UIImage imageNamed:@"个人中心背景.jpg"];
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    _zoomImageView.clipsToBounds = YES;
    
    
    
    
    contentView = [[UIView alloc] initWithFrame:_zoomImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:_zoomImageView subViews:contentView];
    
    
    UILabel *phone =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.4/2, ScreenWidth*0.09, ScreenWidth*0.4, ScreenWidth*0.07)];
    //            phone.backgroundColor =[UIColor yellowColor];
    phone.textAlignment =NSTextAlignmentCenter;
    phone.textColor =[UIColor whiteColor];
    //            [self label:phone isBold:NO isFont:18.0f];
    phone.font =[UIFont systemFontOfSize:18.0f];
    [contentView addSubview:phone];
    NSMutableString *phones =[[NSMutableString alloc]initWithString:[ZCUserData share].mobile];
    [phones deleteCharactersInRange:NSMakeRange(3, 4)];
    //  添加＊＊＊ 从第三个开始
    [phones insertString:@"****" atIndex:3];
    phone.text =phones;
    
    
    UIButton * popBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    popBtn.frame =CGRectMake(ScreenWidth*0.03, ScreenWidth*0.1, ScreenWidth*0.05, ScreenWidth*0.05);
    [popBtn setBackgroundImage:[UIImage imageNamed:@"向左箭头"] forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(popBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:popBtn];
    
    UIImageView *ph =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.24/2-1, ScreenWidth*(0.1+0.07+0.02)-1, ScreenWidth*0.24+2, ScreenWidth*0.24+2)];
    ph.image =[UIImage imageNamed:@"头像背景"];
    [contentView addSubview:ph];
    
    
    photo =[UIButton buttonWithType:UIButtonTypeSystem];
    photo.frame=CGRectMake(ScreenWidth/2-ScreenWidth*0.24/2, ScreenWidth*(0.1+0.07+0.02), ScreenWidth*0.24, ScreenWidth*0.24);
    photo.layer.masksToBounds =YES;
    photo.layer.cornerRadius=photo.frame.size.height/2;
    [photo setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [photo addTarget:self action:@selector(touxiangButton:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:photo];
    NSString * srting =[NSString stringWithFormat:@"%@",[ZCUserData share].thumb];
    if ([srting isKindOfClass:[NSNull class]]||[srting isEqualToString:@""]||[srting isEqual:@""]) {
        [photo setBackgroundImage: [UIImage imageNamed:@"Big"] forState:UIControlStateNormal];
    }else
    {
        [photo sd_setBackgroundImageWithURL:[NSURL URLWithString:srting] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像"]];
    }
//    
//    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.04-ScreenWidth*0.04, ScreenWidth*0.13/2-ScreenWidth*0.04/2, ScreenWidth*0.04, ScreenWidth*0.04)];
//    imageViewes.image=[UIImage imageNamed:@"right"];
//    
//    [contentView addSubview:imageViewes];
//    
    
    UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*(0.1+0.07+0.02+0.24+0.04)+2, ScreenWidth, 1)];
    xian.backgroundColor =Color(225, 225, 225);
    [contentView addSubview:xian];
    
    
    UILabel *qianming =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*(0.1+0.07+0.02+0.24+0.04)+3, ScreenWidth-ScreenWidth*0.08, ScreenWidth*0.62-ScreenWidth*(0.1+0.07+0.02+0.24+0.04)-3)];
    NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].descriptions];
    
    if (string.length==0)
    {
        qianming.text =@"您还没有填写您的个性签名。";
    }else
    {
        qianming.text=string;
        
    }
    [self  label:qianming isBold:NO isFont:13.0f];
    qianming.textColor =Color(153, 153, 153);
    qianming.numberOfLines=2;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:qianming.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [qianming.text length])];
    qianming.attributedText = attributedString;
    [contentView addSubview:qianming];
    
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
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04 , 0, ScreenWidth/2, ScreenWidth*0.13)];
    titleLable.textColor=[UIColor blackColor];
    //    titleLable.backgroundColor =[UIColor blueColor];
    [self label:titleLable isBold:NO isFont:14.0f];
    
    UILabel *titleLable1=[[UILabel alloc]initWithFrame:CGRectMake(0 , 0, ScreenWidth, ScreenWidth*0.13)];
    titleLable1.textColor=[UIColor redColor];
    titleLable1.textAlignment=NSTextAlignmentCenter;
    //    titleLable.backgroundColor =[UIColor blueColor];
    [self label:titleLable1 isBold:NO isFont:15.0f];
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.04-ScreenWidth*0.04, ScreenWidth*0.13/2-ScreenWidth*0.04/2, ScreenWidth*0.04, ScreenWidth*0.04)];
    imageViewes.image=[UIImage imageNamed:@"right"];
    
    UILabel *ziliao =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.085-ScreenWidth*0.5, 0, ScreenWidth*0.5, ScreenWidth*0.13)];
    [self label:ziliao isBold:NO isFont:13.0f];
    ziliao.textColor =Color(100, 100, 100);
    ziliao.textAlignment=NSTextAlignmentRight;
    
    if (indexPath.section ==0)
    {
        
        
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        
        
        
        
        if (indexPath.row ==0)
        {
            titleLable.text=@"昵称";
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].nickname];
            ziliao.text =string;
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
            
            
        }
        if (indexPath.row ==1)
        {
            titleLable.text=@"学历";
            
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].xueli];
            ziliao.text =string;
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        if (indexPath.row ==2)
        {
            titleLable.text=@"职业";
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].zhiye];
            ziliao.text =string;
            
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        
        if (indexPath.row ==3)
        {
            titleLable.text=@"兴趣爱好";
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].xingqu];
            ziliao.text =string;
            
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        
        
        if (indexPath.row ==4)
        {
            
            
            
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
            titleLable.text=@"个性签名";
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        
    }if (indexPath.section==1)
    {
        
        NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].lianxi];
        
        if (string.length>3)
        {
            NSArray *arry=[string componentsSeparatedByString:@":"];
            NSString * str =[NSString stringWithFormat:@"%@",[arry objectAtIndex:1]];
            NSMutableString *phones =[[NSMutableString alloc]initWithString:str];
            [phones deleteCharactersInRange:NSMakeRange(3, 4)];
            //  添加＊＊＊ 从第三个开始
            [phones insertString:@"****" atIndex:3];
            ziliao.text =phones;
            
        }else
        {
            ziliao.text =string;
            
        }
        
        
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:xian];
        titleLable.text=@"紧急联系人";
        [cell.contentView addSubview:titleLable];
        [cell.contentView addSubview:imageViewes];
        [cell.contentView addSubview:ziliao];
        
    }
    
    if (indexPath.section==2)
    {
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        [cell.contentView addSubview:xian];
        
        
        if (indexPath.row==0)
        {
            titleLable.text=@"更换密码";
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:imageViewes];
        }else
        {
            titleLable1.text=@"注销登录";
            [cell.contentView addSubview:titleLable1];
            
        }
        
        
        
    }else
    {
        
    }
    
    
    return cell;
}
- (void)popBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    float myWidth;
    
    if (indexPath.section==0)
    {
        
        return  myWidth=ScreenWidth*0.13;
        
        
        
    }else
    {
        return  myWidth=ScreenWidth*0.13;
    }
    
    return  myWidth;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            if ([ZCUserData share].isLogin ==NO)
            {
                [self ShowMBHubWithTitleOnlyWithTitle:@"对不起，请先登录" withTime:2.0f];
                
            }else
            {
                AlterUserNameViewController *vc= [[AlterUserNameViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        if (indexPath.row ==1)
        {
        }
        if (indexPath.row==2)
        {
            OccupationViewController *vc= [[OccupationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==3)
        {
            HobbyViewController *vc =[[HobbyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==4)
        {
            IndividualitySignViewController *sign =[[IndividualitySignViewController alloc]init];
            [self.navigationController pushViewController:sign animated:YES];
        }
    }
    if (indexPath.section==1)
    {
        
        EmergencyContactViewController *vc= [[EmergencyContactViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {
            ForgetPSWView *vc= [[ForgetPSWView alloc]init];
//            vc.navtitle =@"更换密码";
            [self.navigationController pushViewController:vc animated:YES];
            
        }else
        {
            [[ZCUserData share]saveUserInfoWithUserId:nil username:nil descriptions:nil mobile:nil fuwu:nil jiedan:nil lianxi:nil yinxiang:nil nickname:nil thumb:nil tiqian:nil xing:nil xingqu:nil xueli:nil zhiye:nil IsLogin:NO];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==2)
    {
        return 0;
    }else
        
        return 10;
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
    
    [self tableViews];
    
    [self initStretchHeader];
    
    NSLog(@"%@",[ZCUserData share].lianxi);
    
    
    
}
-(void)touxiangButton:(UIButton *)btn
{
    NSLog(@"点击了头像,请选择更换头像方式");
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择上传方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];
}
- (BOOL) isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://照相机
        {
            if ([self isCameraAvailable])
            {
                
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //            [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }else
            {
                NSLog(@"该设备没有摄像头");
            }
            
        }
            break;
            
        case 1://本地相簿
        {
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate=self;
            imagePicker.allowsEditing=YES;
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [[UINavigationBar appearance] setTintColor:[UIColor blueColor]];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            
            break;
            
        default:
            break;
    }
}
#pragma mark -UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage * headImage = info[UIImagePickerControllerEditedImage];
    
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         newHeadImg = [self imageWithImageSimple:headImage scaledToSize:CGSizeMake(150, 150)];
         NSData *photoData=UIImageJPEGRepresentation(newHeadImg,0.5);
         
         
         [photo setBackgroundImage:newHeadImg forState:UIControlStateNormal];
         //         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
         //         NSString *filePaths = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"1.jpg"]];
         //         NSData *imageData = UIImageJPEGRepresentation(newHeadImg, 1);
         //         [imageData writeToFile:filePaths atomically:YES];
         [self updateUserPhotoWithImage:photoData];
     }];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
-(void)updateUserPhotoWithImage:(NSData *)photoData
{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * urlString =@"http://zuche.ztu.wang/api.php?op=thumb";
    
    
    
    NSDictionary* dic = @{@"userid":[ZCUserData share].userId,
                          @"upfile":photoData,
                          };
    
    
    if (photoData.length==0) {
        NSLog(@"photoData==%@",photoData);
    }else{
        
        
        [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             [formData appendPartWithFileData:photoData name:@"upfile" fileName:@"1.jpg" mimeType:@"image/jpeg"];
         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"修改图片返回值%@",responseObject);
             NSString *  str =[NSString  stringWithFormat:@"%@",[responseObject objectForKey:@"error"]];
             if ([str isEqualToString:@"0"])
             {
                 [self ShowMBHubWithTitleOnlyWithTitle:@"上传图片成功" withTime:2.0f];
             }else
             {
                 [self ShowMBHubWithTitleOnlyWithTitle:@"上传图片失败" withTime:2.0f];
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
         }];
    }
    
}
-(void)touxiangImage
{
    
}
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
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
