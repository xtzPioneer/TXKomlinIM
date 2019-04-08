//
//  TXKomlinIMConst.m
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/3.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXKomlinIMConst.h"

#pragma mark- 离线/上线
/** 离线的Key */
NSString *const TXKomlinIMUnavailableKey   =@"unavailable";
/** 上线的Key */
NSString *const TXKomlinIMAvailableKey     =@"available";

#pragma mark- 管理器对象/错误对象/消息对象
/** 管理器对象Key */
NSString *const TXKomlinIMManagerObjectKey =@"managerObject";
/** 错误对象 */
NSString *const TXKomlinIMErrorObjectKey   =@"errorObject";
/** 空灵即时通讯消息key */
NSString *const TXKomlinIMMessageObjectKey =@"messageObject";

#pragma mark- 通用字段
/** 空灵即时通讯状态key */
NSString *const TXKomlinIMStatusKey        =@"status";
/** 空灵即时通讯信息key */
NSString *const TXKomlinIMInfoKey          =@"info";
/** 空灵即时通讯名称key */
NSString *const TXKomlinIMNameKey          =@"name";

#pragma mark- 分发通知
/** 空灵即时通讯推送通知 */
NSString *const TXKomlinIMDistributionNotification            =@"komlinIMDistributionNotification";

#pragma mark- 分发功能名称字段
/** 分发服务器连接状态 */
NSString *const TXKomlinIMDistributionServerConnectStatusKey  =@"distributionServerConnectStatus";
/** 分发登录状态 */
NSString *const TXKomlinIMDistributionLoginStatusKey          =@"distributionLoginStatus";
/** 分发注册状态 */
NSString *const TXKomlinIMDistributionRegistrationStatusKey   =@"distributionRegistrationStatus";
/** 分发接收消息 */
NSString *const TXKomlinIMDistributionReceiveMessageKey       =@"distributionReceiveMessage";
/** 分发发送状态 */
NSString *const TXKomlinIMDistributionSendStatusKey           =@"distributionSendStatus";
/** 分发意外断开连接 */
NSString *const TXKomlinIMDistributionUnexpectedDisconnectKey =@"distributionUnexpectedDisconnect";
/** 分发自动连接 */
NSString *const TXKomlinIMDistributionAutoConnectKey          =@"distributionAutoConnect";
/** 分发心跳 */
NSString *const TXKomlinIMDistributionHeartbeatKey            =@"distributionHeartbeat";
/** 分发超时心跳 */
NSString *const TXKomlinIMDistributionTimeoutHeartbeatKey     =@"distributionTimeoutHeartbeat";


