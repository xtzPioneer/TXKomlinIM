//
//  TXKomlinIMManager.m
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/1.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXKomlinIMManager.h"
#import "TXKomlinIMConst.h"
#import "TXKomlinIMDistribution.h"

/** DEBUG 打印日志 */
#if DEBUG
#define TXKOMLINIMLog(s, ... ) NSLog( @"<FileName:%@ InThe:%d Line> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXMGJROUTERLog(s, ... )
#endif

/** 连接类型 */
typedef NS_ENUM(NSInteger,TXKomlinIMConnectType){
    /** 默认 */
    TXKomlinIMConnectTypeNormal     =0,
    /** 注册 */
    TXKomlinIMConnectTypeRegistered =1,
    /** 登录 */
    TXKomlinIMConnectTypeLogIn      =2,
};

@interface TXKomlinIMManager ()<XMPPStreamDelegate,XMPPReconnectDelegate,XMPPAutoPingDelegate>
/**
 *  记录连接的类型
 */
@property (nonatomic,assign)TXKomlinIMConnectType connectType;

/**
 *  记录登录密码
 */
@property (nonatomic,copy,readonly)NSString *logInPassword;

/**
 *  记录注册密码
 */
@property (nonatomic,copy,readonly)NSString *registeredPassword;

/**
 *  登录用户
 */
@property (nonatomic,copy,readonly)NSString *logInUserName;

/**
 *  注册用户
 */
@property (nonatomic,copy,readonly)NSString *registeredUserName;
@end

@implementation TXKomlinIMManager

#pragma mark- 即时通讯管理器

/**
 *  即时通讯管理器
 */
+ (TXKomlinIMManager*)manager{
    static TXKomlinIMManager *managerInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerInstance=[[super allocWithZone:nil] init];
    });
    return managerInstance;
}

/** 重写系统allocWithZone方法,确保唯一性 */
+ (id)allocWithZone:(NSZone *)zone{
    return [TXKomlinIMManager manager];
}

/** 重写系统copyWithZone方法,确保唯一性 */
- (id)copyWithZone:(NSZone *)zone{
    return [TXKomlinIMManager manager];
}

/** 重写系统mutableCopyWithZone方法,确保唯一性 */
- (id)mutableCopyWithZone:(NSZone *)zone{
    return [TXKomlinIMManager manager];
}

#pragma mark- 重写系统init方法

