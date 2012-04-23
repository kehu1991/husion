//
//  DataExchange.h
//  MapCallouts
//
//  Created by Ke Hu on 12-4-3.
//  Copyright (c) 2012年 Cornell University. All rights reserved.
//

#import "AsyncUdpSocket.h"
#import "NodeHeartbeatMessage.pb.h"
@class AsyncUdpSocket;
@class NodeHeartBeatMessage;

@interface DataExchange : NSObject {
    
    AsyncUdpSocket *serverSocket;
    NodeHeartBeatMessage *message;
    int32_t address;
    
}

-(void)openUDPToSever:(NSString *)server withPort:(NSInteger)port;
-(void)sendDataToServer:(NSData *)t;
-(void)startConnection;
-(void)sendHeartBeatMessage;

@property (nonatomic, retain) AsyncUdpSocket *serverSocket;

@end
