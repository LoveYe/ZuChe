

//
//  WMConversationListViewController.m
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "WMConversationListViewController.h"
#import "WMConversationViewController.h"
#import "AppDelegate.h"
#import "RCDataManager.h"
#import "RCCustomCell.h"
#import "UIImageView+WebCache.h"
#import "WMVideoMessage.h"
#import "NewsPageConreoller.h"
#import "Header.h"
#import "GiFHUD.h"
#import "HttpManager.h"
#import "ZCUserData.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonCrypto.h>


@interface WMConversationListViewController ()<RCIMReceiveMessageDelegate,RCIMConnectionStatusDelegate
,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UIImageView *_leftImageView;
    UIImageView *_imageview;
}

@end

@implementation WMConversationListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
        [RCIM sharedRCIM].receiveMessageDelegate = self;
        [RCIM sharedRCIM].connectionStatusDelegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"白背景.png"]  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [[RCDataManager shareManager] refreshBadgeValue];
    [self.conversationListTableView reloadData];
    
    
 
}

-(void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.conversationListTableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
-(void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
   // 此处添加刷新tableView数据的代码
    [refreshControl endRefreshing];
    [self.conversationListTableView reloadData];// 刷新tableView即可
}
//-(void)creatThreeButton {
//    
//    if (self.conversationListDataSource.count == 0) {
//        self.view.backgroundColor = [UIColor redColor];
//        _imageview = [[UIImageView alloc] initWithFrame:self.conversationListTableView.frame];
//        _imageview.image = [UIImage imageNamed:@"图1.jpg"];
//        [self.conversationListTableView.backgroundView removeFromSuperview];
//        self.conversationListTableView.backgroundView = _imageview;
//        [self.conversationListTableView reloadData];
//    }else {
//         [self.conversationListTableView.backgroundView reloadInputViews];
//        //         [self.conversationListTableView.backgroundView removeFromSuperview];
//        //        [_imageview removeFromSuperview];
//        _imageview = [[UIImageView alloc] initWithFrame:self.conversationListTableView.frame];
//        _imageview.image = [UIImage imageNamed:@"白背景.png"];
//        self.conversationListTableView.backgroundView = _imageview;
//       
//    }
//    
//}
/*!
 接收消息的回调方法
 *
 */
-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    NSLog(@" onRCIMReceiveMessage %@",message.content);
    [[RCDataManager shareManager] refreshBadgeValue];
    [self.conversationListTableView reloadData];
}
#pragma mark - RCIMConnectionStatusDelegate

