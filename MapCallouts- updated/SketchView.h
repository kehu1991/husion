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

@interface SketchView : UIView {
    
    NSMutableArray *pointList;
    int n;
    SmartPhoneDataMessage *msg; //message received from broadcasting
    SmartPhoneNodeMessage *msgToSend; //messsage to be sent
    SmartPhoneNodeMessage_Point *pointToAdd;
    
    //data to send!!
    NSString *pointx;
    NSString *pointy;
    int confidence;
    NSString *direction;
    NSString *object;
    
    UIImageView *imageToDisplay;
    UIImage *imgToDisplay;
    UIImage *originalImage;
    
    NSArray *array;
    NSArray *array2;
    NodeHeartbeatMessage *message;
    int32_t address;
    NSArray *Object;//object there or not there
    UIPickerView *pickerView1;
    

    
    }

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)Selected:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *Button;
- (IBAction)SendButton:(id)sender;

- (IBAction)SliderChanged:(id)sender;

@property (retain, nonatomic) IBOutlet UIPickerView *Picker;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UISlider *Slider;
@property (strong, nonatomic) NSArray *pickerData;
@property (retain, nonatomic) IBOutlet UILabel *confidenceLabel;

@property (assign, nonatomic) CGPoint CurrentPoint;
@property (assign, nonatomic) CGPoint PreviousPoint;
@property (assign, nonatomic) CGPoint InitialPoint;
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) NSArray *array2;


@property (nonatomic, retain) NSString *pointx;
@property (nonatomic, retain) NSString *pointy;
@property (nonatomic, retain) NSString *direction;

@property (retain, nonatomic) IBOutlet UIImageView *greyBack;
@property (retain, nonatomic) IBOutlet UIButton *CancelButton;
- (IBAction)Cancel:(id)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *Picker2;

@property (retain, nonatomic) IBOutlet UIImageView *imageToDisplay;
@property (retain, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)refresh:(id)sender;


@end
