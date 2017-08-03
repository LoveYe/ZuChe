//
//  YiWanChengView.m
//  ZuChe
//
//  Created by apple  on 2017/1/9.
//  Copyright © 2017年 佐途. All rights reserved.
//


#import "YiWanChengView.h"
#import "Header.h"
#import "WB_Stopwatch.h"
#import <AVFoundation/AVFoundation.h>
#import "ErWeiMaView.h"


@interface YiWanChengView ()<UITableViewDelegate,UITableViewDataSource,WB_StopWatchDelegate,AVCaptureMetadataOutputObjectsDelegate>{
    
    CGFloat width;
    UITableView *_tableVIew;
    WB_Stopwatch *_stopWatch;
    
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_layer;
    AVCaptureDeviceInput *_input;
}



@end



@implementation YiWanChengView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    // 设置白色的背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBar.translucent = YES;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    width = self.view.frame.size.width;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    left.frame = CGRectMake(0, 0, 25, 25);
    [left addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right setBackgroundImage:[UIImage imageNamed:@"Hi聊天"] forState:UIControlStateNormal];
    right.frame = CGRectMake(0, 0, 25, 25);
    [right addTarget:self action:@selector(liaotian) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self createTableView];
}
#pragma mark - navBar
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)liaotian{
    
    
}

