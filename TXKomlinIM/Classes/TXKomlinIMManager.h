//
//  TXKomlinIMManager.h
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/1.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "TXKomlinIMConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

/** 服务器连接状态 */
typedef NS_ENUM(NSInteger,TXKomlinIMConnectStatus){
    /** 默认 */
    TXKomlinIMConnectStatusNormal                        =0,
    /** 正在连接服务器... */
    TXKomlinIMConnectStatusConnectingToServer            =1,
    /** 服务器连接失败 */
    TXKomlinIMConnectStatusConnectionFailure             =2,
    /** 服务器连接超时 */
    TXKomlinIMConnectStatusConnectionTimedOut            =3,
    /** 服务器连接成功 */
    TXKomlinIMConnectStatusServerConnectionSucceeded     =4,
    /** 断开连接或连接失败 */
    TXKomlinIMConnectStatusDisconnectedOrFailedToConnect =5,
};

/** 登录状态 */
typedef NS_ENUM(NSInteger,TXKomlinIMLoginStatus){
    /** 默认 */
    TXKomlinIMLoginStatusNormal            =0,
    /** 正在登录... */
    TXKomlinIMLoginStatusLoggingIn         =1,
    /** 登录成功 */
    TXKomlinIMLoginStatusLoginSuccessful   =2,
    /** 登录失败 */
    TXKomlinIMLoginStatusLoginFailed       =3,
};

/** 注册状态 */
typedef NS_ENUM(NSInteger,TXKomlinIMRegistrationStatus){
    /** 默认 */
    TXKomlinIMRegistrationStatusNormal               =0,
    /** 正在注册... */
    TXKomlinIMRegistrationStatusRegistering          =1,
    /** 注册成功 */
    TXKomlinIMRegistrationStatusRegistrationSuccess  =2,
    /** 注册失败 */
    TXKomlinIMRegistrationStatusRegistrationFailed   =3,
};

/** 发送状态 */
typedef NS_ENUM(NSInteger,TXKomlinIMSendStatus){
    /** 默认 */
    TXKomlinIMSendStatusNormal      =0,
    /** 正在发送... */
    TXKomlinIMSendStatusSending     =1,
    /** 发送成功 */
    TXKomlinIMSendStatusSuccess     =2,
    /** 发送失败 */
    TXKomlinIMSendStatusFailedSend  =3,
};

/**
 *  简介:杭州空灵智能科技有限公司基于XMPP开发的即时通讯功能
 */
@interface TXKomlinIMManager : NSObject

/**
 *  即时通讯管理器
 */
+ (TXKomlinIMManager*)manager;

/**
 *  空灵即时通讯配置文件
 *
 *  配置说明:1.服务器地址 2.服务器端口 3.域名 4.源
 */
@property (nonatomic,strong,readonly)TXKomlinIMConfiguration *configuration;

/**
 *  xmpp 通信管道(就像是电话中的电话线)
 *
 *  说明:通信管道的另一端是服务器
 *
 */
@property (nonatomic,strong,readonly)XMPPStream *stream;

/**
 *  断线重连
 *
 *  说明:1.可监听有无网络 2.有网络时自动重连
 *
 */
@property (nonatomic,strong,readonly)XMPPReconnect *reconnect;

/**
 *  心跳包
 *
 *  说明:就像人类的心跳“咚、咚、咚”跳动一样
 *
 */
@property (nonatomic,strong,readonly)XMPPAutoPing *autoPing;

/**
 *  myJID 用户身份
 *
 *  说明:登录或注册时可获取
 *
 */
@property (nonatomic,strong,readonly)XMPPJID *myJID;

/**
 *  连接状态
 */
@property (nonatomic,assign,readonly)TXKomlinIMConnectStatus connectStatus;

/**
 *  登录状态
 */
@property (nonatomic,assign,readonly)TXKomlinIMLoginStatus loginStatus;

/**
 *  注册状态
 */
@property (nonatomic,assign,readonly)TXKomlinIMRegistrationStatus registrationStatus;

/**
 *  发送状态
 */
@property (nonatomic,assign,readonly)TXKomlinIMSendStatus sendStatus;

/**
 *  快速登录即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)logInWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password;

/**
 *  快速登录即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)logInWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password;

/**
 *  设置登录即时通讯用户名以及登录密码
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)setLogInUserName:(NSString* _Nonnull)userName setLogInPassword:(NSString* _Nonnull)password;

/**
 *  设置登录即时通讯用户名以及登录密码
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)setLogInUserName:(NSString* _Nonnull)userName setLogInPassword:(NSString* _Nonnull)password;

/**
 *  快速注册即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)registeredWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password;

/**
 *  快速注册即时通讯
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)registeredWithUserName:(NSString* _Nonnull)userName password:(NSString* _Nonnull)password;

/**
 *  设置注册即时通讯用户名以及密码
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)setRegisteredUserName:(NSString* _Nonnull)userName setRegisteredPassword:(NSString* _Nonnull)password;

/**
 *  设置注册即时通讯用户名以及密码
 *  @param userName 用户名
 *  @param password 密码
 */
+ (void)setRegisteredUserName:(NSString* _Nonnull)userName setRegisteredPassword:(NSString* _Nonnull)password;

/**
 *  发送消息
 *  @param message 消息
 */
- (void)sendMessageWithMessage:(XMPPMessage* _Nonnull)message;

/**
 *  发送消息
 *  @param message 消息
 */
+ (void)sendMessageWithMessage:(XMPPMessage* _Nonnull)message;

/** 断开连接 */
- (void)disConnect;

/** 断开连接 */
+ (void)disConnect;

/**
 *  注册
 *
 *  说明:使用该方法时,先要调用“setRegisteredUserName:setRegisteredPassword:”方法才能生效
 *
 */
- (void)registered;

/**
 *  注册
 *
 *  说明:使用该方法时,先要调用“setRegisteredUserName:setRegisteredPassword:”方法才能生效
 *
 */
+ (void)registered;

/**
 *  登录
 *
 *  说明:使用该方法时,先要调用“setLogInUserName:setLogInPassword:”方法才能生效
 *
 */
- (void)logIn;

/**
 *  登录
 *
 *  说明:使用该方法时,先要调用“setLogInUserName:setLogInPassword:”方法才能生效
 *
 */
+ (void)logIn;

/** 登出 */
- (void)signOut;

/** 登出 */
+ (void)signOut;

/** 上线 */
- (void)online;

/** 上线 */
+ (void)online;

/** 下线 */
- (void)Offline;

/** 下线 */
+ (void)Offline;

@end

NS_ASSUME_NONNULL_END
