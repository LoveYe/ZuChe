//
//  DetailsCarXclTableViewCell.m
//  ZuChe
//
//  Created by home on 2017/3/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "TousuTableViewCell.h"
#import "Header.h"
#import "AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "WMUtil.h"
#import "TouSuAddImageViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@implementation TousuTableViewCell {
    
    UIImageView *_leftImageView;
    UILabel *_nameAndCarIdLabel;
   // UILabel *_rightStateLabel;
    UIButton *_stateButton;
    
    //__block UILabel *_scoreLabel;
    WSStarRatingView *_wsStraRating;
    UIView *_gayView;
    UIView *bigView;
    UITextView *_textView;
    
    NSMutableArray *_imageDataView;
    TouSuAddImageViewController *_tousuView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customView];
    }
    return self;
}
-(void)customView {
    
    _imageDataView = [NSMutableArray new];
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    
    _nameAndCarIdLabel = [UILabel new];
    [self.contentView addSubview:_nameAndCarIdLabel];
//    
//    _rightStateLabel = [UILabel new];
//    [self.contentView addSubview:_rightStateLabel];
//    
    _stateButton = [UIButton new];
    [self.contentView addSubview: _stateButton];
    
    _wsStraRating = [[WSStarRatingView alloc] initWithFrame:CGRectMake(0.13*ScreenHeight+0.04*ScreenHeight-0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight) numberOfStar:5];
    [self.contentView addSubview:_wsStraRating];
    
    _scoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_scoreLabel];
    
    _gayView = [UIView new];
    [self.contentView addSubview:_gayView];
}
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    [self viewStateSet];
}

-(void)setPlane_name:(NSDictionary *)plane_name {
    _plane_name  = plane_name;
    
    if([_plane_name[@"cartu"] isKindOfClass:[NSNull class]]){
        _leftImageView.image = [UIImage imageNamed:@"玛莎拉蒂.jpg"];
    }else {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_plane_name[@"cartu"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    _nameAndCarIdLabel.text = [NSString stringWithFormat:@"%@",_plane_name[@"plate_name"]];
    _nameAndCarIdLabel.textColor = Color(140, 140, 140);
    _nameAndCarIdLabel.adjustsFontSizeToFitWidth = YES;
    _nameAndCarIdLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
//    if ([_plane_name[@"state"] isEqualToString:@"已迟到"] || [_plane_name[@"state"] isEqualToString:@"已到达"] || [_plane_name[@"state"] isEqualToString:@"服务中"] ) {
//        _rightStateLabel.textColor = Color(227, 87, 117);
//    }else {
//        _rightStateLabel.textColor = Color(7, 187, 177);
//    }
//
//    
//    _rightStateLabel.text = [NSString stringWithFormat:@"%@",_plane_name[@"state"]];
//    _rightStateLabel.textAlignment = NSTextAlignmentCenter;
//    _rightStateLabel.adjustsFontSizeToFitWidth = YES;
    //  _rightStateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    
}
-(void)viewStateSet {
    
    [_stateButton addTarget:self action:@selector(tousuButton:) forControlEvents:UIControlEventTouchUpInside];
    [_stateButton setTitleColor:[UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal] ;
    [_stateButton setTitle:@"投诉" forState:UIControlStateNormal];
    _stateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _stateButton.layer.borderWidth = 1.3;
    _stateButton.layer.borderColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:101/255.0 alpha:1].CGColor;
    _scoreLabel.textColor = Color(170, 170, 170);
    _scoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    
    _wsStraRating.delegate = self;
    
    __block TousuTableViewCell *detaCell = self;
    
    [_wsStraRating setScore:1.0 withAnimation:YES completion:^(BOOL finished) {
        detaCell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f",1.0 * 5 ];
    }];
    _gayView.backgroundColor = Color(233, 233, 233);
    
}
//- (void)starRatingView:(WSStarRatingView *)view score:(float)score
//{
//    _scoreLabel.text = [NSString stringWithFormat:@"%0.1f",score * 5 ];
//
//}

//0.13*screeHeight

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _leftImageView.frame = CGRectMake(0, 0.02*ScreenHeight, 0.13*ScreenHeight, 0.09*ScreenHeight);
    // _leftImageView.backgroundColor = [UIColor blackColor];
    
    _nameAndCarIdLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.01*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
    //_nameAndCarIdLabel.backgroundColor = [UIColor greenColor];
    _nameAndCarIdLabel.font = [UIFont systemFontOfSize:13];
    
//    _rightStateLabel.frame = CGRectMake(0.7*ScreenWidth, 0.01*ScreenHeight, 0.2*ScreenWidth, 0.05*ScreenHeight);
//    //  _rightStateLabel.backgroundColor = [UIColor greenColor];
//    _rightStateLabel.font = [UIFont systemFontOfSize:13];
//    
    _stateButton.frame = CGRectMake(0.8*ScreenWidth-0.05*ScreenHeight, 0.04*ScreenHeight, 0.05*ScreenHeight, 0.05*ScreenHeight);
    // _stateButton.backgroundColor = [UIColor purpleColor];
    _stateButton.layer.cornerRadius = 0.025*ScreenHeight;
    
    _wsStraRating.frame = CGRectMake(0.13*ScreenHeight+0.04*ScreenHeight-0.02*ScreenHeight, 0.09*ScreenHeight, 0.085*ScreenHeight, 0.02*ScreenHeight);
    
    _scoreLabel.frame = CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, 0.09*ScreenHeight, 0.1*ScreenHeight, 0.02*ScreenHeight);
    //_wsStraRating.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+0.02*ScreenHeight, 0.07*ScreenHeight, 0.2*ScreenHeight, 0.05*ScreenHeight);
    _gayView.frame = CGRectMake(0, 0.13*ScreenHeight, 0.9*ScreenWidth, 1);
    
}
-(void)tousuButton:(UIButton *)butto {
    
    
    NSLog(@"我让你打电话啊");
 
    if (_delgete && [_delgete respondsToSelector:@selector(imageButtonClick:AndchePai:)]) {
        
        [_delgete imageButtonClick:_dict AndchePai:_plane_name];
    }
   
}

