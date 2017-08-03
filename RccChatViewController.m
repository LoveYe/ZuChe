//
//  RccChatViewController.m
//  testAppView
//
//  Created by home on 2017/3/23.
//  Copyright © 2017年 home. All rights reserved.
//

#import "RccChatViewController.h"
#import "AppDelegate.h"

@interface RccChatViewController ()<RCIMUserInfoDataSource>{
    NSMutableArray *_dataArray;
}

@end

@implementation RccChatViewController


-(id)init {
    self = [super init];
    if (self) {
        //设置需要显示哪些类型的会话
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        //设置需要将哪些类型的会话在会话列表中聚合显示
      //  [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                            //  @(ConversationType_GROUP)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _dataArray  = [NSMutableArray new];
//    _dataArray = [AppDelegate shareAppDelegate].friendsArray;
    // Do any additional setup after loading the view.
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"租客";
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
}
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    
    if ([userId isEqualToString:@"15502196946"]) {
        
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = userId;
        user.name =  @"客服";
        user.portraitUri = @"http://wx.leisurecarlife.com/uploadfile/2017/0612/20170612070927166.png";
        return completion(user);
    }
    return completion(nil);
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
