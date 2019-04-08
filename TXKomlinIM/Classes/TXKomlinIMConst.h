//
//  TXKomlinIMConst.h
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/3.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark- 离线/上线
/** 离线的Key */
FOUNDATION_EXPORT NSString *const TXKomlinIMUnavailableKey;
/** 上线的Key */
FOUNDATION_EXPORT NSString *const TXKomlinIMAvailableKey;

#pragma mark- 管理器对象/错误对象/消息对象
/** 管理器对象Key */
FOUNDATION_EXPORT NSString *const TXKomlinIMManagerObjectKey;
/** 错误对象 */
FOUNDATION_EXPORT NSString *const TXKomlinIMErrorObjectKey;
/** 空灵即时通讯消息key */
FOUNDATION_EXPORT NSString *const TXKomlinIMMessageObjectKey;

#pragma mark- 通用字段
/** 空灵即时通讯状态key */
FOUNDATION_EXPORT NSString *const TXKomlinIMStatusKey;
/** 空灵即时通讯信息key */
FOUNDATION_EXPORT NSString *const TXKomlinIMInfoKey;
/** 空灵即时通讯名称key */
FOUNDATION_EXPORT NSString *const TXKomlinIMNameKey;

#pragma mark- 分发通知
/** 空灵即时通讯推送通知 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionNotification;

#pragma mark- 分发功能名称字段
/** 分发服务器连接状态 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionServerConnectStatusKey;
/** 分发登录状态 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionLoginStatusKey;
/** 分发注册状态 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionRegistrationStatusKey;
/** 分发接收消息 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionReceiveMessageKey;
/** 分发发送状态 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionSendStatusKey;
/** 分发意外断开连接 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionUnexpectedDisconnectKey;
/** 分发自动连接 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionAutoConnectKey;
/** 分发心跳 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionHeartbeatKey;
/** 分发超时心跳 */
FOUNDATION_EXPORT NSString *const TXKomlinIMDistributionTimeoutHeartbeatKey;

NS_ASSUME_NONNULL_END
