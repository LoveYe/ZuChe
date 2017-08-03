//
//  TijiaopingjiaViewController.m
//  ZuChe
//
//  Created by J.X.Y on 16/1/19.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "TijiaopingjiaViewController.h"
#import "AllPages.pch"
#import "UILabel+SizeLabel.h"
#import "UIImageView+WebCache.h"
#import "RatingBar.h"
#import "ZLPhoto.h"
#import "CarInfo.h"
#import "MyButton.h"


@interface TijiaopingjiaViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UITextViewDelegate,ZLPhotoPickerViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD *HUD;
    float myWidth;
    float myWidth1;
    
    UITextView *_textView;
    NSMutableArray *imageArray;
    NSMutableArray *buttonArray;
    NSDictionary *arrlist;
    float one1;
    float two1;
    float thr1;
    UILabel*label;
    NSMutableDictionary * PICTUPIAN;
    MyButton * btn;
}

@property (nonatomic,retain)UIImage *image;
@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic , strong) NSMutableArray *assets;
@property (nonatomic,retain)NSMutableArray *listarray;
@property (nonatomic,retain)UITableView *tableview;
@property(nonatomic,retain)ZLPhotoAssets *asss;

@end

@implementation TijiaopingjiaViewController
- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    PICTUPIAN = [NSMutableDictionary dictionary];
    [self addTitleViewWithTitle:[NSString stringWithFormat:@"%@",self.dingdanhaoID]];
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50,30)];
    [rightbutton setTitle:@"提交" forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(sousuobtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addItemWithCustomView:@[rightbutton] isLeft:NO];
    
    if (!imageArray)
    {
        imageArray =[NSMutableArray array];
        
    }
    if (!buttonArray)
    {
        buttonArray =[NSMutableArray array];
        
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.removeFromSuperViewOnHide=YES;
    HUD.labelText = @"正在加载数据...";
    [HUD showAnimated:YES whileExecutingBlock:^{
        [self postURL];
        sleep(0.5);
    }completionBlock:^{
        
    }];
}
-(void)postURL
{
    arrlist=[NSDictionary dictionary];
    _listarray=[NSMutableArray array];
    NSDictionary *postData=[NSDictionary dictionaryWithObjectsAndKeys:
                            self.orderid,@"orderid", nil];
    [HttpManager postData:postData andUrl:PINGJIEYE success:^(NSDictionary *fanhuicanshu) {
        if ([[fanhuicanshu objectForKey:@"carinfo"] isKindOfClass:[NSArray class]]) {
            NSLog(@"1");
            arrlist=fanhuicanshu;
            NSArray * tempArr = [arrlist objectForKey:@"carinfo"];
            for (int i =0; i<tempArr.count; i++)
            {
                NSDictionary * dic = tempArr[i];
                CarInfo * info = [CarInfo paramWithDictionary:dic];
                [_listarray addObject:info];
            }
            
            [self Tableview];
        }else
        {
            NSLog(@"2");
        }
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height(64)) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listarray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(330);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Height(10);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"tijiaoview";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        
        
    }for (UIView *subviews in cell.contentView.subviews) {
        [subviews removeFromSuperview];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSLog(@"indexpath.row 哈哈%ld",(long)indexPath.section);
    CarInfo * info = _listarray[indexPath.section];
    //车图片
    UIColor *shenghuicolor=Color(32, 32, 32)//灰字
    UIImageView *thumbs=[MyUtil createImageViewFrame:CGRectMake(Height(10), Height(10), Height(70), Height(45)) imageName:nil];
    [thumbs sd_setImageWithURL:[NSURL URLWithString:info.thumb]];
    [cell.contentView addSubview:thumbs];
    //车名字
    UILabel*name =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth*0.382, ScreenWidth*0.04, ScreenWidth*0.3, ScreenWidth*0.06)];
    [self label:name isBold:YES isFont:13];
    name.text =info.models;
    myWidth =[UILabel width:name.text heightOfFatherView:name.frame.size.height textFont: name.font];
    name.frame= CGRectMake(Height(90),Height(10), myWidth+2, Height(16));    //车牌
    [cell.contentView addSubview:name];
    //车牌
    
    UILabel*chepai =[[UILabel alloc]initWithFrame: CGRectMake(Height(100)+myWidth,Height(12), ScreenWidth*0.06, ScreenWidth*0.04)];
    chepai.backgroundColor =Color(0, 170, 238);
    chepai.textColor =[UIColor whiteColor];
    chepai.font=Font(11);
    chepai.text = info.plate;
    myWidth1 =[UILabel width:chepai.text heightOfFatherView:chepai.frame.size.height textFont:chepai.font];
    chepai.frame= CGRectMake(Height(100)+myWidth,Height(12),myWidth1+2, ScreenWidth*0.04);
    chepai.textAlignment =NSTextAlignmentCenter;
    [cell.contentView addSubview:chepai];
    //公里钱
    UILabel *money=[MyUtil createLabelFrame:CGRectMake(Height(90), Height(39), Height(100), Height(16)) title:[NSString stringWithFormat:@"%@/%@",info.carmoneyone,info.cargonglione] textAlignment:NSTextAlignmentLeft font:Font(13) color:shenghuicolor];
    [cell.contentView addSubview:money];
    
    //打分
    UIColor *heicolor=[UIColor blackColor];
    UILabel *sudu=[MyUtil createLabelFrame:CGRectMake(Height(20), Height(70),Height(90), 20) title:@"服务指数：" textAlignment:NSTextAlignmentLeft font:Font(13) color:heicolor];
    [cell.contentView addSubview:sudu];
    UILabel *fuwu=[MyUtil createLabelFrame:CGRectMake(Height(20),Height(100),Height(90), 20) title:@"车况指数：" textAlignment:NSTextAlignmentLeft font:Font(13) color:heicolor];
    [cell.contentView addSubview:fuwu];
    UILabel *chanpin=[MyUtil createLabelFrame:CGRectMake(Height(20), Height(130), Height(90), 20) title:@"守时指数：" textAlignment:NSTextAlignmentLeft font:Font(13) color:heicolor];
    [cell.contentView addSubview:chanpin];
    [self label:sudu isBold:YES isFont:13];
    [self label:fuwu isBold:YES isFont:13];
    [self label:chanpin isBold:YES isFont:13];
    //线
    UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(Height(10), Height(160), ScreenWidth-Height(20), 0.3)];
    xian.backgroundColor=shenghuicolor;
    [cell.contentView addSubview:xian];
    
    
