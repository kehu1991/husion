
#import "AppDelegate.h"
#import "MapViewController.h"
/**#import "NodeHeartbeatMessage.pb.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>*/

@implementation AppDelegate;

@synthesize window, myNavController;

- (void)dealloc
{
	[myNavController release];
    [window release];
	
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // create window and set up table view controller
    [window addSubview:myNavController.view];
    [window makeKeyAndVisible];
    
    
    /**address = 0;

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
                    add =  [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);

    int s =socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    int broadcast = 1;
    int error;
    if ((s)==-1){
        printf("ERROR: Failed to make socket\n");
    }
    error = setsockopt(s,SOL_SOCKET,SO_BROADCAST,
                       &broadcast,sizeof broadcast);
    if(error)
    {
        printf("setsockopt - SO_SOCKET \n");
    }
    
    struct sockaddr_in si_broadcast, si_recv;
    si_recv.sin_family = AF_INET;
    si_recv.sin_port = 10005;
    si_recv.sin_addr.s_addr = INADDR_ANY;
    memset(si_recv.sin_zero,'\0',sizeof si_recv.sin_zero);
    
    error = bind(s, (struct sockaddr*) &si_recv, sizeof si_recv);
    if(error)
    {
        printf("bind\n");
    }
    
    memset((char *) &si_broadcast, 0, sizeof(si_broadcast));
    si_broadcast.sin_family = AF_INET;
    si_broadcast.sin_port = htons(10000);
    si_broadcast.sin_addr.s_addr = htonl(0x0affffff);

    
    message = [[[[[NodeHeartbeatMessage builder] setId:(int32_t)5]
                 setIpaddress:address]
                setType:NodeHeartbeatMessage_NodeTypeSmartphone] build];

    int slen=sizeof(si_broadcast);
    //EBADF
    for (int i=0; i<100; i++) {
        NSData *msgData = [message data];
        error = sendto(s, [msgData bytes], [msgData length], 0, (struct sockaddr *) &si_broadcast, slen);
        if (error > 0) {
            printf("error on send\n");
        } else {
                printf("Packet sent\n");
        }
            
        
        printf("Sent packet.\n");
        sleep(1);
    }

    */
}

@end
