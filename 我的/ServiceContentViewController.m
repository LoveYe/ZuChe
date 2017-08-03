//
//  ServiceContentViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/13.
//  Copyright © 2015年 佐途. All rights reserved.
//
#define LINESPACE 4
#import "ServiceContentViewController.h"
#import "AllPages.pch"
#import "UILabel+SizeLabel.h"


@interface ServiceContentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float  titleHeight;
    float contentHeight;
}
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSArray *listArray;

@end

@implementation ServiceContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"服务中心"];
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-65)];
    self.tableView.delegate= self;
    self.tableView.dataSource= self;
    [self.view addSubview:self.tableView];
    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:self.catid,@"catid", nil];
    [HttpManager arrayPostData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=fuwu_show",NowUrl] Arraysuccess:^(NSArray *arrayfanhui) {
        _listArray =arrayfanhui;
        [self.tableView reloadData];
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@",cuowuxingxi);
        
    }];
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth *0.1, ScreenWidth*0.04, ScreenWidth*0.8, ScreenWidth*0.05)];
    title.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"title"]];
    title.numberOfLines =0;
    [self label:title isBold:NO isFont:13.0f];
    //    title.backgroundColor =[UIColor yellowColor];
    [cell.contentView addSubview:title];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LINESPACE];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title.text length])];
    title.attributedText = attributedString;
    
    
    
    titleHeight =[UILabel  height:title.text widthOfFatherView:title.frame.size.width textFont:title.font];
    title.frame =CGRectMake(ScreenWidth *0.1, ScreenWidth*0.04, ScreenWidth-ScreenWidth*0.14, titleHeight+10);
    
    UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, titleHeight+10+ScreenWidth*0.08, ScreenWidth-ScreenWidth*0.08, 1)];
    xian.backgroundColor =Color(225, 225, 225);
    [cell.contentView addSubview:xian];
    
    
    float nowHeight =titleHeight+10+ScreenWidth*0.08+1;
    
    UILabel * yuan =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.05, nowHeight/2-2.5, 5, 5)];
    yuan.layer.cornerRadius=yuan.frame.size.height/2;
    yuan.layer.masksToBounds=YES;
    
    //    NSString *str =[NSString stringWithFormat:@"%@",[[self.array objectAtIndex:indexPath.row] objectForKey:@"kan"]];
    //    if ([str isEqualToString:@"0"] )
    //    {
    //        yuan.backgroundColor = [UIColor grayColor];
    //
    //    }else
    //    {
    yuan.backgroundColor = Color(0, 170, 238);
    
    //   }
    [cell.contentView addSubview:yuan];
    
    
    
    UILabel * content =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, titleHeight+10+ScreenWidth*0.1, ScreenWidth*0.92, ScreenWidth*0.1)];
    content.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"description"]];
    content.numberOfLines =0;
    
    NSMutableAttributedString *attributedStrings = [[NSMutableAttributedString alloc] initWithString:content.text];
    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyles setLineSpacing:4];//调整行间距
    [attributedStrings addAttribute:NSParagraphStyleAttributeName value:paragraphStyles range:NSMakeRange(0, [content.text length])];
    content.attributedText = attributedStrings;
    
    [self label:content isBold:NO isFont:12.0f];
    content.textColor =Color(100, 100, 100);
    [cell.contentView addSubview:content];
    contentHeight =[UILabel height:content.text widthOfFatherView:content.frame.size.width textFont:content.font];
    content.frame =CGRectMake(ScreenWidth*0.04, titleHeight+10+ScreenWidth*0.1, ScreenWidth*0.92, contentHeight+20);
    
    
    
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return titleHeight+10+ScreenWidth*0.11+contentHeight+20+ScreenWidth*0.05;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
