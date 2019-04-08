//
//  TXKomlinIMConfiguration.h
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/1.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  空灵即时通讯配置文件
 */
@interface TXKomlinIMConfiguration : NSObject

/** 空灵即时通讯服务器地址 */
@property (nonatomic,copy)NSString *komlinIMServerAddress;

/** 空灵即时通讯服务器端口 */
@property (nonatomic,assign)UInt16 komlinIMServerPort;

/** 空灵即时通讯域名 */
@property (nonatomic,copy)NSString *komlinIMDomain;

/** 空灵即时通讯源 */
@property (nonatomic,copy)NSString *komlinIMResource;

/** 心跳包间隔 */
@property (nonatomic,assign)NSTimeInterval pingInterval;

/** 重连时间间隔 */
@property (nonatomic,assign)NSTimeInterval reconnectTimerInterval;

/** 重新连接延迟时间 */
@property (nonatomic,assign)NSTimeInterval reconnectDelay;

@end

NS_ASSUME_NONNULL_END
