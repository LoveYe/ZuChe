//
//  CheliangController.m
//  ZuChe
//
//  Created by apple  on 16/12/5.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "CheliangController.h"
#import "Header.h"
#import "UIViewController+XHPhoto.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "ZCUserData.h"

#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
#import "GKImagePicker.h"
#import "VPImageCropperViewController.h"
#import "GiFHUD.h"

typedef NS_ENUM(NSInteger, PhotoType){
    
    PhotoTypeRectangle
};

#define ORIGINAL_MAX_WIDTH 640.0f


@interface CheliangController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, STPhotoKitDelegate,GKImagePickerDelegate,VPImageCropperDelegate>{
    
    CGFloat width;
    
    NSString *imagePath11;
    NSString *imagePath12;
    NSString *imagePath13;
    NSString *imagePath14;
    
    NSMutableDictionary *arrc;
    
    NSMutableArray *imageArray;
    
    UIButton *first;
    UIButton *second;
    UIButton *third;
    UIButton *forth;
    
    
    UIButton *all;
    
    UIActivityIndicatorView *dong;
    
    int aNUM;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *quxiao;
    UIButton *queding;
    
    UIView *_alertView1;
    UIView *bigView1;
    UIButton *quxiao1;
    UIButton *queding1;
}
@property (nonatomic, assign) PhotoType type;
@property (nonatomic, strong) GKImagePicker *imagePicker;
@property (nonatomic, strong) UIPopoverController *popoverController;


@end


@implementation CheliangController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO ;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    arrc = [NSMutableDictionary dictionary];
    imageArray = [NSMutableArray array];
    
    all = [UIButton new];
    
    self.view.backgroundColor = Color(255, 255, 255);
    
    self.title = @"认证资料";
    UIColor *col = Color(100, 100, 100);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self createMain];
}
- (void)fanhui:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createMain{
    
    first = [UIButton buttonWithType:UIButtonTypeCustom];
    first.frame = CGRectMake(0, 0, width, width*2/3);
    first.tag = 1000;
    [first setBackgroundImage:[UIImage imageNamed:@"前45(2)"] forState:UIControlStateNormal];
    [first addTarget:self action:@selector(first:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:first];
    
    second = [UIButton buttonWithType:UIButtonTypeCustom];
    second.tag = 1001;
    second.frame = CGRectMake(0, CGRectGetMaxY(first.frame)+width*0.02, width/3, width/3*2/3);
    [second setBackgroundImage:[UIImage imageNamed:@"后45(1)"] forState:UIControlStateNormal];
    [second addTarget:self action:@selector(second:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:second];
    
    third = [UIButton buttonWithType:UIButtonTypeCustom];
    third.tag = 1002;
    third.frame = CGRectMake(CGRectGetMaxX(second.frame), CGRectGetMaxY(first.frame)+width*0.02, width/3, width/3*2/3);
    [third setBackgroundImage:[UIImage imageNamed:@"侧面(2)"] forState:UIControlStateNormal];
    [third addTarget:self action:@selector(disange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:third];
    
    forth = [UIButton buttonWithType:UIButtonTypeCustom];
    forth.tag = 1003;
    forth.frame = CGRectMake(CGRectGetMaxX(third.frame), CGRectGetMaxY(first.frame)+width*0.02, width/3, width/3*2/3);
    [forth setBackgroundImage:[UIImage imageNamed:@"内饰(1)"] forState:UIControlStateNormal];
    [forth addTarget:self action:@selector(forth:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forth];
    
    
//    NSArray *array = @[@"前45(2)",@"后45(1)",@"侧面(2)",@"内饰(1)"];
//    for (int i = 0; i < 4; i++) {
//        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        if (i == 0) {
//            button.frame = CGRectMake(0, 0, width, width*2/3);
//        }else{
//            
//            button.frame = CGRectMake(width*0.05+(i-1)*(width/3-width*0.03), width*2/3, width/3-width*0.03, (width/3-width*0.03)*2/3);
//        }
//        [button setBackgroundImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
//        button.tag = 1000+i;
//        [button addTarget:self action:@selector(first:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//    }
    
    UILabel *duan = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3, CGRectGetMaxY(third.frame)+20, width*0.6, width*0.05)];
    duan.text = @"请上传4张车辆照片";
    duan.tintColor = Color(143, 143, 143);
    duan.textColor = Color(143, 143, 143);
    duan.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
    duan.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:duan];
    
    UILabel *chang = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.4, CGRectGetMaxY(duan.frame)+10, width*0.8, width*0.05)];
    chang.text = @"此车源可能符合免费上门摄影的条件";
    chang.tintColor = Color(143, 143, 143);
    chang.textColor = Color(143, 143, 143);
    chang.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
    chang.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:chang];
    
    UIButton *label = [UIButton buttonWithType:UIButtonTypeCustom];
    label.frame = CGRectMake(width/2-width*0.075, CGRectGetMaxY(chang.frame)+width*0.08, width*0.15, width*0.15);
    [label setBackgroundImage:[UIImage imageNamed:@"logo浅.png"] forState:UIControlStateNormal];
    label.userInteractionEnabled = NO;
