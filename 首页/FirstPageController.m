//
//  FirstPageController.m
//  ZuChe
//
//  Created by J.X.Y on 15/11/11.
//  Copyright © 2015年 佐途. All rights reserved.


//首页进一级筛选   一级筛选页

#import "FirstPageController.h"
#import "AllPages.pch"
#import "IanScrollView.h"
#import "UIImageView+WebCache.h"
#import "FastWebImage.h"
#import "DropDownListViewController.h"
@interface FirstPageController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UIButton *_tmpBtn;
    UIView *sxview;
    IanScrollView *scrollView;
    MBProgressHUD *HUD;
    AFHTTPRequestOperationManager *manager;
    NSMutableArray *countarray;
    UIImageView *imageView;
    UILabel *tishi;
    
}
@property (nonatomic,retain)UITableView *tableview;
@property (nonatomic,retain)UIView *bigView;
@property (nonatomic,retain)UIView *smallView;
@property (nonatomic,retain)UIButton *remoBtn;
@end

@implementation FirstPageController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self loadAvatarInKeyWindow];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [GiFHUD dismiss];
    [self.avatar1 removeFromSuperview];
    self.tabBarController.tabBar.hidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GiFHUD setGifWithImageName:@"加载动画.gif"];
    [GiFHUD showWithOverlay];

    
    [self tishixiaoche];
    
    
    [self addTitleViewWithTitle:@"车辆筛选"];
    self.view.backgroundColor=Color(234, 234, 234)
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightbutton setBackgroundImage:[UIImage imageNamed:@"42 (4)"] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(sousuobtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addItemWithCustomView:@[rightbutton] isLeft:NO];
    
    [self topshaixuan];
    
    [self lostnet:self.view loding:^(NSString *status) {
        
        self.status = status;
        
        if ([status isEqualToString:@"无连接"]) {
            NSString *path = [[NSBundle mainBundle]pathForResource:@"404/error.html" ofType:nil];
            NSURL *url = [NSURL fileURLWithPath:path];
            NSURLRequest *requset = [NSURLRequest requestWithURL:url];
            self.Lodingwebview=[[UIWebView alloc]initWithFrame:self.view.bounds];
            self.Lodingwebview.scrollView.bounces=NO;
            [self.Lodingwebview loadRequest:requset];
            [self.view addSubview:self.Lodingwebview];
            
            
        } else if ([status isEqualToString:@"加载中..."]){
            [self.Lodingwebview removeFromSuperview];
            [self Tableview];
            [self Downwork];
            
        }
    }];
}
-(void)tishixiaoche
{
    imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.17, ScreenWidth*0.55,ScreenWidth*0.55)];
    imageView.image =[UIImage imageNamed:@"小车"];
    [self.view addSubview:imageView];
    
    

    
    tishi =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.6+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
    tishi.numberOfLines =0;
    tishi.textAlignment =NSTextAlignmentCenter;
    [self label:tishi isBold:YES isFont:14];
    tishi.textColor=Color(99,99, 99);
    tishi.text= @" 我们正在努力为您丰富此类车辆！";
    [self.view addSubview:tishi];
    
}
-(void)Downwork
{
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:self.ids,@"catid",nil];
    [manager POST:SHOUYESHAIXUAN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        countarray=[NSMutableArray array];
        
        if ([ responseObject  isKindOfClass:[NSArray class]]) {
            countarray=responseObject;
            if (countarray.count !=0)
            {
                [imageView removeFromSuperview];
                [tishi removeFromSuperview];
                
            }else
            {
                [self.tableview removeFromSuperview];
            }
            
        }
        [GiFHUD dismiss];
        [_tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
        [GiFHUD dismiss];
    }];
    
}
-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 35, ScreenWidth, ScreenHeight-Height(35)-64)];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
//    //MJ刷新
//    _tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        [self Downwork];
//        //结束刷新
//        [_tableview.mj_header endRefreshing];
//    }];
    //小贾自定义刷新
    [self Refresh_JXY:_tableview VOID:^{
        [self Downwork];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  countarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth*0.666;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"imageCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UIImageView * webImage = [[UIImageView alloc] init];
        [webImage setFrame:CGRectMake(0, 0, self.view.bounds.size.width, ScreenWidth*0.666)];
        [webImage setTag:100];
        [cell.contentView addSubview:webImage];
        
        UIImageView *beijin=[MyUtil createImageViewFrame:CGRectMake(0, ScreenWidth*0.666-Height(35), ScreenWidth, Height(35)) imageName:nil];
        beijin.tag=101;
        [cell.contentView addSubview:beijin];
        UILabel *firsttitle=[[UILabel alloc]initWithFrame:CGRectMake(Height(10), ScreenWidth*0.666-Height(35), ScreenWidth, Height(35))];
        //        firsttitle.font=Font(14);
        [self label:firsttitle isBold:NO isFont:14];
        firsttitle.textColor=[UIColor whiteColor];
        firsttitle.tag=102;
        [cell.contentView addSubview:firsttitle];
        
        
        UIView  *douming=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-Height(70))/2,ScreenWidth*0.4, Height(70), Height(20))];
        douming.backgroundColor=[UIColor blackColor];
        douming.alpha=0.2;
        [cell.contentView addSubview:douming];
        UILabel *yuantou=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-Height(70))/2,ScreenWidth*0.4, Height(70), Height(20))];
        yuantou.tag=999;
        [self label:yuantou isBold:NO isFont:14];
        [yuantou setTextColor:[UIColor whiteColor]];
        [yuantou setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:yuantou];
        
        UILabel *yuantou1=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-Height(160))/2,ScreenWidth*0.2, Height(160), Height(30))];
        yuantou1.tag=888;
        [self label:yuantou1 isBold:YES isFont:20];
        [yuantou1 setTextColor:[UIColor whiteColor]];
        [yuantou1 setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:yuantou1];
    }

    UILabel *yuan=(UILabel *)[cell.contentView viewWithTag:999];
    yuan.text=[NSString stringWithFormat:@"%@个车源", [countarray[indexPath.row] objectForKey:@"geshu"]];
    
    UILabel *yuan1=(UILabel *)[cell.contentView viewWithTag:888];
    yuan1.text=[NSString stringWithFormat:@"%@", [countarray[indexPath.row] objectForKey:@"title"]];
    
    UIImageView *beijin1=(UIImageView *)[cell.contentView viewWithTag:101];
    beijin1.backgroundColor=[UIColor blackColor];
    beijin1.alpha=0.6;
    UIImageView * image = (UIImageView *)[cell.contentView viewWithTag:100];
    [image sd_setImageWithURL:[NSURL URLWithString:[countarray[indexPath.row] objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"奔驰"]];
    UILabel *firsttitle1=(UILabel *)[cell.contentView viewWithTag:102];
    firsttitle1.text=[NSString stringWithFormat:@"%@",[countarray[indexPath.row] objectForKey:@"chexing"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"chexing=%@",[NSString stringWithFormat:@"%@",[countarray[indexPath.row] objectForKey:@"chexing"]]);
//    NSLog(@"title=%@",[NSString stringWithFormat:@"%@",[countarray[indexPath.row] objectForKey:@"title"]]);
//    SecPageController *pa=[[SecPageController alloc]init];
//    pa.models=[NSString stringWithFormat:@"%@",[countarray[indexPath.row] objectForKey:@"chexing"]];
//    pa.toptitle=[NSString stringWithFormat:@"%@",[countarray[indexPath.row] objectForKey:@"title"]];
//    [self.navigationController pushViewController:pa animated:YES];
}

-(void)topshaixuan
{
    UIColor *colo=Color(64, 64, 64)
    UIColor *color=Color(18, 152, 233)
    _tmpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _tmpBtn.backgroundColor=[UIColor whiteColor];
    _tmpBtn.frame=CGRectMake(0,0, ScreenWidth, 35);
    //    _tmpBtn.titleLabel.font=[UIFont systemFontOfSize:ScreenWidth*0.04375];
    _tmpBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_tmpBtn setTitle:@"等级筛选" forState:UIControlStateNormal];
    [_tmpBtn setTitleColor:colo forState:UIControlStateNormal];
    [_tmpBtn setTitleColor:color forState:UIControlStateSelected];
    [_tmpBtn setImage:[UIImage imageNamed:@"二级筛选_下"] forState:UIControlStateNormal];
    [_tmpBtn setImage:[UIImage imageNamed:@"二级筛选_上上"] forState:UIControlStateSelected];
    [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,ScreenWidth*0.34375,0,0)];
    [_tmpBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScreenWidth*0.09375, 0,ScreenWidth*0.09375)];
    [_tmpBtn addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _tmpBtn.selected=NO;
    
    
    [self.view addSubview:_tmpBtn];
    UILabel *xian1=[[UILabel alloc]initWithFrame:CGRectMake(0, 34.6, ScreenWidth, 0.3)];
    xian1.backgroundColor=[UIColor colorWithRed:81/255 green:81/255 blue:81/255 alpha:0.5];
    xian1.alpha=0.4;
    [self.view addSubview:xian1];

}
-(void)checkbtn:(UIButton *)sender
{
    if (_tmpBtn.selected==YES) {
        [self removeBtn];
        _tmpBtn.selected=NO;
    }else
    {
        [self zhezhao];
        _tmpBtn.selected=YES;
        [self saixuan];
    }
}
#pragma mark-筛选
-(void)saixuan
{
    sxview=[[UIView alloc]initWithFrame:CGRectMake(0,35, ScreenWidth, ScreenWidth*0.5937)];
    sxview.backgroundColor=[UIColor whiteColor];
    UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, 1)];
    xian.backgroundColor=Color(225, 225, 225)
    [sxview addSubview:xian];
    
    
    [self.view addSubview:sxview];
    
    scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0, 1, ScreenWidth,ScreenWidth*0.5937)];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"30-50",@"50-100",@"100-200", nil];
    NSMutableArray *titlearray=[NSMutableArray arrayWithObjects:@"小于50万(舒适型)",@"大于50万(豪华型)",@"大于200万(尊贵型)",nil];
    scrollView.slideImagesArray = array;
    scrollView.PageControlPageIndicatorTintColor = [UIColor colorWithRed:255/255.0f green:244/255.0f blue:227/255.0f alpha:1];
    scrollView.pageControlCurrentPageIndicatorTintColor = [UIColor colorWithRed:67/255.0f green:174/255.0f blue:168/255.0f alpha:1];
    scrollView.autoTime = [NSNumber numberWithFloat:4.0f];
    [scrollView startLoading];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake((scrollView.frame.size.width-150)/2,scrollView.frame.size.height-ScreenWidth*0.0935, 150, 15)];
    [title setTextAlignment:NSTextAlignmentCenter];
    //    title.font=[UIFont systemFontOfSize:13 weight:0.1];
    [self label:title isBold:NO isFont:14];
    title.text=[NSString stringWithFormat:@"%@",titlearray[0]];
    
    
    title.textColor=Color(32, 32, 32)
    __weak __typeof(self)weakSelf = self;
    scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
        HUD = [[MBProgressHUD alloc] initWithView:weakSelf.view];
        [weakSelf.view addSubview:HUD];
        HUD.delegate = weakSelf;
        HUD.removeFromSuperViewOnHide=YES;
        [HUD hide:YES afterDelay:3];
        HUD.labelText = @"正在加载数据...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:self.ids,@"catid",array[i],@"jiage",nil];
            [manager POST:FIRSTURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                countarray=[NSMutableArray array];
                [imageView removeFromSuperview];
                [tishi removeFromSuperview];
                if ([ responseObject  isKindOfClass:[NSArray class]]) {
                    countarray=responseObject;
                    if (countarray.count==0) {
                        [self tishixiaoche];
                    }
                }
                [_tableview reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error==%@",error);
            }];
            
        }completionBlock:^{
            
            [HUD removeFromSuperview];
            
        }];
        
        
        [weakSelf removeBtn];
    };
    scrollView.ianCurrentIndex=^(NSInteger i){
        
        title.text=[NSString stringWithFormat:@"%@",titlearray[i]];
    };
    
    
    [sxview addSubview:scrollView];
    [sxview addSubview:title];
}
-(void)zhezhao
{
    self.bigView =[[UIView alloc]initWithFrame:CGRectMake(0,64+Height(35), ScreenWidth, ScreenHeight)];
    self.bigView.backgroundColor=[UIColor blackColor];
    self.bigView.alpha =0.3;
    
    self.remoBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.remoBtn.frame =CGRectMake(0,0, ScreenWidth, ScreenHeight);
    [self.remoBtn addTarget:self action:@selector(removeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bigView addSubview:self.remoBtn];
    
    [self.view addSubview:self.bigView];
    
}
-(void)removeBtn
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _tmpBtn.selected=NO;
        [sxview removeFromSuperview];
        [scrollView removeFromSuperview];
        [self.remoBtn removeFromSuperview];
        [self.bigView removeFromSuperview];
        [self.smallView removeFromSuperview];
    }];
    
    
}
-(void)sousuobtn:(UIButton *)sender
{
    DropDownListViewController *dropdown=[[DropDownListViewController alloc]init];
    [self.navigationController pushViewController:dropdown animated:YES];
}
@end
