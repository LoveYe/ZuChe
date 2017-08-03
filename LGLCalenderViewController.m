//
//  LGLCalenderViewController.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git



#import "LGLCalenderViewController.h"
#import "LGLCalenderCell.h"
#import "LGLHeaderView.h"
#import "LGLCalenderModel.h"
#import "LGLCalenderSubModel.h"
#import "LGLCalendarDate.h"
#import "LGLWeekView.h"
#import "Header.h"
#import "ZuChe/ZCUserData.h"
#import "AFNetworking/AFNetworking.h"
#import "HttpManager.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define URL_UP @"http://wx.leisurecarlease.com/api.php?op=api_bcriqi"

@interface LGLCalenderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    
    NSMutableArray *bukezuArray;
    NSMutableArray *quxiaoArray;
    NSMutableArray *aray;
    
    BOOL xuanzhong;
    
    LGLCalenderCell * cell;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableDictionary *cellDic; // 用来存放Cell的唯一标示符
@end

@implementation LGLCalenderViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:animated];
}
- (void)downLoadData{
    
    NSDictionary *dict = @{@"carid":_carid};
    [HttpManager postData:dict andUrl:URL_UP success:^(NSDictionary *fanhuicanshu) {
        
        NSMutableArray *array = fanhuicanshu[@"bukezutime"];
        for (int i = 0; i < array.count;i++) {
            
            NSString *str = array[i];
            NSArray *strc = [str componentsSeparatedByString:@"-"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:strc[0] forKey:@"year"];
            [dic setValue:strc[1] forKey:@"month"];
            [dic setValue:strc[2] forKey:@"day"];
            [bukezuArray addObject:dic];
        }
        NSLog(@"fanhuicanshu---%@",fanhuicanshu);
        [self createCalendarView];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    xuanzhong = YES;
    aray = [NSMutableArray array];
    
    NSLog(@"carid --- %@",_carid);
    self.view.backgroundColor =  [UIColor whiteColor];
    
    bukezuArray = [NSMutableArray array];
    quxiaoArray = [NSMutableArray array];
    
    [self initOtherData];
    [self addHeaderWeekView];
    [self getData];
    
    [self downLoadData];
}
- (void)addHeaderWeekView {
    
    LGLWeekView *week = [[LGLWeekView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    
    week.backgroundColor = Color(0, 215, 200);
    
    [self.view addSubview:week];
}

- (void)initOtherData {
    
    self.title = @"设置日期";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(buooClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = Color(0, 215, 200);
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //获取当前的年月日
     _year = [LGLCalendarDate year:[NSDate date]];
     _month = [LGLCalendarDate month:[NSDate date]];
     _day = [LGLCalendarDate day:[NSDate date]];
}
- (void)buooClick:(UIButton *)sender{
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:bukezuArray];
    
    for (NSDictionary *dict in arr) {
        
        NSString *str = [NSString stringWithFormat:@"%@-%@-%@",dict[@"year"],dict[@"month"],dict[@"day"]];
        [quxiaoArray addObject:str];
    }
    
    NSDictionary *dic = @{@"carid":_carid,@"tiemList":quxiaoArray};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager POST:URL_UP parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.navigationController popViewControllerAnimated:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [operation start];
    
}
- (void)fanhui:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)createCalendarView{
    
    //布局
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //设置item的宽高
    layout.itemSize=CGSizeMake(WIDTH / 7, WIDTH / 7);
    //设置滑动方向
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置行间距
    layout.minimumLineSpacing=0.0f;
    //每列的最小间距
    layout.minimumInteritemSpacing = 0.0f;
    //四周边距
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 104) collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.showsVerticalScrollIndicator=NO;
    
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[LGLHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView"];
    
}

- (void)getData {
    
    [LGLCalenderModel getCalenderDataWithDate:[NSDate date] block:^(NSMutableArray *result) {
        
        [self.dataSource addObjectsFromArray:result];
        [self.collectionView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    LGLCalenderModel * model = self.dataSource[section];
    return model.details.count + model.firstday;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        
        identifier = [NSString stringWithFormat:@"LGLCalenderCell%@", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [self.collectionView registerClass:[LGLCalenderCell class]  forCellWithReuseIdentifier:identifier];
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        if (self.dataSource.count) {
            
            LGLCalenderModel * model = self.dataSource[indexPath.section];
            if (indexPath.item >= model.firstday) {
                NSInteger index = indexPath.item - model.firstday;
                LGLCalenderSubModel * subModel = model.details[index];
                cell.dateL.text = [NSString stringWithFormat:@"%ld",(long)subModel.day];
                
                cell.dateL.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
                cell.dateL.textColor = Color(150, 150, 150);
                
                if ((model.year == _year) && (model.month == _month) && (subModel.day < _day)) {
                    // 如果是过去的时间，设置为灰色
                    cell.backgroundColor = LGLColor(236, 236, 236);
                    cell.dateL.textColor = Color(150, 150, 150);
                    
                    UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
                    
                    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"已过(1)"]];
                    image.frame = view.bounds;
                    [view addSubview:image];
                    
                    [cell addSubview:view];
                    cell.userInteractionEnabled = NO;
                }
                
                NSMutableArray *array = [NSMutableArray arrayWithArray:bukezuArray];
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue: [NSString stringWithFormat:@"%ld", model.year] forKey:@"year"];
                [dic setValue: [NSString stringWithFormat:@"%ld", model.month] forKey:@"month"];
                [dic setValue: [NSString stringWithFormat:@"%ld", subModel.day] forKey:@"day"];
                
                if ([array containsObject:dic]) {
                    
                    UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
                    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"不可租"]];
                    image.frame = view.bounds;
                    [view addSubview:image];
                    
                    cell.backgroundView = view;
                }
            }
        }
    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LGLHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView" forIndexPath:indexPath];
    LGLCalenderModel * model = self.dataSource[indexPath.section];
    headerView.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",model.year, model.month];
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(WIDTH, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LGLCalenderModel *model = self.dataSource[indexPath.section];
    NSInteger index = indexPath.row - model.firstday;
    LGLCalenderSubModel *subModel = model.details[index];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue: [NSString stringWithFormat:@"%ld", model.year] forKey:@"year"];
    [dic setValue: [NSString stringWithFormat:@"%ld", model.month] forKey:@"month"];
    [dic setValue: [NSString stringWithFormat:@"%ld", subModel.day] forKey:@"day"];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:bukezuArray];
    if ([array containsObject:dic]) {
        
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
        
    }else{
        
//        NSLog(@"dianji  111111111");
        
        [bukezuArray addObject:dic];
        UICollectionViewCell *cell111 = [collectionView cellForItemAtIndexPath:indexPath];
        
        UIView *view = [[UIView alloc] initWithFrame:cell111.bounds];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"不可租"]];
        image.frame = view.bounds;
        [view addSubview:image];
        
        cell111.backgroundView = view;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LGLCalenderModel *model = self.dataSource[indexPath.section];
    NSInteger index = indexPath.row - model.firstday;
    LGLCalenderSubModel *subModel = model.details[index];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue: [NSString stringWithFormat:@"%ld", model.year] forKey:@"year"];
    [dic setValue: [NSString stringWithFormat:@"%ld", model.month] forKey:@"month"];
    [dic setValue: [NSString stringWithFormat:@"%ld", subModel.day] forKey:@"day"];
    
    
    NSMutableArray *arary = [NSMutableArray arrayWithArray:bukezuArray];
    if ([arary containsObject:dic]) {
        
//        NSLog(@"222222222222222");
        [bukezuArray removeObject:dic];
        UICollectionViewCell *cell222 = [collectionView cellForItemAtIndexPath:indexPath];
        cell222.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [[UIView alloc] initWithFrame:cell222.bounds];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        image.frame = view.bounds;
        
        cell222.backgroundView = view;
        
    }else{
        
        [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
    
}

- (void)seleDateWithBlock:(SelectDateBalock)block {
    
    self.block = block;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableDictionary *)cellDic {
    if (!_cellDic) {
        _cellDic = [NSMutableDictionary dictionary];
    }
    return _cellDic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