//    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    UIButton *baocun = [UIButton buttonWithType:UIButtonTypeCustom];
    baocun.frame = CGRectMake(width/2-width*0.25, CGRectGetMaxY(label.frame)+width*0.08, width*0.5, width*0.1);
    baocun.backgroundColor = Color(7, 187, 177);
    [baocun setTitle:@"保存照片" forState:UIControlStateNormal];
    [baocun setTintColor:[UIColor whiteColor]];
    [baocun addTarget:self action:@selector(baocun:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:baocun];
}
- (void)first:(UIButton *)sender{
    
    first=sender;
//    self.firstPic.tag= 1000;
//    self.secPic.tag  = 1;
//    self.thiPic.tag  = 2;
//    self.fouPic.tag  = 3;
    
    first.tag = 1000;
    second.tag = 1;
    third.tag = 2;
    forth.tag = 3;
    
    [self chooseBtnClick:sender];
    
//    [self showCanEdit:YES photo:^(UIImage *photo) {
//        
//        [sender setBackgroundImage:photo forState:UIControlStateNormal];
//        
//        [arrc setObject:photo forKey:@"cheliang1"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photo) forKey:@"cheliangtupian1"];
//        
//        NSString *path = NSHomeDirectory();
//        imagePath11 = [path stringByAppendingString:@"/Document/pic11.jpg"];
//        
//        NSLog(@"aaaaaaaaaaaaaa%@",imagePath11);
//        
//        [UIImagePNGRepresentation(photo) writeToFile:imagePath11 atomically:YES];
//    }];
}
- (void)second:(UIButton *)sender{
    
    second=sender;
    //    self.firstPic.tag= 1000;
    //    self.secPic.tag  = 1;
    //    self.thiPic.tag  = 2;
    //    self.fouPic.tag  = 3;
    
    first.tag = 0;
    second.tag = 1001;
    third.tag = 2;
    forth.tag = 3;
    
    [self chooseBtnClick:sender];
    
//    [self showCanEdit:YES photo:^(UIImage *photo) {
//        
//        [sender setBackgroundImage:photo forState:UIControlStateNormal];
//        
//        [arrc setObject:photo forKey:@"cheliang2"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photo) forKey:@"cheliangtupian2"];
//        
//        NSString *path = NSHomeDirectory();
//        
//        imagePath12 = [path stringByAppendingString:@"/Document/pic12.jpg"];
//        
//        NSLog(@"bbbbbbbbbb%@",imagePath12);
//        
//        [UIImagePNGRepresentation(photo) writeToFile:imagePath12 atomically:YES];
//    }];
    
//    self.imagePicker = [[GKImagePicker alloc] init];
//    self.imagePicker.cropSize = CGSizeMake(width, width/3*2);
//    self.imagePicker.delegate = self;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker.imagePickerController];
//        
//        [self.popoverController presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        
//    } else {
//        
//        [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
//    }
//    aNUM = 2;
}
- (void)disange:(UIButton *)sender{
    
    
    third=sender;
    //    self.firstPic.tag= 1000;
    //    self.secPic.tag  = 1;
    //    self.thiPic.tag  = 2;
    //    self.fouPic.tag  = 3;
    
    first.tag = 0;
    second.tag = 1;
    third.tag = 1002;
    forth.tag = 3;
    
    [self chooseBtnClick:sender];
    
//    [self showCanEdit:YES photo:^(UIImage *photo) {
//        
//        [sender setBackgroundImage:photo forState:UIControlStateNormal];
//        [arrc setObject:photo forKey:@"cheliang3"];
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photo) forKey:@"cheliangtupian3"];
//        NSString *path = NSHomeDirectory();
//        
//        imagePath13 = [path stringByAppendingString:@"/Document/pic13.jpg"];
//        
//        NSLog(@"ccccccccccc%@",imagePath13);
//        
//        [UIImagePNGRepresentation(photo) writeToFile:imagePath13 atomically:YES];
//    }];
    