/** 重写系统init方法 */
- (instancetype)init{
    if (self = [super init]) {
        
        // 创建stream
        self.stream=[[XMPPStream alloc] init];
        // 初始化配置
        self.configuration=[[TXKomlinIMConfiguration alloc]init];
        // 设置通信管道的目标服务器地址
        self.stream.hostName=self.configuration.komlinIMServerAddress;
        // 设置目标服务器的端口
        self.stream.hostPort=self.configuration.komlinIMServerPort;
        // 允许后台运行(iOS 10 之后改变了方法)
        self.stream.enableBackgroundingOnSocket=YES;
        // 设置代理,在主线程里面触发回调事件
        [self.stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        // 创建心跳包
        self.autoPing=[[XMPPAutoPing alloc] init];
        // 心跳包间隔
        self.autoPing.pingInterval=self.configuration.pingInterval;
        // 激活心跳包
        [self.autoPing activate:self.stream];
        // 设置心跳包代理
        [self.autoPing addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        // 创建自动重连对象
        self.reconnect=[[XMPPReconnect alloc] initWithDispatchQueue:dispatch_get_main_queue()];
        // 启用自动重连
        [self.reconnect setAutoReconnect:YES];
        // 重新连接延迟时间
        self.reconnect.reconnectDelay=self.configuration.reconnectDelay;;
        // 自动重连时间间隔
        self.reconnect.reconnectTimerInterval=self.configuration.reconnectTimerInterval;
        // 激活自动重连模块，一定要加这句代码否则不会执行
        [self.reconnect activate:self.stream];
        // 添加自动重连代理
        [self.reconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
        // 手动启动
        [self.reconnect manualStart];
    
    }
    return self;
}

#pragma mark- 设置相关属性

/** 设置登录名 */
- (void)setLogInUserName:(NSString *)logInUserName{
    _logInUserName=logInUserName;
}

/** 设置登录密码 */
- (void)setLogInPassword:(NSString *)logInPassword{
    _logInPassword=logInPassword;
}

/** 设置注册名 */
- (void)setRegisteredUserName:(NSString *)registeredUserName{
    _registeredUserName=registeredUserName;
}

/** 设置注册密码 */
- (void)setRegisteredPassword:(NSString *)registeredPassword{
    _registeredPassword=registeredPassword;
}

/** 设置stream */
- (void)setStream:(XMPPStream * _Nonnull)stream{
    _stream=stream;
}

/** 设置断线重连 */
- (void)setReconnect:(XMPPReconnect * _Nonnull)reconnect{
    _reconnect=reconnect;
}

/** 设置心跳包 */
- (void)setAutoPing:(XMPPAutoPing * _Nonnull)autoPing{
    _autoPing=autoPing;
}

/** 设置用户身份 */
- (void)setMyJID:(XMPPJID *)myJID{
    _myJID=myJID;
}

/** 设置配置 */
- (void)setConfiguration:(TXKomlinIMConfiguration * _Nonnull)configuration{
    _configuration=configuration;
}

/** 设置连接状态 */
- (void)setConnectStatus:(TXKomlinIMConnectStatus )connectStatus{
    _connectStatus=connectStatus;
}

/** 设置登录状态 */
- (void)setLoginStatus:(TXKomlinIMLoginStatus)loginStatus{
    _loginStatus=loginStatus;
}

/** 设置注册状态 */
- (void)setRegistrationStatus:(TXKomlinIMRegistrationStatus)registrationStatus{
    _registrationStatus=registrationStatus;
}

/** 设置发送状态 */
- (void)setSendStatus:(TXKomlinIMSendStatus)sendStatus{
    _sendStatus=sendStatus;
}

#pragma mark- 登录即时通讯

/**
 *  快速登录即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)logInWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password{
    [self setLogInUserName:userName setLogInPassword:password];
    [self logIn];
}

/**
 *  快速登录即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)logInWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password{
    [[self manager] logInWithUserName:userName password:password];
}


/**
 *  设置登录即时通讯用户名以及登录密码
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)setLogInUserName:(NSString* _Nonnull)userName setLogInPassword:(NSString* _Nonnull)password{
    // 记录登录用户
    self.logInUserName=userName;
    // 记录登录密码
    self.logInPassword=password;
}

/**
 *  设置登录即时通讯用户名以及登录密码
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)setLogInUserName:(NSString* _Nonnull)userName setLogInPassword:(NSString* _Nonnull)password{
    [[self manager] setLogInUserName:userName setLogInPassword:password];
}

#pragma mark- 注册即时通讯

/**
 *  快速注册即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)registeredWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password{
    [self setRegisteredUserName:userName setRegisteredPassword:password];
    [self registered];
}

/**
 *  快速注册即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)registeredWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password{
    [[self manager] registeredWithUserName:userName password:password];
}

/**
 *  设置注册即时通讯用户名以及密码
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)setRegisteredUserName:(NSString* _Nonnull)userName setRegisteredPassword:(NSString* _Nonnull)password{
    // 记录注册用户
    self.registeredUserName=userName;
    // 记录注册密码
    self.registeredPassword=password;
}

/**
 *  设置注册即时通讯用户名以及密码
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)setRegisteredUserName:(NSString* _Nonnull)userName setRegisteredPassword:(NSString* _Nonnull)password{
    [[self manager] setRegisteredUserName:userName setRegisteredPassword:password];
}

#pragma mark- 连接服务器

/**
 *  连接服务器
 *
 *  说明:xmpp协议规定,连接时可以不告诉服务器密码,但是一定要告诉服务器是谁在连接它
 *
 */
- (void)connectWithUserName:(NSString * _Nonnull)userName{
    // 根据一个用户名构造一个xmppjid
    self.myJID=[XMPPJID jidWithUser:userName domain:self.configuration.komlinIMDomain resource:self.configuration.komlinIMResource];
    // 设置通信管道的jid
    self.stream.myJID=self.myJID;
    // 连接服务器
    [self connectServer];
}

/** 连接服务器 */
- (void)connectServer{
    // 先判断一下是否链接过服务器
    if ([self.stream isConnected] || [self.stream isConnecting]) [self disConnect];
    // 发起连接
    NSError *error=nil;
    BOOL result=[self.stream connectWithTimeout:30.0f error:&error];
    if (result) {
        // 更新连接状态
        self.connectStatus=TXKomlinIMConnectStatusConnectingToServer;
        // 分发连接状态
        NSMutableDictionary *info=[NSMutableDictionary dictionary];
        [info setValue:self forKey:TXKomlinIMManagerObjectKey];
        [TXKomlinIMDistribution distributionServerConnectStatus:self.connectStatus info:info];
        TXKOMLINIMLog(@"正在连接服务器...");
    }else{
        // 更新连接状态
        self.connectStatus=TXKomlinIMConnectStatusConnectionFailure;
        // 分发连接状态
        NSMutableDictionary *info=[NSMutableDictionary dictionary];
        [info setValue:self forKey:TXKomlinIMManagerObjectKey];
        [info setValue:error forKey:TXKomlinIMErrorObjectKey];
        [TXKomlinIMDistribution distributionServerConnectStatus:self.connectStatus info:info];
        TXKOMLINIMLog(@"连接服务器失败:%@",error);
    }
}

#pragma mark- 连接服务器成功或失败回调

/** 连接服务器成功的回调方法 */
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    // 更新连接状态
    self.connectStatus=TXKomlinIMConnectStatusServerConnectionSucceeded;
    // 分发连接状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionServerConnectStatus:self.connectStatus info:info];
    TXKOMLINIMLog(@"服务器连接成功");
    // 连接成功后的操作
    switch (self.connectType) {
        case TXKomlinIMConnectTypeLogIn:{
            // 更新登录状态
            self.loginStatus=TXKomlinIMLoginStatusLoggingIn;
            // 分发登录状态
            NSMutableDictionary *info=[NSMutableDictionary dictionary];
            [info setValue:self forKey:TXKomlinIMManagerObjectKey];
            [TXKomlinIMDistribution distributionLoginStatus:self.loginStatus info:info];
            // 在连接成功后登录
            NSError *error=nil;
            [self.stream authenticateWithPassword:self.logInPassword error:&error];
            TXKOMLINIMLog(@"%@正在登录...",self.logInUserName);
        }
            break;
        case TXKomlinIMConnectTypeRegistered:{
            // 更新注册状态
            self.registrationStatus=TXKomlinIMRegistrationStatusRegistering;
            // 分发注册状态
            NSMutableDictionary *info=[NSMutableDictionary dictionary];
            [info setValue:self forKey:TXKomlinIMManagerObjectKey];
            [TXKomlinIMDistribution distributionRegistrationStatus:self.registrationStatus info:info];
            // 在连接成功后注册
            NSError *error=nil;
            [self.stream registerWithPassword:self.registeredPassword error:&error];
            TXKOMLINIMLog(@"%@正在注册...",self.registeredUserName);
        }
            break;
        default:
            break;
    }
}

/** 连接超时的回调方法 */
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    // 更新连接状态
    self.connectStatus=TXKomlinIMConnectStatusConnectionTimedOut;
    // 分发连接状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionServerConnectStatus:self.connectStatus info:info];
    TXKOMLINIMLog(@"连接超时");
}

#pragma mark- 断开连接或连接失败回调

/** 断开连接或连接失败的回调方法 */
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    // 更新连接状态
    self.connectStatus=TXKomlinIMConnectStatusDisconnectedOrFailedToConnect;
    // 分发连接状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [info setValue:error forKey:TXKomlinIMErrorObjectKey];
    [TXKomlinIMDistribution distributionServerConnectStatus:self.connectStatus info:info];
    TXKOMLINIMLog(@"断开连接或连接失败:%@",error);
    // 下线
    [self Offline];
}

