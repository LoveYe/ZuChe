

//
//  TouSuAddImageViewController.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/7/11.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "TouSuAddImageViewController.h"
#import "Header.h"
#import "GKImagePicker.h"
#import "VPImageCropperViewController.h"
#import "WMUtil.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "HttpManager.h"


#define ORIGINAL_MAX_WIDTH 640.0f
@interface TouSuAddImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIActionSheetDelegate,VPImageCropperDelegate,GKImagePickerDelegate,UIAlertViewDelegate>
{
    UIView *_needView;
    UITextView *_textView;
    UIView *_view;
    NSMutableArray *_initdataView;
    
    UIImageView *_leftImageView;
    UIImageView *_middleImageView;
    UIImageView *_rightImageView;
}

@end


@implementation TouSuAddImageViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _initdataView = [NSMutableArray new];
     [self needView];
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(gobackTo1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    

//      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavationView:) name:@"tousutongzhi" object:nil];
    // Do any additional setup after loading the view.
}
-(void)gobackTo1{
    
}
- (void)needView{
    
    
    _needView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _needView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _needView.tag = 1000;
    [self.view addSubview:_needView];
    
    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, 64, ScreenWidth*0.9, ScreenWidth*0.8+20+80+ScreenWidth*0.8/4*2/3)];
    _alertView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    _alertView.tag =12312;
    [_needView addSubview:_alertView];
    
//    
    UIButton *cuowu = [UIButton buttonWithType:UIButtonTypeCustom];
    cuowu.frame = CGRectMake(10, 10, 40, 40);
    [cuowu setBackgroundImage:[UIImage imageNamed:@"错灰(2).png"] forState:UIControlStateNormal];
    [cuowu addTarget:self action:@selector(removeNeedView) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cuowu];
    

//    //
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth*0.9, 60)];
    label.text = @"投诉内容";
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [_alertView addSubview:label];
    
    
    
    UIView *bootomView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, 80, ScreenWidth*0.8,ScreenWidth*0.5)];
    bootomView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [_alertView addSubview:bootomView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth*0.8-10,ScreenWidth*0.5)];
    _textView.textColor=[UIColor lightGrayColor];//设置提示内容颜色
    _textView.text=NSLocalizedString(@"点击输入您的投诉", nil);//提示语
    [_textView selectedRange] ;
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.selectedRange=NSMakeRange(0,0) ;//光标起始位置
    _textView.delegate = self;
    _textView.backgroundColor =  [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    _textView.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    [bootomView addSubview:_textView];
    
    
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.5+20+80, ScreenWidth*0.8,ScreenWidth*0.8/4*2/3)];
    _view.tag= 111111;
    [_alertView addSubview:_view];
    
    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieshu.frame = CGRectMake(0, 0, ScreenWidth*0.8/4,ScreenWidth*0.8/4*2/3);
    // jieshu.backgroundColor = Color(7, 187, 177);
    jieshu.tag = 123456;
    [jieshu setBackgroundImage:[UIImage imageNamed:@"加图(1).png"] forState:UIControlStateNormal];
    [jieshu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [jieshu setTintColor:[UIColor whiteColor]];
    [jieshu addTarget:self action:@selector(tianjiatupian:) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:jieshu];
    
    
    
    //
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.5+20+80+ScreenWidth*0.8/4*2/3, ScreenWidth*0.9, ScreenWidth*0.15)];
    label1.text = @"您的投诉将在一小时内处理";
    label1.adjustsFontSizeToFitWidth = YES;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor redColor];
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    [_alertView addSubview:label1];
    
    
    
    UIButton  *queding = [UIButton buttonWithType:UIButtonTypeCustom];
    queding.frame = CGRectMake(ScreenWidth*0.9/2-ScreenWidth*0.4/2, ScreenWidth*0.65+20+80+ScreenWidth*0.8/4*2/3, ScreenWidth*0.4, ScreenWidth*0.1);
    [queding setTitle:@"确定提交" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(tijiaoButton:) forControlEvents:UIControlEventTouchUpInside];
    UIColor *gary = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    //    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queding.backgroundColor = gary;
    [_alertView addSubview:queding];
    
//    
//    
//    UIButton  *wZxx = [UIButton buttonWithType:UIButtonTypeCustom];
//    wZxx.frame = CGRectMake(ScreenWidth*0.475, ScreenWidth*0.65+20+80+ScreenWidth*0.8/4*2/3, ScreenWidth*0.375, ScreenWidth*0.1);
//    [wZxx setTitle:@"我再想想" forState:UIControlStateNormal];
//    [wZxx addTarget:self action:@selector(removeNeedView) forControlEvents:UIControlEventTouchUpInside];
//    UIColor *color = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
//    [wZxx setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    wZxx.backgroundColor = color;
//    [_alertView addSubview:wZxx];
}