//    self.imagePicker = [[GKImagePicker alloc] init];
//    self.imagePicker.cropSize = CGSizeMake(width, width/3*2);
//    self.imagePicker.delegate = self;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker.imagePickerController];
//        
//        [self.popoverController presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        
//    } else {
//        
//        [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
//    }
//    aNUM = 3;
}

- (void)forth:(UIButton *)sender{
    
    
    forth=sender;
    //    self.firstPic.tag= 1000;
    //    self.secPic.tag  = 1;
    //    self.thiPic.tag  = 2;
    //    self.fouPic.tag  = 3;
    
    first.tag = 0;
    second.tag = 1;
    third.tag = 2;
    forth.tag = 1003;
    
    [self chooseBtnClick:sender];
    
//    [self showCanEdit:YES photo:^(UIImage *photo) {
//        
//        [sender setBackgroundImage:photo forState:UIControlStateNormal];
//        
//        [arrc setObject:photo forKey:@"cheliang4"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photo) forKey:@"cheliangtupian4"];
//        
//        NSString *path = NSHomeDirectory();
//        imagePath14 = [path stringByAppendingString:@"/Document/pic14.jpg"];
//        
//        NSLog(@"ddddddddddddd%@",imagePath14);
//        
//        [UIImagePNGRepresentation(photo) writeToFile:imagePath14 atomically:YES];
//    }];
    
//    self.imagePicker = [[GKImagePicker alloc] init];
//    self.imagePicker.cropSize = CGSizeMake(width, width/3*2);
//    self.imagePicker.delegate = self;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker.imagePickerController];
//        
//        [self.popoverController presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        
//    } else {
//        
//        [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
//    }
//    aNUM = 4;
}

- (void)uploadPics{
    
    static NSInteger index = 0;
    if (index == 4) {
        index = 0;
        return ;
    }
}

- (void)baocun:(UIButton *)sender{
    
    if(arrc.count != 4){
        
        [self AlertView];
    }
    else{
        
        // ********************************以前的
        
        UIView *view = [GiFHUD new];
        [GiFHUD setGifWithImageName:@"加载(1).gif"];
        [GiFHUD show];
        [self performSelector:@selector(stopit) withObject:view afterDelay:2.0];
        
        dispatch_queue_t mainQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_sync(mainQueue, ^{
            
            UIImage *image1 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"cheliangtupian1"]];
            NSData *imageData1 = UIImageJPEGRepresentation(image1, 0.5);
            NSString *image1Base64 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            UIImage *image2 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"cheliangtupian2"]];
            NSData *imageData2 = UIImageJPEGRepresentation(image2, 0.5);
            NSString *image2Base64 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            UIImage *image3 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"cheliangtupian3"]];
            NSData *imageData3 = UIImageJPEGRepresentation(image3, 0.5);
            NSString *image3Base64 = [imageData3 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            UIImage *image4 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"cheliangtupian4"]];
            NSData *imageData4 = UIImageJPEGRepresentation(image4, 0.5);
            NSString *image4Base64 = [imageData4 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            NSDictionary *post = @{@"0":image1Base64,@"1":image2Base64,@"2":image3Base64,@"3":image4Base64,@"userid":[ZCUserData share].userId,@"username":[ZCUserData share].username,@"carid":self.carid};
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            NSString *url = @"http://wx.leisurecarlease.com/api.php?op=api_upload_path";
            
            AFHTTPRequestOperation *operation = [manager POST:url parameters:post constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"pic11.jpg" mimeType:@"image/jpeg/png/jpg"];
                [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"pic12.jpg" mimeType:@"image/jpeg/jpg/png"];
                [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"pic13.jpg" mimeType:@"image/jpeg/jpg/png"];
                [formData appendPartWithFileData:imageData4 name:@"3" fileName:@"pic14.jpg" mimeType:@"image/jpeg/jpg/png"];
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [self AlertView11];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
            }];
                
            [operation start];
        });
    }
}
- (void)stopit{
    
    [GiFHUD dismiss];
}


