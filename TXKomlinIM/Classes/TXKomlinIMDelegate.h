//
//  TXKomlinIMDelegate.h
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/2.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXKomlinIMManager.h"
@class TXKomlinIMDelegate;

NS_ASSUME_NONNULL_BEGIN

/**
 *  空灵即时通讯代理协议
 *
 *  说明:1.可监听服务器连接状态 2.可监听登录状态 3.可监听注册状态 4.可监听接收消息 5.可监听发送状态 6.可监听意外断开连接...
 *
 */
@protocol TXKomlinIMDelegate <NSObject>

@optional
/**
 *  服务器连接状态
 *  @param delegate 代理对象
 *  @param serverConnectStatus 服务器连接状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate serverConnectStatus:(TXKomlinIMConnectStatus)serverConnectStatus info:(NSDictionary*)info;

/**
 *  登录状态
 *  @param delegate 代理对象
 *  @param loginStatus 登录状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate loginStatus:(TXKomlinIMLoginStatus)loginStatus info:(NSDictionary*)info;

/**
 *  注册状态
 *  @param delegate 代理对象
 *  @param registrationStatus 注册状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate registrationStatus:(TXKomlinIMLoginStatus)registrationStatus info:(NSDictionary*)info;

/**
 *  接收消息
 *  @param delegate 代理对象
 *  @param message 消息
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate message:(XMPPMessage*)message info:(NSDictionary*)info;

/**
 *  发送状态
 *  @param delegate 代理对象
 *  @param message 消息
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate sendStatus:(TXKomlinIMSendStatus)sendStatus message:(XMPPMessage*)message info:(NSDictionary*)info;

/**
 *  意外断开连接
 *  @param delegate 代理对象
 *  @param unexpectedDisconnectStatus 状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate unexpectedDisconnectStatus:(NSInteger)unexpectedDisconnectStatus info:(NSDictionary*)info;

/**
 *  自动连接
 *  @param delegate 代理对象
 *  @param autoConnectStatus 状态
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate autoConnectStatus:(NSInteger)autoConnectStatus info:(NSDictionary*)info;

/**
 *  心跳
 *  @param delegate 代理对象
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate heartbeat:(NSDictionary*)info;

/**
 *  超时心跳
 *  @param delegate 代理对象
 *  @param info 信息
 */
- (void)komlinIMDelegate:(TXKomlinIMDelegate*)delegate timeoutHeartbeat:(NSDictionary*)info;

@end

/**
 *  空灵即时通讯代理
 *
 *  说明:1.可监听服务器连接状态 2.可监听登录状态 3.可监听注册状态 4.可监听接收消息 5.可监听发送状态
 *
 */
@interface TXKomlinIMDelegate : NSObject
/** 即时通讯管理器 */
@property (nonatomic,strong,readonly)TXKomlinIMManager *manager;
/** 代理属性 */
@property (nonatomic,weak)id<TXKomlinIMDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
