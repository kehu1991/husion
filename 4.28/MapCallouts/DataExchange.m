//
//  DataExchange.m
//  MapCallouts
//
//  Created by Ke Hu on 12-4-3.
//  Copyright (c) 2012年 Cornell University. All rights reserved.
//

#import "DataExchange.h"
#import "AsyncUdpSocket.h"
#import "NodeHeartbeatMessage.pb.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netinet/in.h>

@implementation DataExchange
@synthesize serverSocket;


//Public Action to begin connection
-(void)startConnection{
    NSString *theServer=@"10.255.255.255.255";
    NSInteger thePort=10000;
    [self openUDPToSever:theServer withPort:thePort];
}

//Begin connection cadance
-(void)openUDPToSever:(NSString *)server withPort:(NSInteger)port{	   
    NSError *error = nil;
    serverSocket = [[AsyncUdpSocket alloc] init];
    NSString* str= @"teststring";
    NSData* data=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
     //get IPAddress
    address = 0;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)  
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)  
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone  
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])  
                {
                    // Get NSString from C String
                    address = ((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr.s_addr;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces); 
    //return address; 
    
    [serverSocket enableBroadcast:TRUE error:nil];
    if ([serverSocket connectToHost:server onPort:port error:&error]){
        [self sendDataToServer: data];
    } else {
        NSLog(@"Error connecting to Server: %@", error);
    }
}

//method to send text to server
-(void)sendDataToServer:(NSData *)t{
    [serverSocket sendData:t withTimeout:-1 tag:0];
    NSLog (@"Server Out: %@",t);
}

//Called when state is received
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    [sock receiveWithTimeout:-1 tag:0];
    NSString *e = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    [self processServerData:e];
    [e release];
    return YES;
}

-(void)processServerData:(NSString *)data{
    //Process the data sent by the server 
    //and send follow-up commands if needed
    

}

-(void)sendHeartBeatMessage{
    
    message = [[[[[NodeHeartBeatMessage builder] setId:(int32_t)5]
                                   setIpaddress:address]
                                  setType:NodeHeartbeatMessage_NodeTypeSmartphone] build];
    [serverSocket sendData:[message data] withTimeout:-1 tag:0];
}

@end