#pragma mark- 登录成功或失败回调

/** 登录成功的回调 */
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    // 更新登录状态
    self.loginStatus=TXKomlinIMLoginStatusLoginSuccessful;
    // 分发登录状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionLoginStatus:self.loginStatus info:info];
    // 上线
    [self online];
    TXKOMLINIMLog(@"%@登录成功",self.logInUserName);
}
/** 登录失败的回调 */
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    // 更新登录状态
    self.loginStatus=TXKomlinIMLoginStatusLoginFailed;
    // 分发登录状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [info setValue:error forKey:TXKomlinIMErrorObjectKey];
    [TXKomlinIMDistribution distributionLoginStatus:self.loginStatus info:info];
    TXKOMLINIMLog(@"%@登录失败:%@",self.logInUserName,error);
}

#pragma mark- 注册成功或失败回调

/** 注册成功的回调 */
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    // 更新注册状态
    self.registrationStatus=TXKomlinIMRegistrationStatusRegistrationSuccess;
    // 分发注册状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionRegistrationStatus:self.registrationStatus info:info];
    TXKOMLINIMLog(@"%@注册成功",self.registeredUserName);
}

/** 注册失败的回调 */
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    // 更新注册状态
    self.registrationStatus=TXKomlinIMRegistrationStatusRegistrationFailed;
    // 分发注册状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [info setValue:error forKey:TXKomlinIMErrorObjectKey];
    [TXKomlinIMDistribution distributionRegistrationStatus:self.registrationStatus info:info];
    TXKOMLINIMLog(@"%@注册失败:%@",self.registeredUserName,error);
}

#pragma mark- 收到消息回调

/** 收到消息的回调 */
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    // 分发接收信息
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionReceiveMessage:message info:info];
    TXKOMLINIMLog(@"收到消息:%@",message);
}

#pragma mark- 发送消息成功或失败回调

/** 发送消息成功 */
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    // 更新发送状态
    self.sendStatus=TXKomlinIMSendStatusSuccess;
    // 分发发送状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionSendStatus:self.sendStatus message:message info:info];
    TXKOMLINIMLog(@"消息发送成功:%@",message);
}

