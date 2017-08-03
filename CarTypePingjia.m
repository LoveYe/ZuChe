//
//  CarTypePingjia.m
//  ZuChe
//
//  Created by apple  on 2017/5/8.
//  Copyright © 2017年 佐途. All rights reserved.
//

#define PJUrl @"http://wx.leisurecarlife.com/api.php?op=api_hcpj"
#import "CarTypePingjia.h"
#import "Header.h"
#import "HttpManager.h"
#import "PjDemoTableViewCell.h"

@interface CarTypePingjia ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tabelView;
    
    CGFloat width;
    CGFloat height;
    
    NSMutableArray *_array;
    
    NSString *_pingjia;
    NSString *_xing;
}

@end

@implementation CarTypePingjia

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self downloadData];
}
- (void)downloadData{
    
    NSDictionary *dict = [NSDictionary dictionary];
    if ([self.cartype intValue] == 1) {
        
        dict = @{@"zid":self.carId};
    }
    if ([self.cartype intValue] == 2) {
        
        dict = @{@"gid":self.carId};
    }
    
    [HttpManager postData:dict andUrl:PJUrl success:^(NSDictionary *fanhuicanshu) {
        
        [_array addObjectsFromArray:fanhuicanshu[@"pj_list"] ];
        _pingjia = fanhuicanshu[@"yd_num"];
        _xing = fanhuicanshu[@"zong_xing"];
        
//        [self createTableView];
        [_tabelView reloadData];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    _array = [NSMutableArray array];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    [self createTableView];
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _tabelView.delegate   = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    
    _tabelView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *string = _array[indexPath.row][@"pj_content"];
    CGFloat height1 = [string boundingRectWithSize:CGSizeMake(self.view.frame.size.width-width*0.1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    return height1+width*0.55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stack";
    PjDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stac];
    if (!cell) {
        
        cell = [[PjDemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    
    cell.model = _array[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headVCiew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, width*0.2)];
    headVCiew.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, 0, width*0.9, width*0.1)];
    numberLabel.text = [NSString stringWithFormat:@"%ld条评论",_array.count];
    numberLabel.font = [UIFont systemFontOfSize:25];
    [headVCiew addSubview:numberLabel];
    
    UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.31, CGRectGetMaxY(numberLabel.frame)-width*0.0125, width*0.06, width*0.1)];
    starLabel.adjustsFontSizeToFitWidth = YES;
    starLabel.text = [NSString stringWithFormat:@"%@.0",_xing];
    starLabel.font = [UIFont systemFontOfSize:15];
    [headVCiew addSubview:starLabel];
    
    float x = [_xing intValue];
    for (int i = 0; i < x; i++) {
        
        UIImageView *stat = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.05+width*0.05*i, CGRectGetMaxY(numberLabel.frame)+width*0.05/4, width*0.05, width*0.05)];
        stat.image = [UIImage imageNamed:@"五角星.png"];
        [headVCiew addSubview:stat];
    }
    
    return headVCiew;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return width*0.2;
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
