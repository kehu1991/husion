
#import <UIKit/UIKit.h>
#import "NodeHeartbeatMessage.pb.h"


@interface DetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    int32_t address;
    NodeHeartbeatMessage *message;

    
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


-(void) Runloop;

@end
