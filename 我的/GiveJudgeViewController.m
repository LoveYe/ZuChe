//
//  GiveJudgeViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/10.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "GiveJudgeViewController.h"
#import "AllPages.pch"
#import "UILabel+SizeLabel.h"
#import "TapImageView.h"
#import "ImgScrollView.h"
#import "UIImageView+WebCache.h"
#define LINESPACE 2

@interface GiveJudgeViewController ()<UITableViewDataSource,UITableViewDelegate,ImgScrollViewDelegate,TapImageViewDelegate>
{
    UITableView *myTable;
    UIScrollView *myScrollView;
    NSInteger currentIndex;
    UIView *markView;
    UIView *scrollPanel;
    UITableViewCell *tapCell;
    float myHeight;
    ImgScrollView *lastImgScrollView;
    int xingji1;
    NSArray *_listArray;
    UIImageView*   _imageView;
    UILabel*_tishi;
}
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic, retain)NSArray *thumbArray;

@end

@implementation GiveJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    xingji1=4;
    self.view.backgroundColor =Color(245, 245, 249);
    [self tableViews];
    
    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].userId,@"userid", nil];
    
    
    [HttpManager arrayPostData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=gmy_pingjia",NowUrl] Arraysuccess:^(NSArray *arrayfanhui) {
        
        NSLog(@"%@",arrayfanhui);
        
        
        _listArray=arrayfanhui;
        
        [self.tableView reloadData];
        if (_listArray.count==0)
        {
            [self.tableView removeFromSuperview];
            _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.4-ScreenWidth*0.17, ScreenWidth*0.55,ScreenWidth*0.55)];
            _imageView.image =[UIImage imageNamed:@"小车"];
            
            

            _tishi =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth*0.55/2, ScreenHeight/2-ScreenWidth*0.6+ScreenWidth*0.6, ScreenWidth*0.55, ScreenWidth*0.2)];
            _tishi.numberOfLines =0;
            _tishi.textAlignment =NSTextAlignmentCenter;
            [self label:_tishi isBold:YES isFont:14];
            _tishi.textColor=Color(99,99, 99);
            _tishi.text= @"您还没有给别人评价过";
            [self.view addSubview:_imageView];
            [self.view addSubview:_tishi];
            
        }

        
        
    } Error:^(NSString *cuowuxingxi) {
        NSLog(@"%@",cuowuxingxi);
        
    }];
    
    
    
    //      [HttpManager  postData:dict andUrl:[NSString stringWithFormat:@"%@api.php?op=gmy_pingjia",NowUrl] success:^(NSDictionary *fanhuicanshu) {
    //          NSLog(@"%@",fanhuicanshu);
    //          [self.tableView reloadData];
    //      } Error:^(NSString *cuowuxingxi) {
    //          NSLog(@"%@",cuowuxingxi);
    //
    //      }];
    
    
}
- (void) addSubImgView
{
    for (UIView *tmpView in myScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    for (int i = 0; i <_thumbArray.count+1; i ++)
    {
        if (i == currentIndex)
        {
            continue;
        }
        
        TapImageView *tmpView = (TapImageView *)[tapCell viewWithTag:10 + i];
        
        //转换后的rect
        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
        
        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i*myScrollView.bounds.size.width,0,myScrollView.bounds.size}];
        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImage:tmpView.image];
        [myScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.i_delegate = self;
        
        [tmpImgScrollView setAnimationRect];
    }
}

- (void) setOriginFrame:(ImgScrollView *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        markView.alpha = 1.0;
    }];
}

#pragma mark -
#pragma mark - custom delegate
- (void) tappedWithObject:(id)sender
{
    [self.view bringSubviewToFront:scrollPanel];
    scrollPanel.alpha = 1.0;
    
    TapImageView *tmpView = sender;
    currentIndex = tmpView.tag - 10;
    
    tapCell = tmpView.identifier;
    
    //转换后的rect
    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
    
    CGPoint contentOffset = myScrollView.contentOffset;
    contentOffset.x = currentIndex*ScreenWidth;
    myScrollView.contentOffset = contentOffset;
    
    //添加
    [self addSubImgView];
    
    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){contentOffset,myScrollView.bounds.size}];
    [tmpImgScrollView setContentWithFrame:convertRect];
    [tmpImgScrollView setImage:tmpView.image];
    [myScrollView addSubview:tmpImgScrollView];
    tmpImgScrollView.i_delegate = self;
    
    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0.1];
}