#pragma mark-打分处
    
    
    RatingBar *  bar1 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenWidth-200, Height(65), 180, 30)];
    bar1.tag =1000;
    [cell.contentView addSubview:bar1];
    RatingBar * bar2 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenWidth-200, Height(65)+30, 180, 30)];
    bar2.tag = 2000;
    [cell.contentView addSubview:bar2];
    RatingBar * bar3 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenWidth-200, Height(65)+60, 180, 30)];
    bar3.tag =3000;
    [cell.contentView addSubview:bar3];
    
    
    
    bar1.starNumber = [[info.pingjia objectForKey:@"fuwu"] integerValue];
    
    bar2.starNumber = [[info.pingjia objectForKey:@"chekuang"] integerValue];
    
    bar3.starNumber = [[info.pingjia objectForKey:@"shoushi"] integerValue];
    
    
    
    __weak  TijiaopingjiaViewController *weakSelf = self;
    bar1.buttonClickedOperationBlock=^(NSInteger index){
        NSLog(@"第1个星星:%ld",index);
        one1=index;
        
        CarInfo * info =weakSelf.listarray [indexPath.section];
        [info.pingjia setObject:[NSString stringWithFormat:@"%ld",(long)index] forKey:@"fuwu"];
    };
    bar2.buttonClickedOperationBlock=^(NSInteger index){
        NSLog(@"第2个星星:%ld",index);
        two1=index;
        CarInfo * info =weakSelf.listarray [indexPath.section];
        [info.pingjia setObject:[NSString stringWithFormat:@"%ld",(long)index] forKey:@"chekuang"];
    };
    bar3.buttonClickedOperationBlock=^(NSInteger index){
        NSLog(@"第3个星星:%ld",index);
        thr1=index;
        CarInfo * info =weakSelf.listarray [indexPath.section];
        [info.pingjia setObject:[NSString stringWithFormat:@"%ld",(long)index] forKey:@"shoushi"];
    };
    
