/*
     File: DetailViewController.h 
 Abstract: The detail view controller used for displaying the Golden Gate Bridge. 
  Version: 1.2 
  
 
  
 */

#import <UIKit/UIKit.h>
//@interface DetailViewController : UIViewController
@interface DetailViewController : UIViewController <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (retain, nonatomic) IBOutlet UISegmentedControl *SegmentControl;
- (IBAction)Selected:(id)sender;
@property (retain, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIPickerView *directionPicker;
- (IBAction)ButtonPressed:(id)sender;
@property (strong, nonatomic) NSArray *pickerData;
@property (retain, nonatomic) IBOutlet UIButton *Button;

@property (retain, nonatomic) IBOutlet UILabel *PickerLabel;
@property (retain, nonatomic) IBOutlet UILabel *SliderLabel;
- (IBAction)sliderChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *confidenceLabel;
@property (retain, nonatomic) IBOutlet UILabel *pointValueLabel;

@end