- (void) tapImageViewTappedWithObject:(id)sender
{
    
    ImgScrollView *tmpImgView = sender;
    
    [UIView animateWithDuration:0.5 animations:^{
        markView.alpha = 0;
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        scrollPanel.alpha = 0;
    }];
    
}

#pragma mark -
#pragma mark - scroll delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

- (void)tableViews
{
    if (!_thumbArray)
    {
        _thumbArray=[NSArray array];
    }
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.125, ScreenWidth, ScreenHeight-ScreenWidth*0.125-64)style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor =Color(245, 245, 249);
    //    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    scrollPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight-64)];
    scrollPanel.backgroundColor = [UIColor clearColor];
    scrollPanel.alpha = 0;
    [self.view addSubview:scrollPanel];
    
    markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight-64)];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.2;
    [scrollPanel addSubview:markView];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight-64)];
    [scrollPanel addSubview:myScrollView];
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
    
    CGSize contentSize = myScrollView.contentSize;
    contentSize.height = self.view.bounds.size.height-64;
    contentSize.width = ScreenWidth * _thumbArray.count;
    myScrollView.contentSize = contentSize;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //#pragma mark-阻止cell数据的循环用这个
    //    UITableViewCell* cell =[tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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
    
    
    UIImageView *carPhoto =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.035, ScreenWidth*0.035, ScreenWidth*0.23, ScreenWidth*0.15)];
    //    carPhoto.backgroundColor  =[UIColor yellowColor];
    [carPhoto sd_setImageWithURL:[[_listArray objectAtIndex:indexPath.section] objectForKey:@"thumb"]];
    [cell.contentView addSubview:carPhoto];
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.3, ScreenWidth*0.035, ScreenWidth*0.23, ScreenWidth*0.05)];
    //    title.backgroundColor =[UIColor redColor];
    title.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section]objectForKey:@"models"]];
    [self label:title isBold:NO isFont:12.5f];
    [cell.contentView addSubview:title];
    
    
    
    
    
    float myWidth;
    myWidth=[UILabel width:title.text heightOfFatherView:title.frame.size.height textFont:title.font];
    title.frame =CGRectMake(ScreenWidth*0.07+ScreenWidth*0.23, ScreenWidth*0.055, myWidth, ScreenWidth*0.05);
    
    
    UILabel*chepai =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth*0.12+myWidth+ScreenWidth*0.23, ScreenWidth*0.06, ScreenWidth*0.06, ScreenWidth*0.038)];
    chepai.backgroundColor =Color(0, 170, 238);
    chepai.textColor =[UIColor whiteColor];
    [self label:chepai isBold:YES isFont:9.5f];
    chepai.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"plate"]];
    chepai.textAlignment =NSTextAlignmentCenter;
    [cell.contentView addSubview:chepai];
    
    
    float paiWidth;
    paiWidth=[UILabel width:chepai.text heightOfFatherView:chepai.frame.size.height textFont:chepai.font];
    chepai.frame =CGRectMake(ScreenWidth*0.105+myWidth+ScreenWidth*0.23, ScreenWidth*0.06, paiWidth+4, ScreenWidth*0.038);
    //星星在此
    NSString * xing =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"xing"]];
    if ([xing isEqualToString:@""]||[xing isKindOfClass:[NSNull class]]||xing ==nil)
    {
        xingji1 =0;
    }else
    {
        xingji1 = [xing intValue];
        
    }
    
    //***************************************************************//
    UIImageView *image0=[[UIImageView alloc]initWithFrame:CGRectMake(Height(70), Height(40), ScreenWidth*0.2, ScreenWidth*0.037)];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(Height(70)+ScreenWidth*0.037+5,  Height(40), ScreenWidth*0.2, ScreenWidth*0.037)];
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(Height(70)+2*(ScreenWidth*0.037+5),  Height(40), ScreenWidth*0.2, ScreenWidth*0.037)];
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(Height(70)+3*(ScreenWidth*0.037+5),  Height(40), ScreenWidth*0.2, ScreenWidth*0.037)];
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(Height(70)+4*(ScreenWidth*0.037+5),  Height(40), ScreenWidth*0.2, ScreenWidth*0.037)];
    
    [image0 setContentMode:UIViewContentModeScaleAspectFit];
    [image1 setContentMode:UIViewContentModeScaleAspectFit];
    [image2 setContentMode:UIViewContentModeScaleAspectFit];
    [image3 setContentMode:UIViewContentModeScaleAspectFit];
    [image4 setContentMode:UIViewContentModeScaleAspectFit];
    [cell.contentView addSubview:image0];
    [cell.contentView addSubview:image1];
    [cell.contentView addSubview:image2];
    [cell.contentView addSubview:image3];
    [cell.contentView addSubview:image4];
    
    //    PingLun *pl =[_newsArray objectAtIndex:indexPath.row];
    //    xingji1 =[pl.xingji intValue];
    
    if (xingji1 ==0)
    {
        [image0 setImage:[UIImage imageNamed:@"评分2"]];
        [image1 setImage:[UIImage imageNamed:@"评分2"]];
        [image2 setImage:[UIImage imageNamed:@"评分2"]];
        [image3 setImage:[UIImage imageNamed:@"评分2"]];
        [image4 setImage:[UIImage imageNamed:@"评分2"]];
    }
    if (xingji1==1)
    {
        [image0 setImage:[UIImage imageNamed:@"评分.png"]];
        [image1 setImage:[UIImage imageNamed:@"评分2"]];
        [image2 setImage:[UIImage imageNamed:@"评分2"]];
        [image3 setImage:[UIImage imageNamed:@"评分2"]];
        [image4 setImage:[UIImage imageNamed:@"评分2"]];
    }
    else if (xingji1==2)
    {
        [image0 setImage:[UIImage imageNamed:@"评分.png"]];
        [image1 setImage:[UIImage imageNamed:@"评分.png"]];
        [image2 setImage:[UIImage imageNamed:@"评分2"]];
        [image3 setImage:[UIImage imageNamed:@"评分2"]];
        [image4 setImage:[UIImage imageNamed:@"评分2"]];
    }
    else if (xingji1==3)
    {
        [image0 setImage:[UIImage imageNamed:@"评分.png"]];
        [image1 setImage:[UIImage imageNamed:@"评分.png"]];
        [image2 setImage:[UIImage imageNamed:@"评分.png"]];
        [image3 setImage:[UIImage imageNamed:@"评分2"]];
        [image4 setImage:[UIImage imageNamed:@"评分2"]];
    }
    else if (xingji1==4)
    {
        [image0 setImage:[UIImage imageNamed:@"评分.png"]];
        [image1 setImage:[UIImage imageNamed:@"评分.png"]];
        [image2 setImage:[UIImage imageNamed:@"评分.png"]];
        [image3 setImage:[UIImage imageNamed:@"评分.png"]];
        [image4 setImage:[UIImage imageNamed:@"评分2"]];
    }
    else if (xingji1==5)
    {
        [image0 setImage:[UIImage imageNamed:@"评分.png"]];
        [image1 setImage:[UIImage imageNamed:@"评分.png"]];
        [image2 setImage:[UIImage imageNamed:@"评分.png"]];
        [image3 setImage:[UIImage imageNamed:@"评分.png"]];
        [image4 setImage:[UIImage imageNamed:@"评分"]];
    }
     //****************************************************************//
    
    
    UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.035, ScreenWidth*(0.19+0.03), ScreenWidth-ScreenWidth*0.07, 1)];
    xian.backgroundColor=Color(225, 225, 225);
    [cell.contentView addSubview:xian];
    
    
    UILabel *content =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.035, ScreenWidth*(0.19+0.06)+1, ScreenWidth-ScreenWidth*0.07, ScreenWidth*0.1)];
    //    content.backgroundColor = [UIColor yellowColor];
    content .text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"content"]];
    content.numberOfLines =0;
    [self label:content  isBold:NO isFont:12.0f];
    content.textColor =Color(50, 50, 50);
    [cell.contentView addSubview:content];
    
    
