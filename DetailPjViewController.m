//
//  DetailPjViewController.m
//  ZuChe
//
//  Created by MacBookXcZl on 2017/7/18.
//  Copyright © 2017年 佐途. All rights reserved.
//

#import "DetailPjViewController.h"
#import "Header.h"
#import "DetailPjTableViewCell.h"
#import "HttpManager.h"
#import "MBProgressHUD.h"
#import "ZCUserData.h"
#import "WSStarRatingView1.h"

#define PJDETAILSPATH @"http://wx.leisurecarlease.com/tc.php?op=dianping_view"

@interface DetailPjViewController ()<UITableViewDelegate,UITableViewDataSource,StarRatingViewDelegate1> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableDictionary *_dataDict;
    WSStarRatingView1*_wsStraRating;
}
@property(nonatomic,strong)UILabel *starLabel;

@end

@implementation DetailPjViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDict = [NSMutableDictionary new];
    _dataArray = [NSMutableArray new];
    // Do any additional setup after loading the view.
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
}
-(void)initData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[[ZCUserData share].userId intValue]];
    
    NSDictionary *dict = @{@"userid":Membership_Id,@"carid":_caridtring};
    
    [HttpManager postData:dict andUrl:PJDETAILSPATH success:^(NSDictionary *fanhuicanshu) {
        
//        NSLog(@"%@",fanhuicanshu);
        
        NSArray *array = fanhuicanshu[@"list"];
        [self creatTableView];
        
        [_dataDict removeAllObjects];
        [_dataDict addEntriesFromDictionary:fanhuicanshu];
        
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:array];
        
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view  animated:NO];
        
    } Error:^(NSString *cuowuxingxi) {
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];
}