-(void)tijiaoButton:(UIButton *)tijiao {
    
    [self chunPic];
}
-(void)chunPic {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // NSDictionary *postdict= @{@"orderid":[ZCUserData share].userId,@"username":[ZCUserData share].username,@"0":image1Base64,@"1":image2Base64,@"2":image3Base64};
    // 开始上传
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:_chepai[@"plate_name"],@"plate",_textView.text,@"text",_tousuDict[@"state"][@"id"],@"indentid",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager POST:@"http://wx.leisurecarlease.com/api.php?op=api_complain" parameters:postDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        UIImage *pic1 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"love"]];
        NSData *imageData1 = UIImageJPEGRepresentation(pic1, 0.5);
        // NSString *image1Base64 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        UIImage *pic2 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"love1"]];
        NSData *imageData2 = UIImageJPEGRepresentation(pic2, 0.5);
        // NSString *image2Base64 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        UIImage *pic3 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"love2"]];
        NSData *imageData3 = UIImageJPEGRepresentation(pic3, 0.5);
        // NSString *image3Base64 = [imageData3 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        if (imageData1 != nil && imageData2 != nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 != nil && imageData2 == nil && imageData3 == nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 == nil && imageData2 != nil && imageData3 == nil) {
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 == nil && imageData2 == nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 != nil && imageData2 != nil && imageData3 == nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 == nil && imageData2 != nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"love1.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 != nil && imageData2 == nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"love.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"love2.jpg" mimeType:@"image/jpeg/png/jpg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"1");
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [WMUtil showTipsWithHUD:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love1"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"love2"];

        });
        //[self performSelector:@selector(stopit) withObject:dong afterDelay:2.0];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            [WMUtil showTipsWithHUD:@"提交失败"];
           
        });
    }];
    [operation start];
    
}

-(void)removeNeedView {
    [_needView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:NO];
}
#define mark TextViewDelegate  ------
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor])//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    
    if ([text isEqualToString:@"\n"])//回车事件
    {
        if ([textView.text isEqualToString:@""])//如果直接回车，显示提示内容
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text=NSLocalizedString(@"点击输入您的投诉", nil);
        }
        [textView resignFirstResponder];//隐藏键盘
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"点击输入您的投诉", nil);
    }
}
#pragma mark--调用相机还是相册
-(void)tianjiatupian:(UIButton *)button{
    
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

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        
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
        
//        
//        if ([jiashizheng viewWithTag:20172]) {
//            [self.arr setObject:editedImage forKey:@"renzhen2"];
//            //
//            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"jiashizheng"];
//            
//            NSString *path = NSHomeDirectory();
//            imagePath2 = [path stringByAppendingString:@"/Document/pic.jpg"];
//            
//            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath2 atomically:YES];
//            [jiashizheng setImage:editedImage forState:UIControlStateNormal];
//        }
//        if ([xingshizheng viewWithTag:20171]){
//            
//            [self.arr setObject:editedImage forKey:@"renzhen1"];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"xingshizheng"];
//            
//            NSString *path = NSHomeDirectory();
//            imagePath = [path stringByAppendingString:@"/Document/pic2.jpg"];
//            
//            [UIImagePNGRepresentation(editedImage) writeToFile:imagePath atomically:YES];
//            [xingshizheng setImage:editedImage forState:UIControlStateNormal];
//        }
        
        
            CGFloat width = ScreenWidth;
        
        if (_initdataView.count<3) {
            
            if (_initdataView.count == 0) {
                
                
                UIButton *button = (UIButton *)[_view viewWithTag:123456];
                _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width*0.8/4, width*0.8/4*2/3)];
                _leftImageView.image = editedImage;
                [_view addSubview:_leftImageView];
                
                [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love"];
                
                button.frame = CGRectMake(width*0.8/4,0,width*0.8/4, width*0.8/4*2/3);
                
                [_initdataView addObject:editedImage];
                
            }else if (_initdataView.count == 1) {
                
                UIButton *button = (UIButton *)[_view viewWithTag:123456];
                _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.8/4,0,width*0.8/4, width*0.8/4*2/3)];
              
                _middleImageView.image = editedImage;
                [_view addSubview:_middleImageView];
                
//                _leftImageView.image = (UIImage *)_initdataView[0];
//                _leftImageView.frame = CGRectMake(0,0,width*0.8/4, width*0.8/4*2/3);
//                  [_view addSubview:_leftImageView];
               
                [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love1"];
                
                button.frame = CGRectMake(width*0.8/4*2,0,width*0.8/4, width*0.8/4*2/3);
                
                [_initdataView addObject:editedImage];
                
            }else if (_initdataView.count == 2) {
                
                
                UIButton *button = (UIButton *)[_view viewWithTag:123456];
                _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.8/4*2,0,width*0.8/4,width*0.8/4*2/3)];
                _rightImageView.image = editedImage;
                 _middleImageView.image = _initdataView[1];
                 _leftImageView.image = _initdataView[0];
                [_view addSubview:_rightImageView];
                
                [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(editedImage) forKey:@"love2"];
                
                button.frame = CGRectMake(width*0.8/4*3,0,width*0.8/4, width*0.8/4*2/3);
                
                [_initdataView addObject:editedImage];
                
            }
            

        }
        
        
    }];
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