#pragma mark - alertView
- (void)AlertView{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:bigView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 1.0;
    
    [bigView addSubview:_alertView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"请上传4张车辆图片";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding];
}
- (void)moveAll{
    
    [bigView removeFromSuperview];
    [bigView1 removeFromSuperview];
}
- (void)AlertView11{
    
    bigView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bigView1.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.view addSubview:bigView1];
    
    _alertView1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.15, ScreenWidth*0.4, ScreenWidth*0.7, ScreenWidth*0.3)];
    _alertView1.backgroundColor = [UIColor whiteColor];
    _alertView1.alpha = 1.0;
    
    [bigView1 addSubview:_alertView1];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView1.frame), CGRectGetHeight(_alertView1.frame))];
    image.image = [UIImage imageNamed:@"白背景.png"];
    //    image.backgroundColor = [UIColor redColor];
    [_alertView1 addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.05, ScreenWidth*0.7, ScreenWidth*0.1)];
    label.text = @"上传成功";
    label.textColor = Color(107, 107, 107);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"ArialMT" size:18];
    [image addSubview:label];
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.18, ScreenWidth*0.6, 0.5)];
    xian.backgroundColor = Color(217, 217, 217);
    [image addSubview:xian];
    
    queding1 = [UIButton buttonWithType:UIButtonTypeCustom];
    queding1.frame = CGRectMake(0, ScreenWidth*0.2, ScreenWidth*0.7, ScreenWidth*0.08);
    [queding1 setTitle:@"确定" forState:UIControlStateNormal];
    [queding1 addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = Color(7, 187, 177);
    queding1.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding1 setTitleColor:color forState:UIControlStateNormal];
    [image addSubview:queding1];
}

#pragma mark--调用相机还是相册
-(void)chooseBtnClick:(UIButton *)button{
    
    UIActionSheet*myActionSheet = [[UIActionSheet alloc]
                                   initWithTitle:nil
                                   delegate:self
                                   cancelButtonTitle:@"取消"
                                   destructiveButtonTitle:nil
                                   otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
}
#pragma mark--actionSheet选择调用相机还是相册
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://照相机
        {
            // 拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
                [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
            }
        }
            break;
        case 1://本地相簿
        {
            // 从相册中选取
            if ([self isPhotoLibraryAvailable]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
                [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
            }
            
        }
            break;
        default:
            break;
    }
}
- (BOOL) isPhotoLibraryAvailable{
    
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark -UIActionSheet Delegate
- (BOOL) isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) doesCameraSupportTakingPhotos {
    
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) isFrontCameraAvailable {
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0,100, self.view.frame.size.width, self.view.frame.size.width*2/3) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}


-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width1 = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        
        CGFloat widthFactor = targetWidth / width1;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width1 * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        
        if ([first viewWithTag:1000]) {
            [arrc setObject:editedImage forKey:@"cheliang1"];
            //
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"cheliangtupian1"];
            
            NSString *path = NSHomeDirectory();
            imagePath11 = [path stringByAppendingString:@"/Document/pic11.jpg"];
            
            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath11 atomically:YES];
            [first setImage:editedImage forState:UIControlStateNormal];
        }
        if ([second viewWithTag:1001]){
            [arrc setObject:editedImage forKey:@"cheliang2"];
            
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"cheliangtupian2"];
            
            NSString *path = NSHomeDirectory();
            imagePath12 = [path stringByAppendingString:@"/Document/pic12.jpg"];
            
            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath12 atomically:YES];
            [second setImage:editedImage forState:UIControlStateNormal];
        }if([third viewWithTag:1002]){
            [arrc setObject:editedImage forKey:@"cheliang3"];
            
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"cheliangtupian3"];
            
            NSString *path = NSHomeDirectory();
            imagePath13 = [path stringByAppendingString:@"/Document/pic13.jpg"];
            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath13 atomically:YES];
            
            [third setImage:editedImage forState:UIControlStateNormal];
        }if([forth viewWithTag:1003]){
            [arrc setObject:editedImage forKey:@"cheliang4"];
            //
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"cheliangtupian4"];
            
            NSString *path = NSHomeDirectory();
            imagePath14 = [path stringByAppendingString:@"/Document/pic14.jpg"];
            
            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath14 atomically:YES];
            [forth setImage:editedImage forState:UIControlStateNormal];
        }
    }];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}




@end