- (void)creatTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *string = _dataArray[indexPath.row][@"content"];
    
    CGFloat height1 = [string boundingRectWithSize:CGSizeMake(ScreenWidth*0.9, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.height;
    
    CGFloat wid = ScreenWidth;
    
    return height1 + wid*0.05*4 +0.15*wid + wid*0.2*2/3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stack";
    DetailPjTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
    if (!cell) {
        
        cell = [[DetailPjTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    
    cell.model = _dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headVCiew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ScreenWidth*0.8)];
    headVCiew.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, 0, ScreenWidth*0.9, ScreenWidth*0.2)];
    
    numberLabel.text = [NSString stringWithFormat:@"%@条评价",_dataDict[@"num"]];
    numberLabel.font = [UIFont boldSystemFontOfSize:25];
    numberLabel.textColor = Color(107, 107, 107);
    [headVCiew addSubview:numberLabel];
    
    float x = [_dataDict[@"pingjunxing"] doubleValue];
    float waiguan = [_dataDict[@"shouxing"] doubleValue];
    float neishi = [_dataDict[@"chexing"] doubleValue];
    float fuwu = [_dataDict[@"fuwuxing"] doubleValue];
    
    _wsStraRating = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(numberLabel.frame)-10, 0.085*ScreenHeight*1.7*3/4, 0.03*ScreenHeight*3/4) numberOfStar:5];
    [headVCiew addSubview:_wsStraRating];
    
    _starLabel = [[UILabel alloc] initWithFrame: CGRectMake(CGRectGetMaxX(_wsStraRating.frame)+10, CGRectGetMaxY(numberLabel.frame)-10, 0.085*ScreenHeight, 0.03*ScreenHeight*3/4)];
    _starLabel.adjustsFontSizeToFitWidth = YES;
    _starLabel.textColor = Color(107, 107, 107);
    _starLabel.font = [UIFont systemFontOfSize:15];
    [headVCiew addSubview:_starLabel];
    
    __block DetailPjViewController *NeedSelf = self;
    _wsStraRating.delegate = NeedSelf;
    [_wsStraRating setScore:x/5 withAnimation:YES completion:^(BOOL finished) {
        NeedSelf.starLabel.text = [NSString stringWithFormat:@"%0.1f",x/5 * 5 ];
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(numberLabel.frame)+ScreenWidth*0.05/4, 0.085*ScreenHeight*1.7, 0.02*ScreenHeight*1.5)];
    [headVCiew addSubview:view];
    
    
    UILabel *xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(_starLabel.frame)+ScreenWidth*0.08, 50, 1.3)];
    xianLabel.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [headVCiew addSubview:xianLabel];
    
    UILabel *xianLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(xianLabel.frame)+ScreenWidth*0.05, 50, ScreenWidth*0.1)];
    xianLabel1.text = @"外观";
    xianLabel.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [headVCiew addSubview:xianLabel1];
    
    
    UILabel *xianLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(xianLabel1.frame)+ScreenWidth*0.05, 50, ScreenWidth*0.1)];
    xianLabel2.text = @"内饰";
    
    xianLabel.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [headVCiew addSubview:xianLabel2];
    
    UILabel *xianLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, CGRectGetMaxY(xianLabel2.frame)+ScreenWidth*0.05, 50, ScreenWidth*0.1)];
    xianLabel3.text = @"服务";
    xianLabel.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [headVCiew addSubview:xianLabel3];
    
    
    
    float a = (ScreenWidth*0.1 - 0.02*ScreenHeight*1.5*3/4)/2;
    
     WSStarRatingView1 *wsStraRating1 = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(ScreenWidth*0.9- 0.085*ScreenHeight*1.7*3/4, CGRectGetMinY(xianLabel1.frame)+a, 0.085*ScreenHeight*1.7*3/4, 0.03*ScreenHeight*3/4) numberOfStar:5];
    [headVCiew addSubview:wsStraRating1];
    wsStraRating1.delegate = NeedSelf;
    [wsStraRating1 setScore:waiguan/5 withAnimation:YES completion:^(BOOL finished) {
//        NeedSelf.starLabel.text = [NSString stringWithFormat:@"%0.1f",x/5 * 5 ];
    }];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.9- 0.085*ScreenHeight*1.7*3/4, CGRectGetMinY(xianLabel1.frame)+a, 0.085*ScreenHeight*1.7*3/4, 0.03*ScreenHeight*3/4)];
    [headVCiew addSubview:view1];

    WSStarRatingView1 *wsStraRating2 = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(ScreenWidth*0.9-0.085*ScreenHeight*1.7*3/4, CGRectGetMinY(xianLabel2.frame)+a, 0.085*ScreenHeight*1.7*3/4, 0.02*ScreenHeight*1.5*3/4) numberOfStar:5];
    [headVCiew addSubview:wsStraRating2];
    wsStraRating2.delegate = NeedSelf;
    [wsStraRating2 setScore:neishi/5 withAnimation:YES completion:^(BOOL finished) {
        //        NeedSelf.starLabel.text = [NSString stringWithFormat:@"%0.1f",x/5 * 5 ];
    }];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.9- 0.085*ScreenHeight*1.7*3/4, CGRectGetMinY(xianLabel2.frame)+a, 0.085*ScreenHeight*1.7*3/4, 0.03*ScreenHeight*3/4)];
    [headVCiew addSubview:view2];

    
    
    WSStarRatingView1 *wsStraRating3 = [[WSStarRatingView1 alloc] initWithFrame:CGRectMake(ScreenWidth*0.9-0.085*ScreenHeight*1.7*3/4, CGRectGetMinY(xianLabel3.frame)+a, 0.085*ScreenHeight*1.7*3/4, 0.02*ScreenHeight*1.5*3/4) numberOfStar:5];
    [headVCiew addSubview:wsStraRating3];
    wsStraRating3.delegate = NeedSelf;
    [wsStraRating3 setScore:fuwu/5 withAnimation:YES completion:^(BOOL finished) {
        //        NeedSelf.starLabel.text = [NSString stringWithFormat:@"%0.1f",x/5 * 5 ];
    }];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.9- 0.085*ScreenHeight*1.7*3/4, CGRectGetMinY(xianLabel3.frame)+a, 0.085*ScreenHeight*1.7*3/4, 0.03*ScreenHeight*3/4)];
    [headVCiew addSubview:view3];

    
    UILabel *xianLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.8-1.3, ScreenWidth, 1.3)];
    xianLab.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [headVCiew addSubview:xianLab];
    
    return headVCiew;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return ScreenWidth*0.8;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) goback {
    
    [self.navigationController popViewControllerAnimated:YES];
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
