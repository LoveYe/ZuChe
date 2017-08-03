
//
//  GeiAdvacesViewController.m
//  CarHead
//
//  Created by MacBookXcZl on 2017/6/8.
//  Copyright © 2017年 MacBookXcZl. All rights reserved.
//

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#import "FanKuiViewController.h"
#import "IQKeyboardManager.h"
#import "ZCUserData.h"
#import "AFNetworking.h"

@interface FanKuiViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>{
    UIScrollView *_scollerView;
    NSInteger flag;
    UITextView *_textView;
    NSMutableArray *_imageDataViewArray;
}
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * middleImageView;
@property (nonatomic, strong) UIImageView * rightImageView;

@end

@implementation FanKuiViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;
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
            textView.text=NSLocalizedString(@"点击输入", nil);
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
        textView.text=NSLocalizedString(@"点击输入", nil);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageDataViewArray = [NSMutableArray new];
    [self creatScrollerView];
    flag = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *submitButtonItem = [[UIBarButtonItem alloc] init];
    //    submitButtonItem.tintColor = Color(0, 215, 200);
    self.navigationItem.rightBarButtonItem = submitButtonItem;
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(WIDTH-40, 0, 40, 40);
    [fanhui setTitle:@"提交" forState:UIControlStateNormal];
    [fanhui setTitleColor:[UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(tiJiaoButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *goback = [UIButton buttonWithType:UIButtonTypeCustom];
    goback.frame = CGRectMake(0, 0, 25, 25);
    [goback setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [goback addTarget:self action:@selector(gobackTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:goback];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
}
- (void)gobackTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -buttonClick

-(void)tiJiaoButton:(UIButton *)tiJiao {
    
    [self chunPic];
    
}
#pragma mark - setter and getter

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor greenColor];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}
#pragma mark - setter and getter

- (UIImageView *)middleImageView {
    
    if (!_middleImageView) {
        
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.backgroundColor = [UIColor redColor];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _middleImageView;
}
#pragma mark - setter and getter

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.backgroundColor = [UIColor blueColor];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightImageView;
}

-(void)creatScrollerView {
    
    _scollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, HEIGHT-64)];
    
    _scollerView.pagingEnabled = YES;
    _scollerView.delegate = self;
    _scollerView.contentSize = CGSizeMake(WIDTH,WIDTH*1.9+2);
    [_scollerView setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:_scollerView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH *0.1)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_scollerView addSubview:view];
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, 0, WIDTH*0.9, WIDTH*0.1)];
    oneLabel.text = @"描述";
    oneLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:oneLabel];
    
    
    UIView *fankuiView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), WIDTH, WIDTH*0.5)];
    [_scollerView addSubview:fankuiView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, WIDTH-10, WIDTH*0.5)];
    _textView.textColor=[UIColor lightGrayColor];//设置提示内容颜色
    _textView.text=NSLocalizedString(@"点击输入", nil);//提示语
    [_textView selectedRange] ;
    _textView.selectedRange=NSMakeRange(0,0) ;//光标起始位置
    _textView.delegate=self;
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    [fankuiView addSubview:_textView];
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame), WIDTH, WIDTH *0.1)];
    view1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_scollerView addSubview:view1];
    
    UILabel *oneLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, 0, WIDTH*0.9, WIDTH*0.1)];
    oneLabel1.text = @"截图";
    oneLabel1.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:oneLabel1];
    
    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), WIDTH, WIDTH*0.4)];
    [_scollerView addSubview:imageView];
    
    
    UIButton *jieTuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jieTuButton.frame = CGRectMake(WIDTH*0.72, 0,  WIDTH*0.28,  WIDTH*0.4);
    [jieTuButton setTitle:@"添加截图   〉" forState:UIControlStateNormal];
    // jieTuButton.backgroundColor = [UIColor redColor];
    jieTuButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [jieTuButton setTitleColor:[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
    [jieTuButton addTarget:self action:@selector(jieTuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:jieTuButton];
    
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(jieTuButton.frame), WIDTH*0.72/3, WIDTH*0.4)];
    [imageView addSubview:_leftImageView];
    
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1*WIDTH*0.72/3, CGRectGetMinY(jieTuButton.frame), WIDTH*0.72/3, WIDTH*0.4)];
    [imageView addSubview:_middleImageView];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*WIDTH*0.72/3, CGRectGetMinY(jieTuButton.frame), WIDTH*0.72/3, WIDTH*0.4)];
    [imageView addSubview:_rightImageView];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(imageView.frame), WIDTH, WIDTH *0.1)];
    view2.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_scollerView addSubview:view2];
    UILabel *oneLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, 0, WIDTH*0.9, WIDTH*0.1)];
    oneLabel2.text = @"设备信息";
    oneLabel2.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:oneLabel2];
    
    NSArray *nameArray = @[@"设备型号", [[UIDevice currentDevice] model],@"iOS版本",[[UIDevice currentDevice] systemVersion]];
    
    for (int i = 0; i<4; i++) {
        
        if (i == 0 || i == 2) {
            UILabel *oneLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, CGRectGetMaxY(view2.frame)+WIDTH*0.15*i/2+(i-1)/2*1, WIDTH*0.4, WIDTH*0.15)];
            oneLabel3.text = nameArray[i];
            oneLabel3.layer.borderColor = [UIColor whiteColor].CGColor;
            //  oneLabel3.backgroundColor = [UIColor redColor];
            oneLabel3.textAlignment = NSTextAlignmentLeft;
            [_scollerView addSubview:oneLabel3];
            
            
            if (i == 0) {
                UILabel *oneLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, CGRectGetMaxY(oneLabel3.frame), WIDTH*0.9, 1)];
                oneLabel4.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                [_scollerView addSubview:oneLabel4];
                
            }
        }
        if (i == 1 || i == 3) {
            UILabel *oneLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.55, CGRectGetMaxY(view2.frame)+WIDTH*0.15*(i-1)/2+(i-1)/2*1, WIDTH*0.4, WIDTH*0.15)];
            oneLabel3.text = nameArray[i];
            oneLabel3.layer.borderColor = [UIColor whiteColor].CGColor;
            //   oneLabel3.backgroundColor = [UIColor redColor];
            oneLabel3.textAlignment = NSTextAlignmentRight;
            [_scollerView addSubview:oneLabel3];
            
            
            if (i == 1) {
                UILabel *oneLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, CGRectGetMaxY(oneLabel3.frame), WIDTH*0.9, 1)];
                oneLabel4.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                [_scollerView addSubview:oneLabel4];
                
            }
        }
        
    }
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(view2.frame)+WIDTH*0.15*1+WIDTH *0.15, WIDTH, WIDTH *0.1)];
    view3.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_scollerView addSubview:view3];
    UILabel *oneLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, 0, WIDTH*0.9, WIDTH*0.1)];
    oneLabel4.text = @"应用信息";
    oneLabel4.textAlignment = NSTextAlignmentLeft;
    [view3 addSubview:oneLabel4];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    
    NSArray *nameArray1 = @[@"应用版本", appCurVersion,@"应用Build号",appCurVersionNum];
    
    for (int i = 0; i<4; i++) {
        
        if (i == 0 || i == 2) {
            UILabel *oneLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, CGRectGetMaxY(view3.frame)+WIDTH*0.15*i/2+(i-1)/2*1, WIDTH*0.4, WIDTH*0.15)];
            oneLabel3.text = nameArray1[i];
            oneLabel3.layer.borderColor = [UIColor whiteColor].CGColor;
            //   oneLabel3.backgroundColor = [UIColor redColor];
            oneLabel3.textAlignment = NSTextAlignmentLeft;
            [_scollerView addSubview:oneLabel3];
            
            if (i == 0) {
                UILabel *oneLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, CGRectGetMaxY(oneLabel3.frame), WIDTH*0.9, 1)];
                oneLabel4.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                [_scollerView addSubview:oneLabel4];
                
            }
        }
        if (i == 1 || i == 3) {
            UILabel *oneLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.55, CGRectGetMaxY(view3.frame)+WIDTH*0.15*(i-1)/2+(i-1)/2*1, WIDTH*0.4, WIDTH*0.15)];
            oneLabel3.text = nameArray1[i];
            oneLabel3.layer.borderColor = [UIColor whiteColor].CGColor;
            //  oneLabel3.backgroundColor = [UIColor redColor];
            oneLabel3.textAlignment = NSTextAlignmentRight;
            [_scollerView addSubview:oneLabel3];
            
            
            if (i == 1) {
                UILabel *oneLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH*0.05, CGRectGetMaxY(oneLabel3.frame), WIDTH*0.9, 1)];
                oneLabel4.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                [_scollerView addSubview:oneLabel4];
                
            }
        }
    }
}
//jietuButtonClick

