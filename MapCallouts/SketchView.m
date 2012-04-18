//
//  SketchView.m
//  MapCallouts
//
//  Created by Ke Hu on 12-3-12.
//  Copyright (c) 2012年 Cornell University. All rights reserved.
//

#import "SketchView.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include "TCPConnectionMethods.h"
#import "NodeHeartbeatMessage.pb.h"
#import "SmartPhoneMessages.pb.h"


static NSString *buttonNumber = @"1"; //"1" stands for Point and "2" stands for "Sketch"
static NSString *a;
static NSString *b;

static NSString *confidence = @"50";// confidence for point input
 
static NSString *interface = @"Main";//Interface label. Main,

/**SketchView is the interface where an interior map shown with point and sketch implementation*/
@implementation SketchView

@synthesize Picker; //picker for doing point
@synthesize Picker2;//picker for doing Sketch
@synthesize CancelButton;//cancel button after drew sth on the map
@synthesize label2;//label on the input interface
@synthesize label1;//label on the input interface
@synthesize Slider;//slider for confidence
@synthesize Button;//button for sending
@synthesize segmentControl;//point or sketch
@synthesize confidenceLabel;//label for confidence

@synthesize image;//interior map
@synthesize greyBack;//grey background of input interface
@synthesize array;//array for Picker's data
@synthesize array2;//array for Picker2's data

@synthesize InitialPoint;//for sketching. internal computing
@synthesize CurrentPoint;//for sketching. internal computing
@synthesize PreviousPoint;//for sketching. internal computing
@synthesize pickerData;//


@synthesize pointx;
@synthesize pointy;
@synthesize confidence;
@synthesize direction;





-(id)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]){
                
        array = [[NSArray alloc]initWithObjects: @"to the right", @"to the left", @"in front", @"behind", @"near around", @"inside", @"outside", nil];
        
        array2 = [[NSArray alloc]initWithObjects: @"inside", @"outside", nil];
        Object = [[NSArray alloc]initWithObjects:@" is", @" is not", nil];
        
        
        //default: do Point
        self.pickerData = array;
        buttonNumber = @"1";
        NSLog(@"1");
        
        [NSThread detachNewThreadSelector: @selector(DataExchangeConnection) toTarget:self
                               withObject:nil];
        

    }
    return self;
}



-(void)drawRect:(CGRect)rect{
    
}


- (void)dealloc {
    [segmentControl release];
    [Button release];
    [Picker release];
    [label2 release];
    [label1 release];
    [Slider release];
    [confidenceLabel release];
    [image release];
    [pickerData release];
    [greyBack release];
    [CancelButton release];
    [Picker2 release];
    [super dealloc];
}



- (IBAction)Selected:(id)sender {
    
    if ([sender selectedSegmentIndex]==0){
        buttonNumber = @"1";
        self.pickerData = array;
        
    }
    else {
        buttonNumber = @"2";
        self.pickerData = array2;
    }
    
    
}

- (IBAction)SendButton:(id)sender {
    
    //NSInteger row = [Picker selectedRowInComponent:0];
    //NSString *selected = [pickerData objectAtIndex:row];
    //NSData *dirc = [selected dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%d",n);
    //for (id obj in pointList)
        //NSLog(@"%@", obj);
    
    image.image = [UIImage imageNamed:@"rhodes-temp.png"];
    Slider.hidden = YES;
    Picker.hidden = YES;
    Button.hidden = YES;
    label1.hidden = YES;
    label2.hidden = YES;
    Picker2.hidden = YES;
    CancelButton.hidden = YES;
    confidenceLabel.hidden = YES;
    greyBack.hidden = YES;
    segmentControl.hidden = NO;
    image.hidden = NO;
    interface = @"Main";
    
    //TCP sending method...
    
    n= 0;
    
    [pointList removeAllObjects];
}

