//
//  ErWeiMaView.m
//  ZuChe
//
//  Created by apple  on 2017/1/11.
//  Copyright © 2017年 佐途. All rights reserved.
//


#define Width  300.0   //正方形二维码的边长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ErWeiMaView.h"
#import <AVFoundation/AVFoundation.h>
#import "HttpManager.h"
#import "ZCUserData.h"
#import "WMUtil.h"


@interface ErWeiMaView ()<AVCaptureMetadataOutputObjectsDelegate>{
    
    CGFloat width;
    CGFloat height;
    
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_layer;
    AVCaptureDeviceInput *_input;
}

@end

@implementation ErWeiMaView

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白背景.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    [self create];
    [self setupMaskView];
    [self animation];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)create{
    
    NSLog(@"开始 扫描了。。。。。。。");
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //初始化链接对象
    _session = [[AVCaptureSession alloc] init];
    // 创建输入流
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    NSError *error = nil;
    if (_input) {
        
        [_session addInput:_input];
    }else{
        
        NSLog(@"error ------ %@",[error localizedDescription]);
    }
    
    // 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 设置代理， 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addOutput:output];
    //设置 扫码支付的编码格式 （下边设置条形码和二维码兼容）
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    
    // 相当于 找到 相机框的大小
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //设置相机扫描框的大小
    _layer.frame = self.view.layer.bounds;
//    CGRectMake(width*0.15, width*0.4, width*0.7, width*0.7)
    [self.view.layer insertSublayer:_layer atIndex:0];
    // 开始捕获
    [_session startRunning];
}
#pragma mark - 扫描二维码的delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    
    if (metadataObjects.count!= 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects[0];
        NSMutableArray *a1 = [NSMutableArray new];
        NSArray *a = [metadataObject.stringValue componentsSeparatedByString:@"id="];
        [a1 addObjectsFromArray:a];
        for ( int i = 0; i<a1.count; i++) {
            if ([a[i] isEqualToString:@""]) {
                [a1 removeObject:a[i]];
            }
        }
       
        if (a1.count == 0) {
            [WMUtil showTipsWithHUD:@"无效的二维码"];
        }else {
            NSString *s = a1.lastObject;
            NSLog(@"%@",s);
            
            NSDictionary *dict =@{@"userid":[ZCUserData share].userId,@"id":[_idString copy],@"gonglishu":[_gongliString copy]};
            
            if ([s isEqualToString:[_idString copy]]) {
                
                [HttpManager postData:dict andUrl:@"http://wx.leisurecarlease.com/tc.php?op=tijiaogonglishu" success:^(NSDictionary *fanhuicanshu) {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                } Error:^(NSString *cuowuxingxi) {
                     [WMUtil showTipsWithHUD:@"无效的二维码"];
                }];
                
            }else {
                [WMUtil showTipsWithHUD:@"无效的二维码"];
            }

        }
        
    }
   
//    NSString *string = metadataObjects.s
//    NSLog(@"delegate............................");
//    NSString *wwwCode = nil;
//    
//    for (AVMetadataObject *metadata in metadataObjects) {
//        
//        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
//            
//            wwwCode = [(AVMetadataMachineReadableCodeObject*)metadata stringValue];
//            break;
//        }
//    }
//    [_session stopRunning];

}
- (void)setupMaskView{
    
    //设置统一的视图颜色和视图的透明度
    UIColor *color = [UIColor blackColor];
    float alpha = 0.6;
    
    //设置扫描区域外部上部的视图
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 64, width, (height-64-width*0.8)/2.0-64);
    topView.backgroundColor = color;
    topView.alpha = alpha;
    
    //设置扫描区域外部左边的视图
    UIView *leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 64+topView.frame.size.height, (width-width*0.8)/2.0,width*0.8);
    leftView.backgroundColor = color;
    leftView.alpha = alpha;
    
    //设置扫描区域外部右边的视图
    UIView *rightView = [[UIView alloc]init];
    rightView.frame = CGRectMake((width-width*0.8)/2.0+width*0.8,64+topView.frame.size.height, (width-width*0.8)/2.0,width*0.8);
    rightView.backgroundColor = color;
    rightView.alpha = alpha;
    
    //设置扫描区域外部底部的视图
    UIView *botView = [[UIView alloc]init];
    botView.frame = CGRectMake(0, 64+width*0.8+topView.frame.size.height,width,height-64-width*0.8-topView.frame.size.height);
    botView.backgroundColor = color;
    botView.alpha = alpha;
    
    //将设置好的扫描二维码区域之外的视图添加到视图图层上
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:botView];
}
-(void)animation{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((width-width*0.8)/2.0, (height-width*0.8-64)/2.0, width*0.8, width*0.8)];
    
    imageView.image = [UIImage imageNamed:@"scanscanBg"];
    
    [self.view addSubview:imageView];
    
    
    UIImageView *animationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanLine"]];
    
    animationView.frame = CGRectMake(0,0, width*0.8, 10);
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath =@"transform.translation.y";
    
    animation.byValue = @(width*0.8-5);
    
    animation.removedOnCompletion = NO;
    
    animation.duration = 2.0;
    
    animation.repeatCount = MAXFLOAT;
    
    [animationView.layer addAnimation:animation forKey:nil];
    
    [imageView addSubview:animationView];
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
