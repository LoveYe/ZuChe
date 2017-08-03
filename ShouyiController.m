
//
//  SViewController.m
//  pullDownMenu
//
//  Created by HYS on 16/9/23.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "ShouyiController.h"
#import "Header.h"
#import "TxTableViewCell.h"
#import "ZfbAndYhkViewController.h"

@interface ShouyiController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation ShouyiController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"没有收益.png"]];
    
    image.frame =  CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44);
    
    [self.view addSubview:image];

    //[self createUI];
//    UIButton *fanctory = [UIButton buttonWithType:UIButtonTypeCustom];
//    fanctory.frame = CGRectMake(0, 0, 25, 25);
//    [fanctory setBackgroundImage:[UIImage imageNamed:@"历史标的(3).png"] forState:UIControlStateNormal];
//    [fanctory addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:fanctory];
//    self.navigationItem.rightBarButtonItem = rightButton;
//    
}
//-(void)barButtonItemClick:(UIBarButtonItem *)barButton {
//    NSLog(@"%@",@"wwwwww");
//   //  [self.navigationController pushViewController:[HistoryViewController new] animated:YES];
//}
- (void)createUI{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 ,ScreenWidth,ScreenHeight-49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableHeaderView = [self returnTableViewHeadView];
}
-(UIView *)returnTableViewHeadView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.6)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:207/255.0 blue:105/255.0 alpha:1];
    
    UILabel *yueLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05, ScreenWidth/2-ScreenWidth*0.05, ScreenWidth*0.1)];
    // yueLabel.backgroundColor  = [UIColor redColor];
    yueLabel.text = @"现金余额(元)";
    yueLabel.textColor = [UIColor whiteColor];
    [view addSubview:yueLabel];
    
    UILabel *qian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05,CGRectGetMaxY(yueLabel.frame)-ScreenWidth*0.03, ScreenWidth/2-ScreenWidth*0.05, ScreenWidth*0.15)];
    //qian.backgroundColor  = [UIColor blueColor];
    qian.text = @"1,000.00";
    qian.font = [UIFont fontWithName:@"Arial-BoldMT" size:30.f];
    qian.textColor = [UIColor whiteColor];
    [view addSubview:qian];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05,CGRectGetMaxY(qian.frame)+ScreenWidth*0.05, ScreenWidth*0.9, 1)];
    line.backgroundColor  = [UIColor colorWithWhite:1 alpha:0.5];
    [view addSubview:line];
    
    
    UIButton *tixian = [UIButton buttonWithType:UIButtonTypeCustom];
    tixian.frame = CGRectMake(ScreenWidth/2+ScreenWidth*0.1, CGRectGetMaxY(yueLabel.frame)-ScreenWidth*0.03,  ScreenWidth/2-ScreenWidth*0.1, ScreenWidth*0.15);
    [tixian setTitle:@"可提现 >" forState:UIControlStateNormal];
    tixian.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    tixian.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [tixian addTarget:self action:@selector(tixianButton:) forControlEvents:UIControlEventTouchUpInside];
    [tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:tixian];
    
    
    UILabel *baozheng = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05, ScreenWidth*0.05+CGRectGetMaxY(line.frame), ScreenWidth/2-ScreenWidth*0.05, ScreenWidth*0.1)];
    // yueLabel.backgroundColor  = [UIColor redColor];
    baozheng.text = @"保证金(元)";
    baozheng.textColor = [UIColor whiteColor];
    [view addSubview:baozheng];
    
    UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.05,CGRectGetMaxY(baozheng.frame)-ScreenWidth*0.03, ScreenWidth/2-ScreenWidth*0.05, ScreenWidth*0.1)];
    //qian.backgroundColor  = [UIColor blueColor];
    jin.text = @"500.00";
    jin.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.f];
    jin.textColor = [UIColor whiteColor];
    [view addSubview:jin];
    
    UILabel *leiji = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth*0.1, ScreenWidth*0.05+CGRectGetMaxY(line.frame), ScreenWidth/2-ScreenWidth*0.1, ScreenWidth*0.1)];
    // yueLabel.backgroundColor  = [UIColor redColor];
    leiji.text = @"累计提现(元)";
    leiji.textColor = [UIColor whiteColor];
    [view addSubview:leiji];
    
    UILabel *jinqian = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth*0.1,CGRectGetMaxY(leiji.frame)-ScreenWidth*0.03, ScreenWidth/2-ScreenWidth*0.1, ScreenWidth*0.1)];
    //qian.backgroundColor  = [UIColor blueColor];
    jinqian.text = @"50,000.00";
    jinqian.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.f];
    jinqian.textColor = [UIColor whiteColor];
    [view addSubview:jinqian];
    
    return view;
}
-(void)tixianButton:(UIButton *)tixianButton {
    NSLog(@"提现");
    ZfbAndYhkViewController *zfbAndYhk = [ZfbAndYhkViewController new];
    zfbAndYhk.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zfbAndYhk animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.1*ScreenWidth)];
    headerView.backgroundColor =  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    UILabel *le = [[UILabel alloc] initWithFrame:CGRectMake(0.05*ScreenWidth, 0, 100, 0.1*ScreenWidth)];
    
    UILabel *ri = [[UILabel alloc] initWithFrame:CGRectMake(0.95*ScreenWidth-100, 0, 100, 0.1*ScreenWidth)];
    le.text = @"2017年1月";
    le.textAlignment = NSTextAlignmentLeft;
    le.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
    le.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    // le.textColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    // _leftLabel.backgroundColor = [UIColor blueColor];
    ri.text = @"+7000元";
    ri.textAlignment = NSTextAlignmentRight;
    ri.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
    ri.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    // ri.textColor = [UIColor colorWithRed:7/255.0 green:187/255.0 blue:177/255.0 alpha:1];
    [headerView addSubview:le];
    [headerView addSubview:ri];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1*ScreenWidth;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenWidth*0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.dict = @{};
    return cell;
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
