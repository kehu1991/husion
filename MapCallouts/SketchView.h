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
    
    NSMutableArray *pointList;
    int n;  //number of point values in pointList
    int clientSocket;
    SmartPhoneDataMessage *msg; //message received from broadcasting
       
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
    NSString *buttonNumber;
    
    
    float originalx;
    float originaly;
    

    
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
//@property (retain, nonatomic) IBOutlet UIButton *freshButton;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
//- (IBAction)refresh:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *refreshRemindLabel;
@property (retain, nonatomic) IBOutlet UILabel *mapUpdatedLabel;


@end
