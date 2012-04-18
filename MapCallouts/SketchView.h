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


@interface SketchView : UIView <NSStreamDelegate> {
    NSMutableArray *pointList;
    int n;
    SmartPhoneDataMessage *msg;
    //data to send!!
    NSString *pointx;
    NSString *pointy;
    NSString *confidence;
    NSString *direction;
    
    
    NSArray *array;
    NSArray *array2;
    NodeHeartbeatMessage *message;
    int32_t address;
    NSArray *Object;

    
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
@property (nonatomic, retain) NSString *confidence;
@property (nonatomic, retain) NSString *direction;

@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UIImageView *greyBack;
@property (retain, nonatomic) IBOutlet UIButton *CancelButton;
- (IBAction)Cancel:(id)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *Picker2;


@end
