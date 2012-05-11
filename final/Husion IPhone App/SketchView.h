//
//  SketchView.h
//  MapCallouts
//
//  Created by Ke Hu on 12-3-12.
//  Copyright (c) 2012年 Cornell University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import "NodeHeartbeatMessage.pb.h"
#import "SmartPhoneMessages.pb.h"

@interface SketchView : UIView <NSObject> {
    
    //message received from broadcasting - TCP
    SmartPhoneDataMessage *msg; 
    float bottomY;
    float leftX;
    int clientSocket;
    float metersPixel;
    UIImage *imgToDisplay;
    int idNumber;
    //message to send - TCP
    NodeHeartbeatMessage *message;
    int confidence;
    NSString *direction;
    NSString *object;
    NSMutableArray *pointList;
    int n;  //number of point values in pointList
    //IP address for both UDP and TCP connections
    int32_t address;
    //settings for picker
    NSArray *array;
    //view settings. Check which mode is set in segmented controller
    NSString *buttonNumber;
    //set for checking whether new map is updated or no new map
    BOOL newMap;
    UIImageView *imageToDisplay; //background map view
    UIImage *originalImage;
    
}

//Main view settings
@property (retain, nonatomic) IBOutlet UIImageView *imageToDisplay;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *Console;
@property (retain, nonatomic) IBOutlet UITextField *textField;
- (IBAction)userDoneEnteringText:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *IDLabel;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)Selected:(id)sender;  //check which segment is touched down on segmentControl


//items in option menu
@property (retain, nonatomic) IBOutlet UIButton *Button; //send button
- (IBAction)SendButton:(id)sender; //send button touch down event
- (IBAction)SliderChanged:(id)sender; //slider change event
@property (retain, nonatomic) IBOutlet UIPickerView *Picker;
@property (nonatomic, retain) NSArray *array;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UISlider *Slider;
@property (strong, nonatomic) NSArray *pickerData;
@property (retain, nonatomic) IBOutlet UILabel *confidenceLabel;
@property (retain, nonatomic) IBOutlet UIImageView *greyBack;
@property (retain, nonatomic) IBOutlet UIButton *CancelButton;
- (IBAction)Cancel:(id)sender;

//points for drawing out the sketch
@property (assign, nonatomic) CGPoint CurrentPoint;
@property (assign, nonatomic) CGPoint PreviousPoint;
@property (assign, nonatomic) CGPoint InitialPoint;


@end
