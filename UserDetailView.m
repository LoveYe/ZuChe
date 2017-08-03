//
//  UserDetailView.m
//  ZuChe
//
//  Created by apple  on 2017/3/24.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "UserDetailView.h"
#import "Header.h"
#import "ParentsViewController.h"
#import "EmergencyContactViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UIButton+WebCache.h"
#import "ZHPickView.h"
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZCUserData.h"
#import "UIImageView+WebCache.h"
#import "PTXDatePickerView.h"
#import "HttpManager.h"
#import "AllPages.pch"
#import "UIImageView+WebCache.h"

#import "UserMineController.h"

#import "EnergencyView.h"

@interface UserDetailView ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate,UIImagePickerControllerDelegate,PTXDatePickerViewDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate,phoneNumberDelegate>{
    
    UITableView *_tableView;
    CGFloat width;
    CGFloat height;
    
    UIImageView *image;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *queding;
    UIButton *quxiao;
}
@property (nonatomic, strong) PTXDatePickerView *datePickerView;
@property (nonatomic, strong) NSDate *selectedDate; //代表dateButton上显示的时间。

@end

@implementation UserDetailView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhuiAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *baocun = [UIButton buttonWithType:UIButtonTypeCustom];
    baocun.frame = CGRectMake(10, -5, 60, 30);
    [baocun setTitle:@"保存" forState:UIControlStateNormal];
    UIColor *color = Color(7, 187, 177);
    baocun.titleLabel.font = [UIFont systemFontOfSize:17];
    [baocun setTitleColor:color forState:UIControlStateNormal];
    [baocun addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:baocun];
    self.navigationItem.rightBarButtonItem = right;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*0.4, width*0.08)];
    title.text = @"编辑个人资料";
    title.textColor = Color(100, 100, 100);
    title.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
    
    [self createTableVIew];
}
- (void)fanhuiAction{
    
    UserMineController *view = [[UserMineController alloc] init];
    
    view.hidesBottomBarWhenPushed = YES;view.hidesBottomBarWhenPushed = YES;
    view.hidesBottomBarWhenPushed = YES;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"Fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)baocun{
    
    UITextField *label  = (UITextField *)[self.view viewWithTag:4003];
    UILabel *label2 = (UILabel *)[self.view viewWithTag:4002];
    
    NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"zheshi1phone"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                       [ZCUserData share].userId,@"userid",
                       label.text,@"nickname",//昵称
                       @"学历",@"xueli",//学历
                       @"职业",@"zhiye",//职业
                       @"兴趣",@"xingqu",//兴趣
                       @"qianming",@"description",//签名
                       str,@"lianxi", label2.text,@"birthday",nil];
    [HttpManager postData:dic andUrl:XIUGAIZILIAO success:^(NSDictionary *fanhuicanshu) {
        
        UserMineController *view = [[UserMineController alloc] init];
        view.hidesBottomBarWhenPushed = YES;
        view.hidesBottomBarWhenPushed = YES;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"Fade";
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self.navigationController popViewControllerAnimated:NO];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}
- (void)createTableVIew{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height-width*0.15)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return width*2/3;
    }if (indexPath.row == 1) {
        
        return width*0.33;
    }if (indexPath.row == 4) {
        
        return width*0.3;
    }
    else
        return width*0.18;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stac";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stac];
    }
    if (indexPath.row == 0) {
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(0, -width/3, width, width)];
        [cell addSubview:image];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imgURL]];
            
            NSData *data = [NSData dataWithContentsOfURL:iconURL];
            
            NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *image1 = [UIImage imageWithData:data];
                
                if ([s isEqualToString:@""]) {
                    
                    image.backgroundColor = Color(7, 187, 177);
                }else{
                    
                    image.image = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                }
                
            });
        });
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-width*0.15, width/3+width*0.15, width*0.3, width*0.3)];
        image2.image = [UIImage imageNamed:@"拍照12.png"];
        [image addSubview:image2];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.1, CGRectGetMaxY(image2.frame)+width*0.02, width*0.8, width*0.08)];
        label.text = @"点击修改头像";
        label.tag = 4001;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        [image addSubview:label];
        
    }if (indexPath.row == 1) {
        
        UILabel *nicheng = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.5, width*0.08)];
        nicheng.text = @"昵称";
        nicheng.textColor = Color(107, 107, 107);
        nicheng.textAlignment = NSTextAlignmentLeft;
        nicheng.font = [UIFont systemFontOfSize:18];
        [cell addSubview:nicheng];
        
        UITextField *shuru = [[UITextField alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(nicheng.frame)+width*0.04, width*0.9, width*0.1)];
        shuru.placeholder = @"请输入昵称";
        
        if (self.nickName != nil) {
            
            shuru.text = self.nickName;
        }else{
            
            shuru.text = @"";
        }
        [shuru setValue:[UIFont fontWithName:@"ArialMT" size:22] forKeyPath:@"_placeholderLabel.font"];
        
        shuru.tag = 4003;
        shuru.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
        shuru.textAlignment = NSTextAlignmentLeft;
        shuru.textColor = Color(77, 77, 77);
        [cell addSubview:shuru];
    }if (indexPath.row == 2) {
        
        UILabel *lianxiren = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.3, width*0.08)];
        lianxiren.text = @"紧急联系方式";
        lianxiren.textColor = Color(107, 107, 107);
        lianxiren.textAlignment = NSTextAlignmentLeft;
        lianxiren.adjustsFontSizeToFitWidth = YES;
        lianxiren.font = [UIFont systemFontOfSize:18];
        [cell addSubview:lianxiren];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.4, width*0.05, width*0.5, width*0.08)];
        label.tag = 4005;
        label.textColor = Color(77, 77, 77);
        label.textAlignment = NSTextAlignmentRight;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:18];
        if (self.lianxi == nil) {
            
            label.text = @"";
        }else{
            
            label.text = self.lianxi;
        }
        
        [cell addSubview:label];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }if (indexPath.row == 3) {
        
        UILabel *shengri = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.3, width*0.08)];
        shengri.text = @"出生日期";
        shengri.textColor = Color(107, 107, 107);
        shengri.textAlignment = NSTextAlignmentLeft;
        shengri.font = [UIFont systemFontOfSize:18];
        [cell addSubview:shengri];
        
        UILabel *riqi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.35, width*0.05, width*0.55, width*0.08)];
        riqi.textColor = Color(77, 77, 77);
        riqi.tag = 4002;
        riqi.textAlignment = NSTextAlignmentRight;
        riqi.font = [UIFont systemFontOfSize:18];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell addSubview:riqi];
    }
    if (indexPath.row == 4) {
        
        UIButton *zhuxiao = [UIButton buttonWithType:UIButtonTypeCustom];
        zhuxiao.frame = CGRectMake(width/2- width*0.3, width*0.1, width*0.6, width*0.1);
        [zhuxiao setTitle:@"注销登录" forState:UIControlStateNormal];
        [zhuxiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor *color = Color(7, 187, 177);
        [zhuxiao setBackgroundColor:color];
        [cell addSubview:zhuxiao];
        [zhuxiao addTarget:self action:@selector(zhuxiao) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        [self AlertController:nil preferredStyle:UIAlertControllerStyleActionSheet actionWithTitle:@"相机" actionWithTitle2:@"从相册选择" handler:^(UIAlertAction *action) {
            // 拍照
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
        } handler2:^(UIAlertAction *action) {
            // 从相册中选取
            UIImagePickerController *imagePicker  = [[UIImagePickerController alloc] init];
            imagePicker.delegate =self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.allowsEditing =YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } handler3:^(UIAlertAction *action) {
            NSLog(@"取消");
        }];
        
//        UILabel *label = (UILabel *)[self.view viewWithTag:4001];
//        label.text = @"";
    }
    if (indexPath.row == 2) {
        
        EnergencyView *view = [[EnergencyView alloc] init];
        view.delegate = self;
        [self.navigationController pushViewController:view animated:YES];
    }
    if (indexPath.row == 3) {
        
        if (!_datePickerView) {
            _datePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.7, ScreenWidth, 246.0)];
            _datePickerView.delegate = self;
            [self.view.window addSubview:_datePickerView];
        }
        
        [_datePickerView showViewWithDate:_selectedDate animation:YES];
        _datePickerView.datePickerViewDateRangeModel = PTXDatePickerViewShowModelYearMonthDay;
        _datePickerView.minYear = 1960;
        _datePickerView.maxYear = 2000;
    }
}
#pragma mark - 注销按钮
- (void)zhuxiao{
    
//    XWAlterview *xxxx = [[XWAlterview alloc] initWithTitle:nil contentText:@"确定要退出登录吗" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
//    [xxxx show];
//    
//    xxxx.rightBlock =^{
//        
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHANGJIA"];
//        [[ZCUserData share]saveUserInfoWithUserId:nil username:nil descriptions:nil mobile:nil fuwu:nil jiedan:nil lianxi:nil yinxiang:nil nickname:nil thumb:nil tiqian:nil xing:nil xingqu:nil xueli:nil zhiye:nil IsLogin:NO];
//        [ZCUserData share].isLogin = NO;
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    xxxx.leftBlock =^{
//        
//        
//    };
    
    [self AlertView];
}
#pragma mark - 注销提示
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    //    bigView.alpha = 0.5;
    //    bigView.backgroundColor = [UIColor blackColor];
    bigView.tag = 10089;
    [self.view.window addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    [bigView addSubview:_alertView];
    
    UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image11.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image11];
    
    image11.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.04, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"确定要退出登录吗？";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image11 addSubview:label];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.18, width*0.6, 0.5)];
    line.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:line];
    
    quxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiao.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.35, ScreenWidth*0.08);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *gray111 = Color(177, 177, 177);
    UIColor *color = Color(7, 187, 177);
    quxiao.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [quxiao setTitleColor:color forState:UIControlStateNormal];
    [image11 addSubview:quxiao];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(image11.frame)/2, width*0.2+2, 0.5, width*0.1-width*0.02)];
    line2.backgroundColor = Color(217, 217, 217);
    [image11 addSubview:line2];
    
    queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(ScreenWidth*0.35, ScreenWidth*0.19, ScreenWidth*0.35, ScreenWidth*0.1);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [queding setTitleColor:gray111 forState:UIControlStateNormal];
    [image11 addSubview:queding];
}
- (void)moveAll{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
}
- (void)queding{
    
    UIView *view = (UIView *)[self.view.window viewWithTag:10089];
    [view removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHANGJIA"];
    [[ZCUserData share]saveUserInfoWithUserId:nil username:nil descriptions:nil mobile:nil fuwu:nil jiedan:nil lianxi:nil yinxiang:nil nickname:nil thumb:nil tiqian:nil xing:nil xingqu:nil xueli:nil zhiye:nil IsLogin:NO];
    [ZCUserData share].isLogin = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PTXDatePickerViewDelegate 选择时间的代理

- (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date {
    
    self.selectedDate = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    UILabel *label = [self.view viewWithTag:4002];
    label.text = [dateFormatter stringFromDate:date];
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image1 scaledToSize:(CGSize)newSize{
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    [image1 drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    
    //UIImagePickerControllerOriginalImage
    //初始化imageNew为从相机中获得的--
    UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //设置image的尺寸
    CGSize imagesize = imageNew.size;
    
    //对图片大小进行压缩--
    imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
    
    NSData *photoData=UIImageJPEGRepresentation(imageNew,0.5);
    //    UIImage *imageee=[UIImage imageWithData:photoData];
    //    [photo setBackgroundImage:imageee forState:UIControlStateNormal];
    
    [self updateUserPhotoWithImage:photoData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)updateUserPhotoWithImage:(NSData *)photoData{
    
    ParentsViewController *view = [[ParentsViewController alloc] init];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * urlString = THUMB;
    NSDictionary* dic = @{@"userid":[ZCUserData share].userId,
                          @"upfile":photoData,};
    if (photoData.length==0) {
        NSLog(@"photoData==%@",photoData);
    }else{
        
        [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             [formData appendPartWithFileData:photoData name:@"upfile" fileName:@"1.jpg" mimeType:@"image/jpeg"];
             
         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSString *  str =[NSString  stringWithFormat:@"%@",[responseObject objectForKey:@"error"]];
             if ([str isEqualToString:@"1"]) {
                 
                 [view xiaojiadeTishiTitle:@"上传失败"];
             }else{
                 
                 [image sd_setImageWithURL:[NSURL URLWithString:[responseObject objectForKey:@"thumb"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     
                 }];
                 
                 [view xiaojiadeTishiTitle:@"上传成功"];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
         }];
    }
}
-(void)AlertController:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionWithTitle:(NSString *)title actionWithTitle2:(NSString *)title2 handler:(void (^ __nullable)(UIAlertAction *action))handler handler2:(void (^ __nullable)(UIAlertAction *action))handler2 handler3:(void (^ _Nullable)(UIAlertAction *action))handler3{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:handler3];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:handler2];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 手机号更改
- (void)sender:(NSString *)str{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:4005];
    label.text = str;
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
