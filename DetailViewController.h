/*
     File: DetailViewController.h 
 Abstract: The detail view controller used for displaying the Golden Gate Bridge. 
  Version: 1.2 
  
 
  
 */

#import <UIKit/UIKit.h>
//@interface DetailViewController : UIViewController
@interface DetailViewController : UIViewController <UIActionSheetDelegate>
@property (retain, nonatomic) IBOutlet UISegmentedControl *SegmentControl;
- (IBAction)Selected:(id)sender;


@end
