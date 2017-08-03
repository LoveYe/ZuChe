//
//  PingJiaXiangqingView.m
//  ZuChe
//
//  Created by apple  on 16/11/16.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "PingJiaXiangqingView.h"

@interface PingJiaXiangqingView ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    CGFloat width;
}
@end


@implementation PingJiaXiangqingView

- (void)viewDidLoad{
    
    width = self.view.frame.size.width;
    
    [self createTableView];
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}
@end
