//
//  TXKomlinIMConfiguration.m
//  TXXMPP
//
//  Created by xtz_pioneer on 2019/4/1.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXKomlinIMConfiguration.h"

@implementation TXKomlinIMConfiguration

/** 重写系统init方法 */
- (instancetype)init{
    if (self = [super init]) {
        // 服务器地址
        self.komlinIMServerAddress=@"47.98.134.204";
        // 服务器端口
        self.komlinIMServerPort=5222;
        // 域名
        self.komlinIMDomain=@"komlin";
        // 源
        self.komlinIMResource=@"iOS";
        // 心跳包间隔
        self.pingInterval=1.0f;
        // 重新连接延迟时间
        self.reconnectDelay=0.0f;
        // 重连时间间隔
        self.reconnectTimerInterval=1.0f;
    }
    return self;
}

@end
