
#import <UIKit/UIKit.h>
#import "NodeHeartbeatMessage.pb.h"
#import "SketchView.h"


@interface DetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    int32_t address;
    NodeHeartbeatMessage *message;
    IBOutlet UIImageView *background;
    //UIImage *imgReceived;
    //SmartPhoneDataMessage *msg;
    //BOOL imgBefore;
    //BOOL imgLater;
    

    
}
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UISlider *Slider;
@property (retain, nonatomic) IBOutlet UIButton *Button;
@property (retain, nonatomic) IBOutlet UIPickerView *Picker;
@property (retain, nonatomic) IBOutlet UILabel *ConfidenceLabel;
@property (retain, nonatomic) IBOutlet UIImageView *greyBack;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UIButton *CancelButton;
@property (retain, nonatomic) IBOutlet UIPickerView *Picker2;
@property (retain, nonatomic) IBOutlet UIImageView *background;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)SegmentValueChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *RefreshRemindLabel;
@property (retain, nonatomic) IBOutlet UILabel *MapUpdatedLabel;


-(void) Runloop;

@end
