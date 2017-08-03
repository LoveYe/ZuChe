//
//  RZController.m
//  ZuChe
//
//  Created by apple  on 16/12/6.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "RZController.h"
#import "UIViewController+XHPhoto.h"
#import "Header.h"
#import "ZuChe/ZCUserData.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "VPImageCropperViewController.h"
#import "GKImagePicker.h"

#import "GiFHUD.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface RZController ()<VPImageCropperDelegate,GKImagePickerDelegate>{
    
    CGFloat width;
    UIButton *xingshizheng;
    UIButton *jiashizheng;
    
    NSMutableArray *_arrrrr;
    
    NSString *imagePath;
    NSString *imagePath2;
    
    UIActivityIndicatorView *dong;
    
    UIView *_alertView;
    UIView *bigView;
    UIButton *quxiao;
    UIButton *queding;
    
    UIView *_alertView1;
    UIView *bigView1;
    UIButton *quxiao1;
    UIButton *queding1;
    int aNUM;
}
@property (nonatomic,retain) NSMutableDictionary *arr;
@property (nonatomic, strong) GKImagePicker *imagePicker;
@property (nonatomic, strong) UIPopoverController *popoverController;

@end

@implementation RZController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    self.arr = [NSMutableDictionary dictionary];
    
    self.title = @"认证资料";
    UIColor *col = Color(100, 100, 100);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:col,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *submitButtonItem = [[UIBarButtonItem alloc] init];
    //    submitButtonItem.tintColor = Color(0, 215, 200);
    self.navigationItem.rightBarButtonItem = submitButtonItem;
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    xingshizheng = [UIButton buttonWithType:UIButtonTypeCustom];
    xingshizheng.frame = CGRectMake(0, width*0.02, width, width*0.6);
    xingshizheng.tag = 110;
    [xingshizheng addTarget:self action:@selector(xingshi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:xingshizheng];
    
    
    jiashizheng = [UIButton buttonWithType:UIButtonTypeCustom];
    jiashizheng.tag = 101;
    jiashizheng.frame = CGRectMake(0, CGRectGetMaxY(xingshizheng.frame)+width*0.03, width, width*0.6);
    [jiashizheng addTarget:self action:@selector(jiazheng:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jiashizheng];
    
    
    ///////////////////////////////
    UIImage *image2 = [UIImage imageWithContentsOfFile:imagePath2];
    if (image2 == nil) {
        
        UIImage *image111 = [UIImage imageNamed:@"行驶证.png"];
        [xingshizheng setBackgroundImage:image111 forState:UIControlStateNormal];
    }else{
        
        [jiashizheng setBackgroundImage:image2 forState:UIControlStateNormal];
    }
    // 给行驶证 、驾驶证添加背景图
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (image == nil) {
        
        UIImage *image222 = [UIImage imageNamed:@"驾驶证.png"];
        [jiashizheng setBackgroundImage:image222 forState:UIControlStateNormal];
    }else{
        
        [jiashizheng setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    UILabel *jige = [[UILabel alloc] initWithFrame:CGRectMake(width/2-width*0.3, CGRectGetMaxY(jiashizheng.frame)+width*0.03, width*0.6, width*0.06)];
    jige.text = @"您的隐私信息仅用于验证";
    jige.textAlignment = NSTextAlignmentCenter;
    jige.textColor = Color(150, 150, 150);
    jige.font = [UIFont systemFontOfSize:16];
    [view addSubview:jige];
    
    UIButton *baocun = [UIButton buttonWithType:UIButtonTypeCustom];
    baocun.frame = CGRectMake(width/2-width*0.4, CGRectGetMaxY(jige.frame)+width*0.03, width*0.8, width*0.1);
    baocun.backgroundColor = Color(0, 215, 200);
    [baocun setTitle:@"保存照片" forState:UIControlStateNormal];
    [baocun setTintColor:[UIColor whiteColor]];
    [baocun addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:baocun];
    
}
// 放行驶证
- (void)xingshi:(UIButton *)sender{
    
    
    xingshizheng = sender;
    xingshizheng.tag = 20171;
    jiashizheng.tag = 2;
    [self chooseBtnClick:sender];
    
//    [self showCanEdit:YES photo:^(UIImage *photo) {
//        
//        [sender setBackgroundImage:photo forState:UIControlStateNormal];
//        
//        [self.arr setObject:photo forKey:@"renzhen1"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photo) forKey:@"xingshizheng"];
//        
//        NSString *path = NSHomeDirectory();
//        imagePath2 = [path stringByAppendingString:@"/Document/pic2.jpg"];
//        
//        NSLog(@"aaaaaaaaaaaaaa%@",imagePath2);
//        
//        [UIImagePNGRepresentation(photo) writeToFile:imagePath2 atomically:YES];
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
//    aNUM = 1;
}
// 放驾驶证
- (void)jiazheng:(UIButton *)sender{
    
    jiashizheng = sender;
    jiashizheng.tag = 20172;
    xingshizheng.tag = 2;
    [self chooseBtnClick:sender];
//    [self showCanEdit:YES photo:^(UIImage *photo) {
//        
//        [sender setBackgroundImage:photo forState:UIControlStateNormal];
//        [self.arr setObject:photo forKey:@"renzhen2"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photo) forKey:@"jiashizheng"];
//        
//        NSString *path = NSHomeDirectory();
//        imagePath = [path stringByAppendingString:@"/Document/pic.jpg"];
//        [UIImagePNGRepresentation(photo) writeToFile:imagePath atomically:YES];
//        
//        
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
//- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
//    
//    if (aNUM == 1) {
//        
//        [xingshizheng setBackgroundImage:image forState:UIControlStateNormal];
//        [self.arr setObject:image forKey:@"renzhen1"];
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"xingshizheng"];
//        NSString *path = NSHomeDirectory();
//        imagePath2 = [path stringByAppendingString:@"/Document/pic2.jpg"];
//        [UIImagePNGRepresentation(image) writeToFile:imagePath2 atomically:YES];
//    }
//    if (aNUM == 2) {
//        
//        [jiashizheng setBackgroundImage:image forState:UIControlStateNormal];
//        [self.arr setObject:image forKey:@"renzhen2"];
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"jiashizheng"];
//        NSString *path = NSHomeDirectory();
//        imagePath = [path stringByAppendingString:@"/Document/pic.jpg"];
//        [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
//    }
//    [self hideImagePicker];
//}
//- (void)hideImagePicker{
//    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
//        
//        [self.popoverController dismissPopoverAnimated:YES];
//        
//    } else {
//        
//        [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
//    }
//}

- (void)baocun{
    
    if(self.arr.count != 2){
        
        [self AlertView];
    }
    else{
        
        UIView *view = [GiFHUD new];
        [GiFHUD setGifWithImageName:@"加载(1).gif"];
        [GiFHUD show];
        [self performSelector:@selector(stopit) withObject:view afterDelay:2.0];
        
        NSData *imageData1 = UIImageJPEGRepresentation([self.arr objectForKey:@"renzhen1"], 0.5);
        NSString *image1Base64 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSData *imageData2 = UIImageJPEGRepresentation([self.arr objectForKey:@"renzhen2"], 0.5);
        NSString *image2Base64 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSDictionary *postdict= @{@"userid":[ZCUserData share].userId,@"username":[ZCUserData share].username,@"carid":self.carid,@"lanben":image1Base64,@"heiben":image2Base64};
        // 开始上传
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        AFHTTPRequestOperation *operation = [manager POST:@"http://wx.leisurecarlease.com/api.php?op=api_upload_path" parameters:postdict constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
            
            [formData appendPartWithFileData:imageData1 name:@"lanben" fileName:@"1.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData2 name:@"heiben" fileName:@"2.jpg" mimeType:@"image/jpeg/png/jpg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            [self AlertView11];
            [self.navigationController popViewControllerAnimated:YES];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                           
        }];
        
        [operation start];
    }
}
- (void)stopit{
    
    [GiFHUD dismiss];
    
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tishiInfo{
    
    [self AlertView];
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
    label.text = @"请上传2张证件照";
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
    
    [bigView addSubview:_alertView1];
    
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
        
        
        if ([jiashizheng viewWithTag:20172]) {
            [self.arr setObject:editedImage forKey:@"renzhen2"];
            //
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"jiashizheng"];
            
            NSString *path = NSHomeDirectory();
            imagePath2 = [path stringByAppendingString:@"/Document/pic.jpg"];
            
            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath2 atomically:YES];
            [jiashizheng setImage:editedImage forState:UIControlStateNormal];
        }
        if ([xingshizheng viewWithTag:20171]){
            
            [self.arr setObject:editedImage forKey:@"renzhen1"];
            
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"xingshizheng"];
            
            NSString *path = NSHomeDirectory();
            imagePath = [path stringByAppendingString:@"/Document/pic2.jpg"];
            
            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath atomically:YES];
            [xingshizheng setImage:editedImage forState:UIControlStateNormal];
        }
    }];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