- (IBAction)SliderChanged:(id)sender {
    int progressAsInt = (int)roundf(Slider.value);
    confidenceLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    confidence = confidenceLabel.text;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if (interface == @"Main"){
        
        if (buttonNumber == @"1"){
            
            // point data interface
            
            n=1;
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self];
            CGFloat X = point.x;
            CGFloat Y = point.y;
            a = [NSString stringWithFormat:@"%.2f", X];
            b = [NSString stringWithFormat:@"%.2f", Y];
            
            //store point data to pointList array
            //data with bytes-- not sure
            
            NSData *pointObject = [NSData dataWithBytes:&point length:sizeof(CGPoint)];
            [pointList addObject:pointObject];
            
            
            UIGraphicsBeginImageContext(image.frame.size); 
            CGContextRef ctx = UIGraphicsGetCurrentContext();   
            [image.image drawInRect:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineWidth(ctx, 5.0);
            CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, point.x, point.y);
            CGContextAddLineToPoint(ctx, point.x+1, point.y+1);
            CGContextStrokePath(ctx);
            image.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            interface = @"SecondView";
            segmentControl.hidden = YES;
            Picker.hidden = NO;
            label1.hidden = NO;
            label2.hidden = NO;
            Slider.hidden = NO;
            Button.hidden = NO;
            greyBack.hidden = NO;
            CancelButton.hidden = NO;
            //image.hidden = YES;
            confidenceLabel.hidden = NO;
        }
        
        
        if (buttonNumber == @"2"){
            n=1;
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:image];
            InitialPoint = point;
            NSData *pointObject = [NSData dataWithBytes:&point length:sizeof(CGPoint)];
            [pointList addObject:pointObject];

            
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (interface == @"Main"){
        
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:image];
        CurrentPoint = [touch locationInView:image];
        NSData *pointObject = [NSData dataWithBytes:&CurrentPoint length:sizeof(CGPoint)];
        [pointList addObject:pointObject];
        n = n+1;

        UIGraphicsBeginImageContext(image.frame.size); 
        CGContextRef ctx = UIGraphicsGetCurrentContext();   
        [image.image drawInRect:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineWidth(ctx, 5.0);
        CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, PreviousPoint.x, PreviousPoint.y);
        CGContextAddLineToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        CGContextStrokePath(ctx);
        image.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(interface == @"Main"){
        n= n+1;
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:image];
        CurrentPoint = [touch locationInView:image];
        NSData *pointObject = [NSData dataWithBytes:&CurrentPoint length:sizeof(CGPoint)];
        [pointList addObject:pointObject];

        UIGraphicsBeginImageContext(image.frame.size); 
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [image.image drawInRect:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineWidth(ctx, 5.0);
        CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, PreviousPoint.x, PreviousPoint.y);
        CGContextAddLineToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        
        CGContextMoveToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        CGContextAddLineToPoint(ctx, InitialPoint.x, InitialPoint.y);
        CGContextStrokePath(ctx);
        image.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        interface = @"SecondView";
        //self.backgroundColor = [UIColor whiteColor];
        segmentControl.hidden = YES;
        Picker2.hidden = NO;
        label1.hidden = NO;
        label2.hidden = NO;
        Slider.hidden = NO;
        Button.hidden = NO;
        CancelButton.hidden = NO;
        greyBack.hidden = NO;
        //image.hidden = YES;
        confidenceLabel.hidden = NO;
        
        
    }
    
}


#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    NSArray *values = ( pickerView == Picker ? array : array2 );
    if (component == 1)
        return [values count];
    return [Object count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSArray *values = ( pickerView == Picker ? array : array2  );
    if (component ==1)
        return [values objectAtIndex: row];
    return [Object objectAtIndex:row];
}


- (IBAction)Cancel:(id)sender {
    image.image = [UIImage imageNamed:@"rhodes-temp.png"];
    Slider.hidden = YES;
    Picker.hidden = YES;
    Button.hidden = YES;
    label1.hidden = YES;
    label2.hidden = YES;
    Picker2.hidden = YES;
    CancelButton.hidden = YES;
    confidenceLabel.hidden = YES;
    greyBack.hidden = YES;
    segmentControl.hidden = NO;
    image.hidden = NO;
    interface = @"Main";
    
}

-(void)DataExchangeConnection {
    int clientSocket;
    int error = 0;
	void *buffer = malloc(1000000);
	int serverSocket = CreateTCPServerSocket(10001);
	if (serverSocket < 0) {
		printf("Server Creation\n");
	}
	bool isRunning = true;
	while (isRunning) {
		printf("Waiting for new client.\n");
		clientSocket = AcceptTCPConnection(serverSocket);
		if (clientSocket < 0) {
			printf("Client accept");
		}
		while (isRunning && clientSocket >= 0) {
			printf("Waiting for message.\n");
			int bytesReceived = recv(clientSocket, buffer, 1000000, 0);
			if (bytesReceived <= 0) {
				if (bytesReceived == 0) {
					printf("Remote client closed.\n");
				} else if (bytesReceived < 0) {
                    printf("Error occured while receiving message.i\n");
				}
				close(clientSocket);
				clientSocket = -1;
			} else {
				printf("Data receive complete. Bytes=%i\n", bytesReceived);
                int msgLength = ((uint8_t*)buffer)[0];
                msgLength <<= 8;
                msgLength += ((uint8_t*)buffer)[1];
                msgLength <<= 8;
                msgLength += ((uint8_t*)buffer)[2];
                msgLength <<= 8;
                msgLength += ((uint8_t*)buffer)[3];
                msgLength <<= 8;
                msgLength = ntohl(msgLength);
                
                void *msgData = malloc(msgLength);
                memcpy(msgData, buffer, msgLength);
				msg = [SmartPhoneDataMessage parseFromData:[NSData dataWithBytes:buffer length:bytesReceived]];
                free(msgData);
                printf("ID: %i, Res: %ix%i\n", msg.id, msg.width, msg.height);
				
			}
            
		}
	}
    
	if (clientSocket >= 0) {
		close(clientSocket);
		clientSocket = -1;
	}
	if (clientSocket >= 0) {
		close(serverSocket);
		serverSocket = -1;
	}
	free(buffer);
	printf("Server thread closing.\n");

}


@end