-(void)jieTuButtonClick:(UIButton *)jieTuBtn {
       
        //创建UIImagePickerController对象，并设置代理和可编辑
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        
        //创建sheet提示框，提示选择相机还是相册
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //相机选项
        UIAlertAction * camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //选择相机时，设置UIImagePickerController对象相关属性
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
            imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            //跳转到UIImagePickerController控制器弹出相机
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        
        //相册选项
        UIAlertAction * photo = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //选择相册时，设置UIImagePickerController对象相关属性
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //跳转到UIImagePickerController控制器弹出相册
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        
        //取消按钮
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        //添加各个按钮事件
        [alert addAction:camera];
        [alert addAction:photo];
        [alert addAction:cancel];
        
        //弹出sheet提示框
        [self presentViewController:alert animated:YES completion:nil];
   
}
#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

#pragma mark - imagePickerController delegate

#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (_imageDataViewArray.count == 0) {
        _leftImageView.image = image;
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"left"];
    }
    if (_imageDataViewArray.count ==1) {
        _middleImageView.image = image;
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"middle"];
    }
    if(_imageDataViewArray.count == 2) {
        _rightImageView.image = image;
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"right"];
    }
    [_imageDataViewArray addObject:[info valueForKey:UIImagePickerControllerEditedImage]];
    
}
-(void)chunPic {
    
    
    // NSDictionary *postdict= @{@"orderid":[ZCUserData share].userId,@"username":[ZCUserData share].username,@"0":image1Base64,@"1":image2Base64,@"2":image3Base64};
    // 开始上传
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid",[ZCUserData share].username,@"username",_textView.text,@"text", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager POST:@"http://wx.leisurecarlease.com/api.php?op=api_feedback" parameters:postDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        UIImage *pic1 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"left"]];
        NSData *imageData1 = UIImageJPEGRepresentation(pic1, 0.5);
        // NSString *image1Base64 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        UIImage *pic2 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"middle"]];
        NSData *imageData2 = UIImageJPEGRepresentation(pic2, 0.5);
        // NSString *image2Base64 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        UIImage *pic3 = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"right"]];
        NSData *imageData3 = UIImageJPEGRepresentation(pic3, 0.5);
        // NSString *image3Base64 = [imageData3 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        if (imageData1 != nil && imageData2 != nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"left.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"middle.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"right.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 != nil && imageData2 == nil && imageData3 == nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"left.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 == nil && imageData2 != nil && imageData3 == nil) {
            
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"middle.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 == nil && imageData2 == nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"right.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 != nil && imageData2 != nil && imageData3 == nil) {
            
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"left.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"middle.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 == nil && imageData2 != nil && imageData3 != nil) {
            
            [formData appendPartWithFileData:imageData2 name:@"1" fileName:@"middle.jpg" mimeType:@"image/jpeg/png/jpg"];
            [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"right.jpg" mimeType:@"image/jpeg/png/jpg"];
        }else if (imageData1 != nil && imageData2 == nil && imageData3 != nil) {
            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"left.jpg" mimeType:@"image/jpeg/png/jpg"];
             [formData appendPartWithFileData:imageData3 name:@"2" fileName:@"right.jpg" mimeType:@"image/jpeg/png/jpg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"1");
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"left"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"middle"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"right"];
        
        //[self performSelector:@selector(stopit) withObject:dong afterDelay:2.0];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSLog(@"%@",error);
        
    }];
    [operation start];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",_scollerView.contentOffset.y);
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
