//
//  TXKomlinIMDistribution.h
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/2.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 空灵即时通讯分发服务 */
@interface TXKomlinIMDistribution : NSObject

/**
 *  分发
 *  @param parameters 参数
 */
+ (void)distributionWithParameters:(NSDictionary*)parameters;

/**
 *  分发服务器连接状态
 *  @param status 状态
 *  @param info 信息
 */
+ (void)distributionServerConnectStatus:(NSInteger)status info:(NSDictionary*)info;

/**
 *  分发登录状态
 *  @param status 状态
 *  @param info 信息
 */
+ (void)distributionLoginStatus:(NSInteger)status info:(NSDictionary*)info;

/**
 *  分发注册状态
 *  @param status 状态
 *  @param info 信息
 */
+ (void)distributionRegistrationStatus:(NSInteger)status info:(NSDictionary*)info;

/**
 *  分发接收消息
 *  @param message 消息
 *  @param info 信息
 */
+ (void)distributionReceiveMessage:(id)message info:(NSDictionary*)info;

/**
 *  分发发送状态
 *  @param message 消息
 *  @param info 信息
 */
+ (void)distributionSendStatus:(NSInteger)status message:(id)message info:(NSDictionary*)info;

/**
 *  分发意外断开连接
 *  @param status 连接状态
 *  @param info 信息
 *
 *  说明:连接状态为“0”表示断开连接
 *
 */
+ (void)distributionUnexpectedDisconnect:(NSInteger)status info:(NSDictionary*)info;

/**
 *  分发自动连接
 *  @param status 连接状态
 *  @param info 信息
 *
 *  说明:连接状态为“0”表示断开连接
 *
 */
+ (void)distributionAutoConnect:(NSInteger)status info:(NSDictionary*)info;

/**
 *  分发心跳
 *  @param info 信息
 */
+ (void)distributionHeartbeat:(NSDictionary*)info;

/**
 *  分发超时心跳
 *  @param info 信息
 */
+ (void)distributionTimeoutHeartbeat:(NSDictionary*)info;

@end

NS_ASSUME_NONNULL_END
