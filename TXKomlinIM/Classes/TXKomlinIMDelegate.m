//
//  TXKomlinIMDelegate.m
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/2.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXKomlinIMDelegate.h"
#import "TXKomlinIMConst.h"

@implementation TXKomlinIMDelegate

/** 重写系统init方法 */
- (instancetype)init{
    if (self = [super init]) {
        // 即时通讯管理器
        self.manager=[TXKomlinIMManager manager];
        // 添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(komlinIMDistributionNotification:) name:TXKomlinIMDistributionNotification object:nil];
    }
    return self;
}

/** 设置即时通讯管理器 */
- (void)setManager:(TXKomlinIMManager * _Nonnull)manager{
    _manager=manager;
}

/** 监听通知 */
- (void)komlinIMDistributionNotification:(id)sender{
    NSNotification *notification=sender;
    NSDictionary *userInfo=notification.userInfo;
    if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionServerConnectStatusKey]) {
        // 分发服务器连接状态
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:serverConnectStatus:info:)]) {
            NSInteger status=[userInfo[TXKomlinIMInfoKey][TXKomlinIMStatusKey] integerValue];
            [self.delegate komlinIMDelegate:self serverConnectStatus:status info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionLoginStatusKey]){
        // 分发登录状态
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:loginStatus:info:)]) {
            NSInteger status=[userInfo[TXKomlinIMInfoKey][TXKomlinIMStatusKey] integerValue];
            [self.delegate komlinIMDelegate:self loginStatus:status info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionRegistrationStatusKey]){
        // 分发注册状态
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:registrationStatus:info:)]) {
            NSInteger status=[userInfo[TXKomlinIMInfoKey][TXKomlinIMStatusKey] integerValue];
            [self.delegate komlinIMDelegate:self registrationStatus:status info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionReceiveMessageKey]){
        // 分发接收消息
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:message:info:)]) {
            id message=userInfo[TXKomlinIMInfoKey][TXKomlinIMMessageObjectKey];
            [self.delegate komlinIMDelegate:self message:message info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionSendStatusKey]){
        // 分发发送状态
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:sendStatus:message:info:)]) {
            NSInteger status=[userInfo[TXKomlinIMInfoKey][TXKomlinIMStatusKey] integerValue];
            id message=userInfo[TXKomlinIMInfoKey][TXKomlinIMMessageObjectKey];
            [self.delegate komlinIMDelegate:self sendStatus:status message:message info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionUnexpectedDisconnectKey]){
        // 分发意外断开连接
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:unexpectedDisconnectStatus:info:)]) {
            NSInteger status=[userInfo[TXKomlinIMInfoKey][TXKomlinIMStatusKey] integerValue];
            [self.delegate komlinIMDelegate:self unexpectedDisconnectStatus:status info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionAutoConnectKey]){
        // 分发自动连接
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:autoConnectStatus:info:)]) {
            NSInteger status=[userInfo[TXKomlinIMInfoKey][TXKomlinIMStatusKey] integerValue];
            [self.delegate komlinIMDelegate:self autoConnectStatus:status info:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionHeartbeatKey]){
        // 分发心跳
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:heartbeat:)]) {
            [self.delegate komlinIMDelegate:self heartbeat:userInfo[TXKomlinIMInfoKey]];
        }
    }else if ([userInfo[TXKomlinIMNameKey] isEqualToString:TXKomlinIMDistributionTimeoutHeartbeatKey]){
        // 分发超时心跳
        if ([self.delegate respondsToSelector:@selector(komlinIMDelegate:timeoutHeartbeat:)]) {
            [self.delegate komlinIMDelegate:self timeoutHeartbeat:userInfo[TXKomlinIMInfoKey]];
        }
    }
}

/** 释放 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXKomlinIMDistributionNotification object:nil];
}

@end