//    float nowHeight =ScreenWidth*(0.19+0.03);
    
    
    if (content.text.length<1)
    {
        
        
        
    }
    else
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LINESPACE];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content.text length])];
        content.attributedText = attributedString;
        myHeight=[UILabel height:content.text widthOfFatherView:content.frame.size.width textFont:content.font];
        content.frame =CGRectMake(ScreenWidth*0.035, ScreenWidth*(0.19+0.06)+1, ScreenWidth-ScreenWidth*0.08, myHeight+10);
        
    }
    
    NSString * string =[[_listArray objectAtIndex:indexPath.section] objectForKey:@"thumbs"];
    _thumbArray =[string componentsSeparatedByString:@","];
    
    
    if (_thumbArray>0)
    {
        
        for (int i=0; i<_thumbArray.count; i++)
        {
            TapImageView *imageView=[[ TapImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.04+((ScreenWidth-45)/4+12)*i,myHeight+10+ScreenWidth*(0.19+0.095)+3, ScreenWidth*0.16, ScreenWidth*0.16)];
            //            NSURL *url =[NSURL URLWithString:[[_thumbArray objectAtIndex:i]objectForKey:@"url"]];
            imageView.layer.masksToBounds =YES;
            imageView.layer.cornerRadius =6.0f;
            imageView.t_delegate = self;
            imageView.tag = 10+i;
            
            
            [imageView sd_setImageWithURL:[_thumbArray objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"玛莎拉蒂.jpg"]];
            [cell.contentView addSubview:imageView];
            
            
        }
        if (_thumbArray.count ==1)
        {
            TapImageView *tmpView1 = (TapImageView *)[cell.contentView viewWithTag:10];
            tmpView1.identifier = cell;
        }
        if (_thumbArray.count ==2)
        {
            TapImageView *tmpView1 = (TapImageView *)[cell.contentView viewWithTag:10];
            TapImageView *tmpView2 = (TapImageView *)[cell.contentView viewWithTag:11];
            
            tmpView1.identifier = cell;
            tmpView2.identifier = cell;
            
        }if (_thumbArray.count ==3)
        {
            TapImageView *tmpView1 = (TapImageView *)[cell.contentView viewWithTag:10];
            TapImageView *tmpView2 = (TapImageView *)[cell.contentView viewWithTag:11];
            TapImageView *tmpView3 = (TapImageView *)[cell.contentView viewWithTag:12];
            tmpView1.identifier = cell;
            tmpView2.identifier = cell;
            tmpView3.identifier = cell;
        }else
        {
            TapImageView *tmpView1 = (TapImageView *)[cell.contentView viewWithTag:10];
            TapImageView *tmpView2 = (TapImageView *)[cell.contentView viewWithTag:11];
            TapImageView *tmpView3 = (TapImageView *)[cell.contentView viewWithTag:12];
            TapImageView *tmpView4 = (TapImageView *)[cell.contentView viewWithTag:13];
            tmpView1.identifier = cell;
            tmpView2.identifier = cell;
            tmpView3.identifier = cell;
            tmpView4.identifier = cell;
        }
    }
    
    
    
    float timeHeight =(ScreenWidth *0.64-ScreenWidth*0.1)+myHeight+20-30;
    
    UILabel * time =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.035, timeHeight, ScreenWidth*0.5, 30)];
    //    time.backgroundColor =[UIColor yellowColor];
    time.textColor =Color(100, 100, 100);
    time.text =[NSString stringWithFormat:@"%@",[[_listArray objectAtIndex:indexPath.section] objectForKey:@"inputtime"]];
    [self label:time isBold:NO isFont:11.0f];
    [cell.contentView addSubview:time];
    
    
    
    
    
    
    
    return cell;
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  (ScreenWidth *0.64-ScreenWidth*0.1)+myHeight+20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
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
