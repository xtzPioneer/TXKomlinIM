//
//  TXKomlinIMDistribution.m
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/2.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXKomlinIMDistribution.h"
#import "TXKomlinIMConst.h"

@implementation TXKomlinIMDistribution

/**
 *  分发
 *  @param parameters 参数
 */
+ (void)distributionWithParameters:(NSDictionary*)parameters{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:TXKomlinIMDistributionNotification object:nil userInfo:parameters];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:TXKomlinIMDistributionNotification object:nil];
    });
}

/**
 *  分发服务器连接状态
 *  @param status 状态
 *  @param info 信息
 */
+ (void)distributionServerConnectStatus:(NSInteger)status info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:[NSNumber numberWithInteger:status] forKey:TXKomlinIMStatusKey];
    [parameters setValue:TXKomlinIMDistributionServerConnectStatusKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发登录状态
 *  @param status 状态
 *  @param info 信息
 */
+ (void)distributionLoginStatus:(NSInteger)status info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:[NSNumber numberWithInteger:status] forKey:TXKomlinIMStatusKey];
    [parameters setValue:TXKomlinIMDistributionLoginStatusKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发注册状态
 *  @param status 状态
 *  @param info 信息
 */
+ (void)distributionRegistrationStatus:(NSInteger)status info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:[NSNumber numberWithInteger:status] forKey:TXKomlinIMStatusKey];
    [parameters setValue:TXKomlinIMDistributionRegistrationStatusKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发接收消息
 *  @param message 消息
 *  @param info 信息
 */
+ (void)distributionReceiveMessage:(id)message info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:message forKey:TXKomlinIMMessageObjectKey];
    [parameters setValue:TXKomlinIMDistributionReceiveMessageKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发发送状态
 *  @param message 消息
 *  @param info 信息
 */
+ (void)distributionSendStatus:(NSInteger)status message:(id)message info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:[NSNumber numberWithInteger:status] forKey:TXKomlinIMStatusKey];
    [info setValue:message forKey:TXKomlinIMMessageObjectKey];
    [parameters setValue:TXKomlinIMDistributionSendStatusKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发意外断开连接
 *  @param status 连接状态
 *  @param info 信息
 *
 *  说明:连接状态为“0”表示断开连接
 *
 */
+ (void)distributionUnexpectedDisconnect:(NSInteger)status info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:[NSNumber numberWithInteger:status] forKey:TXKomlinIMStatusKey];
    [parameters setValue:TXKomlinIMDistributionUnexpectedDisconnectKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发自动连接
 *  @param status 连接状态
 *  @param info 信息
 *
 *  说明:连接状态为“0”表示断开连接
 *
 */
+ (void)distributionAutoConnect:(NSInteger)status info:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [info setValue:[NSNumber numberWithInteger:status] forKey:TXKomlinIMStatusKey];
    [parameters setValue:TXKomlinIMDistributionAutoConnectKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发心跳
 *  @param info 信息
 */
+ (void)distributionHeartbeat:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [parameters setValue:TXKomlinIMDistributionHeartbeatKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

/**
 *  分发超时心跳
 *  @param info 信息
 */
+ (void)distributionTimeoutHeartbeat:(NSDictionary*)info{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:info forKey:TXKomlinIMInfoKey];
    [parameters setValue:TXKomlinIMDistributionTimeoutHeartbeatKey forKey:TXKomlinIMNameKey];
    [self distributionWithParameters:parameters];
}

@end