#pragma mark - tableView
- (void)createTableView{
    
    _tableVIew = [[UITableView alloc] initWithFrame:CGRectMake(0 , 0, width, self.view.frame.size.height)];
    _tableVIew.delegate = self;
    _tableVIew.dataSource = self;
    
    _tableVIew.tableFooterView.frame = CGRectZero;
    
    [self.view addSubview:_tableVIew];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        return width*0.22;
    }
    else if (indexPath.row == 2) {
        
        return width *0.8;
    }
    else if (indexPath.row == 3){
        
        return width*0.2;
    }
    else
        return width*0.9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *strc = @"stack";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strc];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strc];
        
        if (indexPath.row == 0) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.3, width*0.1)];
            label.text = @"日期";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:25];
            label.textColor = [UIColor blackColor];
            [cell addSubview:label];
            
            UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, width*0.02, width*0.5, width*0.08)];
            zhou.text = @"周一, 10月10日";
            zhou.textColor = [UIColor grayColor];
            zhou.font = [UIFont systemFontOfSize:18];
            zhou.textAlignment = NSTextAlignmentRight;
            [cell addSubview:zhou];
            
            UILabel *shi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, CGRectGetMaxY(zhou.frame)+width*0.03, width*0.5, width*0.08)];
            shi.text = @"上午 9:30";
            shi.textColor = [UIColor grayColor];
            shi.textAlignment = NSTextAlignmentRight;
            shi.font = [UIFont systemFontOfSize:16];
            [cell addSubview:shi];
        }
        if (indexPath.row == 1) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.02, width*0.3, width*0.1)];
            label.text = @"联系";
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:25];
            label.textColor = [UIColor blackColor];
            [cell addSubview:label];
            
            UILabel *zhou = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, width*0.02, width*0.5, width*0.08)];
            zhou.text = @"15138841681";
            zhou.textColor = [UIColor grayColor];
            zhou.font = [UIFont systemFontOfSize:18];
            zhou.textAlignment = NSTextAlignmentRight;
            [cell addSubview:zhou];
            
            UILabel *shi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.45, CGRectGetMaxY(zhou.frame)+width*0.03, width*0.5, width*0.08)];
            shi.text = @"wei";
            shi.textColor = [UIColor grayColor];
            shi.textAlignment = NSTextAlignmentRight;
            shi.font = [UIFont systemFontOfSize:16];
            [cell addSubview:shi];
        }
        if (indexPath.row == 2) {
            
            UIView *image = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.9, width*0.5)];
            
            
            
            image.backgroundColor = [UIColor redColor];
            [cell addSubview:image];
            
            UILabel *dizhi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, CGRectGetMaxY(image.frame)+width*0.03, width*0.96, width*0.08)];
            dizhi.text = @"远东国际";
            dizhi.textColor = [UIColor grayColor];
            dizhi.textAlignment = NSTextAlignmentLeft;
            dizhi.font = [UIFont systemFontOfSize:13];
            [cell addSubview:dizhi];
        }
        if (indexPath.row == 3) {
            
            UILabel *shouyi = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.3, width*0.08)];
            shouyi.text = @"收益";
            shouyi.textColor = [UIColor grayColor];
            shouyi.textAlignment = NSTextAlignmentLeft;
            shouyi.font = [UIFont systemFontOfSize:20];
            [cell addSubview:shouyi];
            
            UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(width*0.8, width*0.05, width*0.15, width*0.08)];
            qian.textAlignment = NSTextAlignmentRight;
            qian.text = @"¥800";
            qian.textColor = Color(255, 70, 30);
            qian.font = [UIFont systemFontOfSize:16];
            [cell addSubview:qian];
        }
        if (indexPath.row == 4) {
            
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*0.38, width*0.05, width*0.35, width*0.35)];
            
            image1.image = [UIImage imageNamed:@"找车@3x.png"];
            [cell addSubview:image1];
            
            UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+width*0.03, width*0.05, width*0.35, width*0.35)];
            image2.image = [UIImage imageNamed:@"找车@3x.png"];
            [cell addSubview:image2];
            
            _stopWatch = [[WB_Stopwatch alloc] initWithLabel:_stopWatch andTimerType:WBTypeTimer];
            _stopWatch.frame = CGRectMake(width/2-width*0.33, width*0.08, width*0.2, width*0.2);
            _stopWatch.delegate = self;
            _stopWatch.textColor = Color(255, 70, 90);
            _stopWatch.textAlignment = NSTextAlignmentCenter;
            [_stopWatch setTimeFormat:@"mm:ss"];
            // ************************ 时间是后台获取的 ***********************************
            [_stopWatch setCountDownTime:900];
            [_stopWatch start];
            [cell addSubview:_stopWatch];
            
            UILabel *licheng = [[UILabel alloc] initWithFrame:CGRectMake(width/2+width*0.05, width*0.05, width*0.1, width*0.1)];
            licheng.text = @"45.5";
            licheng.textColor = [UIColor redColor];
            licheng.textAlignment = NSTextAlignmentCenter;
            licheng.font = [UIFont systemFontOfSize:18];
            [cell addSubview:licheng];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image1.frame)+width*0.08, width, width*0.08)];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = [UIColor redColor];
            label1.font = [UIFont systemFontOfSize:18];
            label1.text = @"以实际车辆记录里程为准";
            [cell addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), width, width*0.1)];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.textColor = [UIColor redColor];
            label2.font = [UIFont systemFontOfSize:18];
            label2.text = @"请在服务结束时扫描租客二维码";
            [cell addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame), width, width*0.08)];
            label3.textAlignment = NSTextAlignmentCenter;
            label3.textColor = [UIColor redColor];
            label3.font = [UIFont systemFontOfSize:18];
            label3.text = @"超时超公里费用请与租客现场结算";
            [cell addSubview:label3];
            
            UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
            jieshu.frame = CGRectMake(width*0.2, CGRectGetMaxY(label3.frame)+width*0.02, width*0.6, width*0.08);
            jieshu.backgroundColor = Color(0, 215, 200);
            [jieshu setTitle:@"扫码并结束" forState:UIControlStateNormal];
            [jieshu setTintColor:[UIColor whiteColor]];
            [jieshu addTarget:self action:@selector(saomaEnd:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:jieshu];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - 开始设置扫描二维码
- (void)saomaEnd:(UIButton *)sender{
    
    
    ErWeiMaView *view = [ErWeiMaView new];
    
    [self.navigationController pushViewController:view animated:YES];
    
    //先进行授权获取相机
//    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    switch (author) {
//            
//        case AVAuthorizationStatusNotDetermined:{
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                
//                if (granted) {
//                    [self kaishi];
//                }else{
//                    
//                    NSLog(@"访问受限");
//                }
//            }];
//            break;
//        }
//        case AVAuthorizationStatusRestricted:
//        case AVAuthorizationStatusDenied:{
//            NSLog(@"访问受限");
//            break;
//        }
//        case AVAuthorizationStatusAuthorized:{
//            
//            // 获取到权限
//            [self kaishi];
//            
//            break;
//        }
//            
//        default:
//            break;
//    }
    
}
//- (void)kaishi{
//    
//    NSLog(@"开始 扫描了。。。。。。。");
//    //获取摄像设备
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    //初始化链接对象
//    _session = [[AVCaptureSession alloc] init];
//    // 创建输入流
////    _input = [[AVCaptureDeviceInput alloc] init];
//    _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
//    
//    NSError *error = nil;
//    if (_input) {
//        
//        [_session addInput:_input];
//    }else{
//        
//        NSLog(@"error ------ %@",[error localizedDescription]);
//    }
//    
//    // 创建输出流
//    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
//    // 设置代理， 在主线程里刷新
//    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    // 高质量采集率
//    [_session setSessionPreset:AVCaptureSessionPresetHigh];
//    [_session addOutput:output];
//    //设置 扫码支付的编码格式 （下边设置条形码和二维码兼容）
//    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
//    
//    // 相当于 找到 相机框的大小
//    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
//    
//    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    //设置相机扫描框的大小
//    _layer.frame = CGRectMake(width*0.15, width*0.4, width*0.7, width*0.7);
//    [self.view.layer insertSublayer:_layer atIndex:0];
//    // 开始捕获
//    [_session startRunning];
//}
//
//#pragma mark - 扫描二维码的delegate
//-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    
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
//    [self.navigationController popViewControllerAnimated:NO];
//}





















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
