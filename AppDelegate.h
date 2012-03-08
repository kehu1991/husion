/*
     File: AppDelegate.h 
 Abstract: The application delegate class used for installing our navigation controller. 
  Version: 1.2 
  
  */  

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	UINavigationController *myNavController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *myNavController;

@end