/**
 *  网络状态变化。
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    NSLog(@"RCConnectionStatus = %ld",(long)status);
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"您的帐号已在别的设备上登录，\n您被迫下线！"
                              delegate:self
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [[RCIMClient sharedRCIMClient] disconnect:YES];
    }];
    
  
}
#pragma mark
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([ZCUserData share].isLogin == NO) {
        
        
    }else{
        [self creatleftRightButtonItems];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.conversationListTableView.tableFooterView = [UIView new];

        [self setupRefresh];
        [self zhijiedenglu];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alreadyLogin123:) name:@"eeeeeeeeee" object:nil];
    }
}


-(void)zhijiedenglu {
    [HttpManager postData:@{@"userid": [ZCUserData share].userId} andUrl:@"http://wx.leisurecarlease.com/tc.php?op=member" success:^(NSDictionary *fanhuicanshu) {
        //
        //获取Token的接口
        NSString *url = @"http://api.cn.ronghub.com/user/getToken.json";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        //在这post    userId 接口

        NSString  *userid = [ZCUserData share].userId;
        NSString  *username =  fanhuicanshu[@"arr"][@"nickname"];
        NSString *catTu = [NSString stringWithFormat:@"%@",fanhuicanshu[@"arr"][@"thumb"]];

        NSDictionary *dict = @{@"userId":userid,@"userName":username,@"portraiUri":catTu};
        NSString *appkey = @"kj7swf8ok47u2";
        NSString *nonce = [self getRandomNonce];
        NSString *timestamp = [self getTimestamp];
        NSString *signature = [self getSignatureWithAppSecret:@"Kv26rgnvLRR" nonce:nonce timestamp:timestamp];

        NSLog(@"-------%@",appkey);
        NSLog(@"-------%@",nonce);
        NSLog(@"--------%@",timestamp);
        NSLog(@"---------%@",signature);

        [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
        [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
        [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
        [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
        [manager.requestSerializer setValue:@"Kv26rgnvLRR" forHTTPHeaderField:@"appSecret"];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

            NSLog(@"%@",responseObject[@"token"]);
            //   [self initLoacalTestData];
            RCUserInfo *aUserInfo1 =[[RCUserInfo alloc]initWithUserId:userid name:username portrait:catTu QQ:@"" sex:@""];
            RCUserInfo *aUserInfo = aUserInfo1;
            NSString *token;
            if([aUserInfo.userId intValue] == [userid intValue]){
                token = responseObject[@"token"];
            }

            [self loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:aUserInfo.userId name:aUserInfo.name portrait:aUserInfo.portraitUri QQ:aUserInfo.QQ sex:aUserInfo.sex] withToken:token];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        NSLog(@"点我干啥");

    } Error:^(NSString *cuowuxingxi) {

    }];
}
-(void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo withToken:(NSString *)token{

    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor redColor];

        [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
        [[RCDataManager shareManager] refreshBadgeValue];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"status = %ld",(long)status);
    } tokenIncorrect:^{

        NSLog(@"token 错误");
    }];
    
}

-(NSString *)sha1WithKey:(NSString *)key
{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
//获取随机数
-(NSString *)getRandomNonce
{
    NSInteger randomValue = [self getRandomNumber:100000 to:999999];
    return  [NSString stringWithFormat:@"%ld",randomValue];
}
//获取时间戳 从1970年
-(NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval times =  [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",times];
}

//获取从 from 到  to 的随机数
-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}


//根据appSecret nonce timestamp 获取signature
-(NSString *)getSignatureWithAppSecret:(NSString *)appSecret nonce:(NSString *)nonce timestamp:(NSString *)timestamp
{
    NSString *sha1String = [NSString stringWithFormat:@"%@%@%@",appSecret,nonce,timestamp];
    return [self sha1WithKey:sha1String];
}

-(void)alreadyLogin123:(NSNotification *)notice{
   // [self.conversationListDataSource removeAllObjects];
    
    RCGroup *aGroupInfo =  [AppDelegate shareAppDelegate].groupsArray[0];
    WMConversationViewController *_conversationVC = [[WMConversationViewController alloc]init];
    _conversationVC.conversationType = ConversationType_GROUP;
    _conversationVC.targetId = aGroupInfo.groupId;
    _conversationVC.title = [NSString stringWithFormat:@"%@",aGroupInfo.groupName];
    
    [self.navigationController pushViewController:_conversationVC animated:YES];
    [self.conversationListTableView reloadData];
}
-(void)creatleftRightButtonItems {
    self.navigationItem.title = @"消息中心";
//    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//    left.frame = CGRectMake(0, 0, 100, 25);
//    left.tag = 100;
//    left.currentTitleColor = color(7,187,177);
//    [left setTitle:@"消息中心" forState:UIControlStateNormal];
//    [left addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];;
//    UIBarButtonItem *leftItem   = [[UIBarButtonItem alloc] initWithCustomView:left];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 60, 25);
    right.titleLabel.font = [UIFont systemFontOfSize:14];
    right.tag = 101;
    UIColor *c = Color(7, 187, 177);
    [right setTitleColor:c forState:UIControlStateNormal];
    [right setTitle:@"行程动态" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)fanhui:(UIButton * ) button {
    
    NSInteger butTag = button.tag-100;
    
    switch (butTag) {
        case 0:
            NSLog(@"点了左边");
            break;
        case 1: {
            NSLog(@"点了右边");
            NewsPageConreoller *new = [[NewsPageConreoller alloc] init];
            [self.navigationController pushViewController:new animated:YES];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark
#pragma mark 禁止右滑删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //可以从数据库删除数据
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];
        [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
        [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
        [self.conversationListTableView reloadData];
        [[RCDataManager shareManager] refreshBadgeValue];
}
//高度
-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}
//插入自定义会话model
-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        if(model.conversationType == ConversationType_PRIVATE){
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
    }
    return dataSource;
}
-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMdd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}
-(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
#pragma mark
#pragma mark onSelectedTableRow
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    //点击cell，拿到cell对应的model，然后从model中拿到对应的RCUserInfo，然后赋值会话属性，进入会话
    
    if (model.conversationType==ConversationType_PRIVATE) {//单聊
        WMConversationViewController *_conversationVC = [[WMConversationViewController alloc]init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        RCUserInfo *aUserInfo = [[RCDataManager shareManager] currentUserInfoWithUserId:model.targetId];
        _conversationVC.title =aUserInfo.name;
        [self.navigationController pushViewController:_conversationVC animated:YES];
        
    }else if (model.conversationType==ConversationType_GROUP){//群聊
        WMConversationViewController *_conversationVC = [[WMConversationViewController alloc]init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.title = model.conversationTitle;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }else if (model.conversationType==ConversationType_DISCUSSION){//讨论组
        WMConversationViewController *_conversationVC = [[WMConversationViewController alloc]init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.title = model.conversationTitle;
      //  _conversationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }else if (model.conversationType==ConversationType_CHATROOM){//聊天室
        
    }else if (model.conversationType==ConversationType_APPSERVICE){//客服
        
    }
}
-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.conversationListDataSource.count&&indexPath.row < self.conversationListDataSource.count) {
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//        [[RCDataManager shareManager] getUserInfoWithUserId:model.targetId completion:^(RCUserInfo *userInfo) {/Users/home/Desktop/RCIM-master/RCIM/ThirdLib/MBProgressHUD
//            NSLog(@"rcConversationListTableView 名字 ＝ %@  ID ＝ %@",userInfo.name,userInfo.userId);
//        }];
        NSInteger unreadCount = model.unreadMessageCount;
        RCCustomCell *cell = (RCCustomCell *)[[RCCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RCCustomCell"];
//
        cell.avatarIV.image = [UIImage imageNamed:@"图1.jpg"];
        cell.nameLabel.text = @"之前的车主";
        //cell.contentLabel.text = @"😆";
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.receivedTime/1000];
        NSString *timeString = [[self stringFromDate:date] substringToIndex:10];
        NSString *temp = [self getyyyymmdd];
        NSString *nowDateString = [NSString stringWithFormat:@"%@-%@-%@",[temp substringToIndex:4],[temp substringWithRange:NSMakeRange(4, 2)],[temp substringWithRange:NSMakeRange(6, 2)]];
        
        if ([timeString isEqualToString:nowDateString]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            NSString *showtimeNew = [formatter stringFromDate:date];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",showtimeNew];
            
        }else{
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",timeString];
        }
        cell.ppBadgeView.dragdropCompletion = ^{
            NSLog(@"VC = FFF ，ID ＝ %@",model.targetId);
    
            
            
            [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_PRIVATE targetId:model.targetId];
            model.unreadMessageCount = 0;
            NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
            
            long tabBarCount = ToatalunreadMsgCount-model.unreadMessageCount;
            
            if (tabBarCount > 0) {
                [AppDelegate shareAppDelegate].tabbarVC.selectedViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",tabBarCount];
                 [AppDelegate shareAppDelegate].secTabbarVC.selectedViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",tabBarCount];
            }
            else {
                [AppDelegate shareAppDelegate].tabbarVC.selectedViewController.tabBarItem.badgeValue = nil;
                [AppDelegate shareAppDelegate].secTabbarVC.selectedViewController.tabBarItem.badgeValue = nil;
            }
        };
        if (unreadCount==0) {
            cell.ppBadgeView.text = @"";
            
        }else{
            if (unreadCount>=100) {
                cell.ppBadgeView.text = @"99+";
            }else{
                cell.ppBadgeView.text = [NSString stringWithFormat:@"%li",(long)unreadCount];
                
            }
        }
        
        
        
        for (RCUserInfo *userInfo in [AppDelegate shareAppDelegate].friendsArray) {
            if ([model.targetId isEqualToString:userInfo.userId]) {
                
                cell.nameLabel.text = [NSString stringWithFormat:@"%@",userInfo.name];
                if ([userInfo.portraitUri isEqualToString:@""]||userInfo.portraitUri==nil) {
                    cell.avatarIV.image = [UIImage imageNamed:@"chatlistDefault"];
                    [cell.contentView bringSubviewToFront:cell.avatarIV];
                }else{
                    [cell.avatarIV sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"chatlistDefault"]];
                }
                
                if ([model.lastestMessage isKindOfClass:[RCTextMessage class]]) {
                    cell.contentLabel.text = [model.lastestMessage valueForKey:@"content"];
                    
                }else if ([model.lastestMessage isKindOfClass:[RCImageMessage class]]){
                    
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",myselfInfo.name];
                            
                        }
                    }else{
                        
                        cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",userInfo.name] ;
                    }
                    
                }else if ([model.lastestMessage isKindOfClass:[RCVoiceMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",myselfInfo.name];
                            
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",userInfo.name];
                    }
                }
                else if ([model.lastestMessage isKindOfClass:[RCLocationMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",userInfo.name];
                    }
                }
                else if ([model.lastestMessage isKindOfClass:[WMVideoMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的视频消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的视频消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的视频消息，点击查看",userInfo.name];
                    }
                }
                
            }
        }
        
        return cell;
    }
    else{
        
        return [[RCConversationBaseCell alloc]init];
    }
    
    
}


#pragma mark - 收到消息监听
-(void)didReceiveMessageNotification:(NSNotification *)notification{
    __weak typeof(&*self) blockSelf_ = self;
    //处理好友请求
    RCMessage *message = notification.object;
    
    if ([message.content isMemberOfClass:[RCMessageContent class]]) {
        if (message.conversationType == ConversationType_PRIVATE) {
            NSLog(@"好友消息要发系统消息！！！");
            @throw  [[NSException alloc] initWithName:@"error" reason:@"好友消息要发系统消息！！！" userInfo:nil];
        }
        RCConversationModel *customModel = [RCConversationModel new];
        //自定义cell的type
        customModel.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        customModel.senderUserId = message.senderUserId;
        customModel.lastestMessage = message.content;
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [blockSelf_ refreshConversationTableViewWithConversationModel:customModel];
            [super didReceiveMessageNotification:notification];
            [blockSelf_ resetConversationListBackgroundViewIfNeeded];
            [self notifyUpdateUnreadMessageCount];
                  
            //当消息为RCContactNotificationMessage时，没有调用super，如果是最后一条消息，可能需要刷新一下整个列表。
            //原因请查看super didReceiveMessageNotification的注释。
            
        });
        
    }else if (message.conversationType == ConversationType_PRIVATE){
        //获取接受到会话
        RCConversation *receivedConversation = [[RCIMClient sharedRCIMClient] getConversation:message.conversationType targetId:message.targetId];
         
        //转换新会话为新会话模型
        RCConversationModel *customModel = [[RCConversationModel alloc] init:RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION conversation:receivedConversation extend:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [blockSelf_ refreshConversationTableViewWithConversationModel:customModel];
            //[super didReceiveMessageNotification:notification];
            [blockSelf_ resetConversationListBackgroundViewIfNeeded];
            [self notifyUpdateUnreadMessageCount];
            
            //当消息为RCContactNotificationMessage时，没有调用super，如果是最后一条消息，可能需要刷新一下整个列表。
            //原因请查看super didReceiveMessageNotification的注释。
            NSNumber *left = [notification.userInfo objectForKey:@"left"];
            if (0 == left.integerValue) {
                [super refreshConversationTableViewIfNeeded];
            }
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            调用父类刷新未读消息数
            [super didReceiveMessageNotification:notification];
            [blockSelf_ resetConversationListBackgroundViewIfNeeded];
            [self notifyUpdateUnreadMessageCount];
            
            //        super会调用notifyUpdateUnreadMessageCount
        });
    }
    [[RCDataManager shareManager] getUserInfoWithUserId:message.senderUserId completion:^(RCUserInfo *userInfo) {
        NSLog(@"didReceiveMessageNotification 名字 ＝ %@  ID ＝ %@",userInfo.name,userInfo.userId);
    }];
    [self refreshConversationTableViewIfNeeded];
    [self.conversationListTableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.conversationListDataSource.count;
}
- (void)showEmptyConversationView{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