//- (void)AlertView{
//    
//    
//    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    bigView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
//    bigView.tag = 1000;
//    [self.window addSubview:bigView];
//    
//    UIView *_alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, 64, ScreenWidth*0.9, ScreenWidth*0.8+20+80+ScreenWidth*0.8/4*2/3)];
//    _alertView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
//    _alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
//    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
//        _alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    } completion:^(BOOL finished) {
//        
//    }];
//    _alertView.tag =12312;
//    [bigView addSubview:_alertView];
//    
//    //
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth*0.9, 60)];
//    label.text = @"投诉内容";
//    label.adjustsFontSizeToFitWidth = YES;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1];
//    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    [_alertView addSubview:label];
////    
////    
////    UIButton  *dHx = [UIButton buttonWithType:UIButtonTypeCustom];
////    dHx.frame = CGRectMake(ScreenWidth*0.9-10-44,10, 44, 44);
////    [dHx addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
////    [dHx setBackgroundImage:[[UIImage imageNamed:@"错灰(2).png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
////    [_alertView addSubview:dHx];
////    
////
////    
////    __block TousuTableViewCell *selfCell = self;
////    
//    _textView = [[UITextView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, 80, ScreenWidth*0.8,ScreenWidth*0.5)];
//    _textView.textColor=[UIColor lightGrayColor];//设置提示内容颜色
//    _textView.text=NSLocalizedString(@"点击输入您的投诉", nil);//提示语
//    [_textView selectedRange] ;
//    _textView.selectedRange=NSMakeRange(0,0) ;//光标起始位置
//    _textView.delegate = self;
//    _textView.backgroundColor = [UIColor grayColor];
//    _textView.font = [UIFont systemFontOfSize:15];
//    _textView.tintColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
//    [_alertView addSubview:_textView];
//    
//    
//    UIButton *jieshu = [UIButton buttonWithType:UIButtonTypeCustom];
//    jieshu.frame = CGRectMake(0, ScreenWidth*0.5+20+80, ScreenWidth*0.8/4,ScreenWidth*0.8/4*2/3);
//    // jieshu.backgroundColor = Color(7, 187, 177);
//    jieshu.tag = 123456;
//    [jieshu setBackgroundImage:[UIImage imageNamed:@"加图(1).png"] forState:UIControlStateNormal];
//    [jieshu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [jieshu setTintColor:[UIColor whiteColor]];
//    [jieshu addTarget:self action:@selector(tianjiatupian:) forControlEvents:UIControlEventTouchUpInside];
//    [_alertView addSubview:jieshu];
//
//    
//    //
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.5+20+80+ScreenWidth*0.8/4*2/3, ScreenWidth*0.9, ScreenWidth*0.15)];
//    label1.text = @"您的投诉将在一小时内处理";
//    label1.adjustsFontSizeToFitWidth = YES;
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.textColor = [UIColor redColor];
//    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//    
//    [_alertView addSubview:label1];
//
//    
//    
//    UIButton  *queding = [UIButton buttonWithType:UIButtonTypeCustom];
//    queding.frame = CGRectMake(ScreenWidth*0.05, ScreenWidth*0.65+20+80+ScreenWidth*0.8/4*2/3, ScreenWidth*0.375, ScreenWidth*0.1);
//    [queding setTitle:@"确定提交" forState:UIControlStateNormal];
//    [queding addTarget:self action:@selector(tiButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIColor *gary = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1];
//    //    queding.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
//    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    queding.backgroundColor = gary;
//    [_alertView addSubview:queding];
//    
//    
//    
//    UIButton  *wZxx = [UIButton buttonWithType:UIButtonTypeCustom];
//     wZxx.frame = CGRectMake(ScreenWidth*0.475, ScreenWidth*0.65+20+80+ScreenWidth*0.8/4*2/3, ScreenWidth*0.375, ScreenWidth*0.1);
//    [wZxx setTitle:@"我再想想" forState:UIControlStateNormal];
//    [wZxx addTarget:self action:@selector(moveAll) forControlEvents:UIControlEventTouchUpInside];
//    UIColor *color = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
//    [wZxx setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    wZxx.backgroundColor = color;
//    [_alertView addSubview:wZxx];
//}
//#define mark TextViewDelegate  ------
//
//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
//    if (textView.textColor==[UIColor lightGrayColor])//如果是提示内容，光标放置开始位置
//    {
//        NSRange range;
//        range.location = 0;
//        range.length = 0;
//        textView.selectedRange = range;
//    }
//}
//
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
//{
//    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
//    {
//        textView.text=@"";//置空
//        textView.textColor=[UIColor blackColor];
//    }
//    
//    if ([text isEqualToString:@"\n"])//回车事件
//    {
//        if ([textView.text isEqualToString:@""])//如果直接回车，显示提示内容
//        {
//            textView.textColor=[UIColor lightGrayColor];
//            textView.text=NSLocalizedString(@"点击输入您的投诉", nil);
//        }
//        [textView resignFirstResponder];//隐藏键盘
//        return NO;
//    }
//    return YES;
//}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@""])
//    {
//        textView.textColor=[UIColor lightGrayColor];
//        textView.text=NSLocalizedString(@"点击输入您的投诉", nil);
//    }
//}
//
//-(void)tiButton:(UIButton *)tijiao {
//    
//    UIImage *pic1;
//    
//    if([_plane_name[@"cartu"] isKindOfClass:[NSNull class]]){
//        
//        pic1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]]];
//        
//    }else {
//        pic1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",_plane_name[@"cartu"]]]]];
//    }
//    NSData *imageData1 = UIImageJPEGRepresentation(pic1, 0.5);
//    NSString *image1Base64 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//
//    NSDictionary *postdict= [NSDictionary dictionaryWithObjectsAndKeys:_plane_name[@"plate_name"],@"plate",_textView.text,@"text",_dict[@"state"][@"id"],@"indentid",image1Base64,@"1" ,nil];
//        // 开始上传
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//        AFHTTPRequestOperation *operation = [manager POST:@"http://wx.leisurecarlease.com/api.php?op=api_complain" parameters:postdict constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
//    
//            [formData appendPartWithFileData:imageData1 name:@"0" fileName:@"pic1.jpg" mimeType:@"image/jpeg/png/jpg"];
//        } success:^(AFHTTPRequestOperation *operation, id responseObject){
//    
//            NSLog(@"1");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [WMUtil showTipsWithHUD:@"提交成功"];
//                 [bigView removeFromSuperview];
//            });
//        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//            
//            NSLog(@"%@",error);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [WMUtil showTipsWithHUD:@"提交失败"];
//                [bigView removeFromSuperview];
//            });
//        }];
//        [operation start];
//    
//}
//
//- (void)moveAll{
//    
//    [bigView removeFromSuperview];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *responder = [next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

