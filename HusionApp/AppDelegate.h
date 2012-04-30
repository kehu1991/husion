
#import <UIKit/UIKit.h>
#import "NodeHeartbeatMessage.pb.h"

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	UINavigationController *myNavController;
    
    /**NodeHeartbeatMessage *message;
    int32_t address;
    NSString *add;*/

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *myNavController;


@end