/** 发送消息失败 */
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error{
    // 更新发送状态
    self.sendStatus=TXKomlinIMSendStatusFailedSend;
    // 分发发送状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [info setValue:error forKey:TXKomlinIMErrorObjectKey];
    [TXKomlinIMDistribution distributionSendStatus:self.sendStatus message:message info:info];
    TXKOMLINIMLog(@"消息发送失败:%@ error:%@",message,error);
}

#pragma mark- 发送消息

/**
 *  发送消息
 *  @param message 消息
 */
+ (void)sendMessageWithMessage:(XMPPMessage* _Nonnull)message{
    [[self manager] sendMessageWithMessage:message];
}

/**
 *  发送消息
 *  @param message 消息
 */
- (void)sendMessageWithMessage:(XMPPMessage* _Nonnull)message{
    // 更新发送状态
    self.sendStatus=TXKomlinIMSendStatusSending;
    // 分发发送状态
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionSendStatus:self.sendStatus message:message info:info];
    // 发送消息
    [self.stream sendElement:message];
}

#pragma mark- 断线重连

/** 自动连接 */
-(BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkConnectionFlags)connectionFlags{
    // 分发自动连接
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionAutoConnect:connectionFlags info:info];
    return YES;
}

/** 检测到意外断开连接 */
-(void)xmppReconnect:(XMPPReconnect *)sender didDetectAccidentalDisconnect:(SCNetworkConnectionFlags)connectionFlags{
    // 分发意外断开连接
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionUnexpectedDisconnect:connectionFlags info:info];
}

#pragma mark- 心跳

/** 心跳 */
- (void)xmppAutoPingDidReceivePong:(XMPPAutoPing *)sender{
    // 分发心跳
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionHeartbeat:info];
}

/** 超时心跳 */
- (void)xmppAutoPingDidTimeout:(XMPPAutoPing *)sender {
    // 分发超时心跳
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setValue:self forKey:TXKomlinIMManagerObjectKey];
    [TXKomlinIMDistribution distributionTimeoutHeartbeat:info];
}

#pragma mark- 断开连接

/** 断开连接 */
- (void)disConnect{
    [self Offline];
    [self.stream disconnect];
}

/** 断开连接 */
+ (void)disConnect{
    [[self manager] disConnect];
}

#pragma mark- 注册

/**
 *  注册
 *
 *  说明:使用该方法时,先要调用“setRegisteredUserName:setRegisteredPassword:”方法才能生效
 *
 */
- (void)registered{
    // 记录连接类型
    self.connectType=TXKomlinIMConnectTypeRegistered;
    // 连接
    [self connectWithUserName:self.registeredUserName];
}

/**
 *  注册
 *
 *  说明:使用该方法时,先要调用“setRegisteredUserName:setRegisteredPassword:”方法才能生效
 *
 */
+ (void)registered{
    [[self manager] registered];
}

#pragma mark- 登录

/** 登录 */
- (void)logIn{
    // 记录连接类型
    self.connectType=TXKomlinIMConnectTypeLogIn;
    // 连接
    [self connectWithUserName:self.logInUserName];
}

/** 登录 */
+ (void)logIn{
    [[self manager] logIn];
}

#pragma mark- 登出

/** 登出 */
- (void)signOut{
    // 清空登录名
    self.logInUserName=nil;
    // 清空登录密码
    self.logInPassword=nil;
    // 清空注册名
    self.registeredUserName=nil;
    // 清空注册密码
    self.registeredPassword=nil;
    // 清空自己的JID
    self.myJID=nil;
    // 设置连接类型为默认
    self.connectType=TXKomlinIMConnectTypeNormal;
    // 设置连接状态为默认
    self.connectStatus=TXKomlinIMConnectStatusNormal;
    // 设置登录状态为默认
    self.loginStatus=TXKomlinIMLoginStatusNormal;
    // 设置注册状态为默认
    self.registrationStatus=TXKomlinIMRegistrationStatusNormal;
    // 下线
    [self Offline];
    // 断开连接
    [self.stream disconnectAfterSending];
}

/** 登出 */
+ (void)signOut{
    [[self manager] signOut];
}

#pragma mark- 上线

/** 上线 */
- (void)online{
    // 上线通知
    XMPPPresence *presence=[XMPPPresence presenceWithType:TXKomlinIMAvailableKey];
    // 发送上线通知
    [self.stream sendElement:presence];
}

/** 上线 */
+ (void)online{
    [[self manager] online];
}

#pragma mark- 下线

/** 下线 */
- (void)Offline{
    // 下线通知
    XMPPPresence *presence=[XMPPPresence presenceWithType:TXKomlinIMUnavailableKey];
    // 发送下线通知
    [self.stream sendElement:presence];
}

/** 下线 */
+ (void)Offline{
    [[self manager] Offline];
}

@end