//-(void)tianjiatupian:(UIButton*)button {
//    
//    
//    //创建UIImagePickerController对象，并设置代理和可编辑
//    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.editing = YES;
//    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
//    
//    //创建sheet提示框，提示选择相机还是相册
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    //相机选项
//    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        //选择相机时，设置UIImagePickerController对象相关属性
//        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
//        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
//        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
//        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        //跳转到UIImagePickerController控制器弹出相机
//        [[self viewController] presentViewController:imagePicker animated:YES completion:nil];
//    }];
//    
//    //相册选项
//    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        //选择相册时，设置UIImagePickerController对象相关属性
//        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        //跳转到UIImagePickerController控制器弹出相册
//        [[self viewController] presentViewController:imagePicker animated:YES completion:nil];
//    }];
//    
//    //取消按钮
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//        [[self viewController] dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    //添加各个按钮事件
//    [alert addAction:camera];
//    [alert addAction:photo];
//    [alert addAction:cancel];
//    
//    //弹出sheet提示框
//    [[self viewController] presentViewController:alert animated:YES completion:nil];
//    
//    
//    NSLog(@"%@",_imageDataView);
//    
//}
//#pragma mark - imagePickerController delegate
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    
//    CGFloat width = ScreenWidth;
//
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    
//    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
//    
//    
//    if (_imageDataView.count == 0) {
//        
//        UIView *view = (UIView *)[self viewWithTag:12312];
//        UIButton *button = (UIButton *)[view viewWithTag:123456];
//        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,width*0.13,width*0.9/4, width*0.9/4*2/3)];
//        leftImageView.image = image;
//        [view addSubview:leftImageView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"love"];
//        
//        button.frame = CGRectMake(width*0.8/4,width*0.13,width*0.8/4, width*0.8/4*2/3);
//        
//    }
//    if (_imageDataView.count == 1) {
//        
//        UIView *view = (UIView *)[self viewWithTag:12312];
//        UIButton *button = (UIButton *)[view viewWithTag:123456];
//        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4,width*0.13,width*0.9/4, width*0.9/4*2/3)];
//        leftImageView.image = image;
//        [view addSubview:leftImageView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"love1"];
//        
//        button.frame = CGRectMake(width*0.8/4*2,width*0.13,width*0.8/4, width*0.8/4*2/3);
//    }
//    if (_imageDataView.count == 2) {
//        
//        UIView *view = (UIView *)[self viewWithTag:12312];
//        UIButton *button = (UIButton *)[view viewWithTag:123456];
//        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.9/4*2,width*0.13,width*0.9/4,width*0.9/4*2/3)];
//        leftImageView.image = image;
//        [view addSubview:leftImageView];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"love2"];
//        
//        button.frame = CGRectMake(width*0.8/4*3,width*0.13,width*0.8/4, width*0.8/4*2/3);
//    }
//    
//    [_imageDataView addObject:[info valueForKey:UIImagePickerControllerEditedImage]];
//    
//}
@end
