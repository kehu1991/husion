
#import "AppDelegate.h"
#import "MapViewController.h"


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
    
    
}

@end
