//
//  chexinzaizheli.m
//  ZuChe
//
//  Created by J.X.Y on 15/12/16.
//  Copyright © 2015年 佐途. All rights reserved.


#import "chexinmodelViewController.h"
#import "InfiniteTreeView.h"
#import "UserInfoCell.h"
#import "User.h"
#import "AllPages.pch"
#define CarInfor [[NSUserDefaults standardUserDefaults]valueForKey:@"addcarurl"]

@interface chexinmodelViewController ()<PushTreeViewDataSource, PushTreeViewDelegate>
{
    InfiniteTreeView *_pushTreeView;
    NSInteger one;
    NSInteger two;
    NSInteger two1;
    NSString *weiz2;
    UIView *headerview ;
}
@end

@implementation chexinmodelViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [self addTitleViewWithTitle:@"车型"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    title.text = @"车型";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = title;
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 25, 25);
    [left setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = rightBarButton;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = leftBarButton;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    _pushTreeView = [InfiniteTreeView loadFromXib];
    _pushTreeView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+64);
    _pushTreeView.dataSource = self;
    _pushTreeView.delegate = self;
    [self.view addSubview:_pushTreeView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PushTreeViewDataSource
- (NSInteger)numberOfSectionsInLevel:(NSInteger)level
{
    return 1;
}

- (NSInteger)numberOfRowsInLevel:(NSInteger)level section:(NSInteger)section
{
    CGFloat num=0;
    if (level==0) {
        
        num= [[CarInfor objectForKey:@"chexing"] count];
    }if (level==1) {
        num=[[[[CarInfor objectForKey:@"chexing"] objectAtIndex:two] objectForKey:@"models"] count];
    }
    return num;
}

- (InfiniteTreeBaseCell *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    static NSString *identifier = @"UserInfoCell";
    UserInfoCell *cell = (UserInfoCell*)[pushTreeView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [UserInfoCell cellFromNib];
    }
    cell.user = [self userFromSectionAndLevel:indexPath level:level];
    return cell;
}

#pragma mark - PushTreeViewDelegate
- (void)pushTreeView:(InfiniteTreeView *)pushTreeView didSelectedLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    one=level;
    two=indexPath.row;
    if (level==0) {
        two1=indexPath.row;
    }
    if (level==1) {
        
        User *user = [[User alloc] init];
        user.name = [NSString stringWithFormat:@"%@", [[[[[CarInfor objectForKey:@"chexing"] objectAtIndex:two1] objectForKey:@"models"] objectAtIndex:two ] objectForKey:@"model"]];
        user.title = [NSString stringWithFormat:@"%@", [[[CarInfor objectForKey:@"chexing"] objectAtIndex:two1] objectForKey:@"title"]];
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
        NSLog(@"%@",user.title);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chexingshizhege" object:user.name];
        NSUserDefaults * stand =[NSUserDefaults  standardUserDefaults];
        [stand setObject:user.title forKey:@"carTitle"];
    }
    
}

- (UIView *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level viewForHeaderInSection:(NSInteger)section
{
    headerview=nil;
    
    return headerview;

}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(40);
}

- (BOOL)pushTreeViewHasNextLevel:(InfiniteTreeView *)pushTreeView currentLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    BOOL next;
    if (level == 0 ) {
        next = YES;
    }else
    {
        next=NO;    
    }
    return next;
}

- (void)pushTreeViewWillReloadAtLevel:(InfiniteTreeView*)pushTreeView currentLevel:(NSInteger)currentLevel level:(NSInteger)level                            indexPath:(NSIndexPath*)indexPath
{
    
}

#pragma mark - private methods
- (User*)userFromSectionAndLevel:(NSIndexPath*)indexPath level:(NSInteger)level
{
    weiz2=[[NSString alloc]init];
    User *user = [[User alloc] init];
    if (level==0) {
        user.name = [NSString stringWithFormat:@"%@",[[[CarInfor objectForKey:@"chexing"] objectAtIndex:indexPath.row] objectForKey:@"title"]];
        
    }if (level==1) {
        user.name = [NSString stringWithFormat:@"%@", [[[[[CarInfor objectForKey:@"chexing"] objectAtIndex:two] objectForKey:@"models"] objectAtIndex:indexPath.row ] objectForKey:@"model"]];
        weiz2=user.name;
    }
    
    return user;
}

@end