#pragma mark--添加图片
    UIScrollView * scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0,Height(170),ScreenWidth,Height(65))];
    scroll.bounces=NO;
    scroll.scrollEnabled=NO;
    scroll.contentSize =CGSizeMake(ScreenWidth*2, ScreenWidth*0.18);
    [cell.contentView addSubview:scroll];
    MyButton * camera =[MyButton buttonWithType:UIButtonTypeCustom];
    camera.frame =CGRectMake(Height(5),Height(5),Height(60),Height(60));
    camera.tag=indexPath.section;
    [camera setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [camera setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [camera addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    camera.scrollView = scroll;
    camera.cell = cell;
    
    
    [scroll addSubview:camera];
    
#pragma mark-填写信息
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(Height(10), Height(240), ScreenWidth-Height(20), Height(80))];
    _textView.delegate=self;
    _textView.font=Font(13);
    _textView.layer.borderWidth=0.5;
    _textView.layer.masksToBounds =YES;
    _textView.layer.cornerRadius =6.0f;
    _textView.clearsContextBeforeDrawing= YES;
    [cell.contentView addSubview:_textView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(Height(20),  Height(240), ScreenWidth-2*Height(20), ScreenWidth/6)];
    label.enabled = NO;
    label.text = @"你若有什么想要对我们说的话，都可以在这里留言...";
    label.numberOfLines =0;
    label.font =Font(13);
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = Color(50, 50, 50);
    [cell.contentView addSubview:label];
    
    return cell;
}
- (void) textViewDidChange:(UITextView *)textView{
    
    
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
        
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textView isExclusiveTouch]) {
        [_textView resignFirstResponder];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ((textView.text.length - range.length + text.length) > 300)
    {
        NSString *substring = [text substringToIndex:300 - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.editing=YES;
}

#pragma mark--调用相机还是相册
-(void)chooseBtnClick:(MyButton *)button{
    
    btn = button;
    NSLog(@"相机eee＝%ld",btn.tag);
    UIActionSheet*myActionSheet = [[UIActionSheet alloc]
                                   initWithTitle:nil
                                   delegate:self
                                   cancelButtonTitle:@"取消"
                                   destructiveButtonTitle:nil
                                   otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    ;
    [myActionSheet showInView:self.view];
}
#pragma mark--actionSheet选择调用相机还是相册
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://照相机
        {
            [self takePhoto:actionSheet.tag];
        }
            break;
        case 1://本地相簿
        {
            [self LocalPhoto:actionSheet.tag];
        }
            break;
            
        default:
            break;
    }
}
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(20,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(20,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
#pragma mark--调用相册

-(void)LocalPhoto:(NSInteger)tag
{
    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.index=tag;
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.selectPickers = self.assets;
    // 最多能选4张图片
    pickerVc.maxCount = 4;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
    /**
     *
     传值可以用代理，或者用block来接收，以下是block的传值
     __weak typeof(self) weakSelf = self;
     pickerVc.callBack = ^(NSArray *assets){
     weakSelf.assets = assets;
     [weakSelf.tableView reloadData];
     };
     */
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
}
#pragma mark--调用相机
-(void)takePhoto:(NSInteger)tag
{
    NSLog(@"相机rrrrrr＝%ld",(long)tag);
    if (self.arr.count>=4)
    {
        return;
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    
    [self presentViewController:picker animated:YES completion:nil];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.image= [info objectForKey:UIImagePickerControllerEditedImage];
    [self.arr addObject:[self fixOrientation:self.image]];
    [self createScroll:[NSArray arrayWithObject:[self fixOrientation:self.image]]];
    
}

- (void)createScroll:(NSArray*)array
{
    
    //    for ( UIImageView *imageView in btn.scrollView.subviews)
    //    {
    //
    //
    //        [imageView removeFromSuperview];
    //
    //    }
    //    if (array.count==0)
    //    {
    //        btn.frame=CGRectMake(Height(10), 6, ScreenWidth*0.19, ScreenWidth*0.19);
    //    }
    
    //    else
    //    {
    
    for (int i = 0; i < array.count; i++)
    {
        
        ZLPhotoAssets * asset  = array[i];
        
        UIImageView *imageViewss;
        
        imageViewss = [[UIImageView alloc]initWithFrame:CGRectMake((4+ScreenWidth*0.19)*i, 6, ScreenWidth*0.19, ScreenWidth*0.19)];
        
        imageViewss.image = asset.originImage;
        imageViewss.tag = i;
        [btn.scrollView addSubview:imageViewss];
        
        [imageArray addObject:imageViewss];
        NSString *key=[NSString stringWithFormat:@"tupic%ld",(long)btn.tag];
        
        
        [PICTUPIAN setObject:imageArray forKey:key];
        NSLog(@"新生 数组个数%@",imageArray);
        
        
        //            UIButton * button =[UIButton buttonWithType: UIButtonTypeSystem];
        //
        //            button.frame =CGRectMake(((4+ScreenWidth*0.19)*i)+(ScreenWidth*0.19-ScreenWidth*0.09)+Height(4), 0, ScreenWidth*0.09, ScreenWidth*0.09);
        //
        //            [button setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        //            button.tag = i;
        //
        //            [button  addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //            [btn addSubview:button];
        //            [buttonArray addObject:button];
        
        NSLog(@"jsjsjsj%@",self.arr);
        
        
        
        btn.frame=CGRectMake(4*self.arr.count+(ScreenWidth*0.19*array.count ), 6, ScreenWidth*0.19, ScreenWidth*0.19);
        
        
    }
    //    }
    
    btn.scrollView.contentSize=CGSizeMake(4*(self.arr.count+1)+(ScreenWidth*0.19*(self.arr.count+1 )), ScreenWidth*0.19);
}


-(void)removeBtnClick:(UIButton *)button
{
    
    [self.arr removeObjectAtIndex:button.tag];
    //[self createScroll];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)sousuobtn:(UIButton *)sender
{
    NSString *carid=[[NSString alloc]init];
    
    
    
    
    for (int i=0; i<_listarray.count; i++) {
        NSString *czuserid=[NSString stringWithFormat:@"%@",[[arrlist objectForKey:@"carinfo"][i]  objectForKey:@"czuserid"]];
        
        CarInfo * info = _listarray[i];
        NSString *onestr=[NSString stringWithFormat:@"%ld",[[info.pingjia objectForKey:@"fuwu"] integerValue]];
        NSString *twostr=[NSString stringWithFormat:@"%ld",[[info.pingjia objectForKey:@"chekuang"] integerValue]] ;
        NSString *thrstr=[NSString stringWithFormat:@"%ld",[[info.pingjia objectForKey:@"shoushi"] integerValue]];
        NSString *key=[NSString stringWithFormat:@"tupic%d",i];
        NSMutableArray *tupic=[PICTUPIAN valueForKey:key];
        
        
        carid=[NSString stringWithFormat:@"%@",info.carid];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  self.orderid,@"orderid",
                                  [ZCUserData share].userId,@"userid",
                                  czuserid,@"czuserid",
                                  carid,@"carid",
                                  onestr,@"fuwuxing",
                                  twostr,@"chexing",
                                  thrstr,@"shouxing",
                                  _textView.text,@"content",
                                  [NSString stringWithFormat:@"%ld",tupic.count],@"thumb",nil];
        __weak TijiaopingjiaViewController *vc=self;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFHTTPRequestOperation *operation = [manager POST:TIJIAOPINGJIEYE parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
            NSLog(@"图片个数：%lu",(unsigned long)tupic.count);
            
            for (int i=0;i<tupic.count;i++)
            {
                NSLog(@"%@",tupic[i]);
                
                NSString *name =[NSString stringWithFormat:@"thumb%d.jpg",i];
                
                NSLog(@"%@",tupic[i]);
                UIImageView *imageview=tupic[i];
                
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(imageview.image, 0.4) name:[NSString stringWithFormat:@"%d",i] fileName:name mimeType:@"image/jpeg"];
                
            }
            
            
        }success:^(AFHTTPRequestOperation *operation, id responseObject)
                                             
                                             {
                                                 
                                                 [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                                                 
                                                 [vc xiaojiadeTishiTitle:@"评价成功"];
                                                 
                                                 [self.navigationController popToRootViewControllerAnimated:YES];
                                                 
                                             }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                 
                                                 [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                                                 
                                                 [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",error]];
                                             }];
        
        [operation start];
        
        
    }
    
}


-(void)pickerViewControllerDoneAsstes:(NSArray *)assets
{
    [self createScroll:assets];
}
@end
