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

// confidence for point input
 
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

@synthesize imageToDisplay;//interior map
@synthesize freshButton;
@synthesize greyBack;//grey background of input interface
@synthesize array;//array for Picker's data
@synthesize array2;//array for Picker2's data

@synthesize InitialPoint;//for sketching. internal computing
@synthesize CurrentPoint;//for sketching. internal computing
@synthesize PreviousPoint;//for sketching. internal computing
@synthesize pickerData;//


@synthesize pointx;
@synthesize pointy;
@synthesize direction;





-(id)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]){
                
        array = [[NSArray alloc]initWithObjects: @"to the right", @"to the left", @"in front", @"behind", @"near around", @"inside", @"outside", nil];
        
        array2 = [[NSArray alloc]initWithObjects: @"inside", @"outside", nil];
        Object = [[NSArray alloc]initWithObjects:@"It is", @"It is not", nil];
        
        [self addSubview:imageToDisplay];
        originalImage = [UIImage imageNamed:@"rhodes-temp.png"];
       
        confidence = 50;
        //default: do Point
        self.pickerData = array;
        buttonNumber = @"1";
       
        
        [NSThread detachNewThreadSelector: @selector(DataExchangeConnection) toTarget:self withObject:nil];
        

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
    [imageToDisplay release];
    [pickerData release];
    [greyBack release];
    [CancelButton release];
    [Picker2 release];
    //[backgroundimage release];
    [freshButton release];
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
    
   
    NSInteger row = [pickerView1 selectedRowInComponent:0];
    object = [Object objectAtIndex:row];
    NSInteger row2 = [pickerView1 selectedRowInComponent:1];
    NSArray *values = ( pickerView1 == Picker ? array : array2 );
    direction = [values objectAtIndex:row2];
    confidence = (int)roundf(Slider.value);
    
    NSLog(@"%d",n);
    NSLog(@"Direction is :%@ \n",direction);
    NSLog(@"Ojbect is :%@ \n", object);
    NSLog(@"Confidence is : %d \n", confidence);
        
    imageToDisplay.image = originalImage;
    UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
    [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
    
    imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

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
    imageToDisplay.hidden = NO;
    interface = @"Main";
    
    
    //TCP sending method...
    //msgToSend = [[[[[[SmartPhoneNodeMessage builder]setId:(int32_t)5] setPreposition:direction] setObject:object] setConfidence:(int32_t) confidence] build];
    

    
    
    
    n= 0;
    
    [pointList removeAllObjects];
    Slider.value = 50; 
    confidenceLabel.text = @"50";
    confidence = 50;
    
}

- (IBAction)SliderChanged:(id)sender {
    int progressAsInt = (int)roundf(Slider.value);
    confidenceLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    
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
            originalImage = [imageToDisplay.image copy];
            
            
            UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
            CGContextRef ctx = UIGraphicsGetCurrentContext();   
            [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineWidth(ctx, 5.0);
            CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, point.x, point.y);
            CGContextAddLineToPoint(ctx, point.x+1, point.y+1);
            CGContextStrokePath(ctx);
            imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
            
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
            CGPoint point = [touch locationInView:imageToDisplay];
            InitialPoint = point;
            NSData *pointObject = [NSData dataWithBytes:&point length:sizeof(CGPoint)];
            [pointList addObject:pointObject];

            
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (interface == @"Main"){
        
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:imageToDisplay];
        CurrentPoint = [touch locationInView:imageToDisplay];
        NSData *pointObject = [NSData dataWithBytes:&CurrentPoint length:sizeof(CGPoint)];
        [pointList addObject:pointObject];
        n = n+1;

        UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
        CGContextRef ctx = UIGraphicsGetCurrentContext();   
        [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineWidth(ctx, 5.0);
        CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, PreviousPoint.x, PreviousPoint.y);
        CGContextAddLineToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        CGContextStrokePath(ctx);
        imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(interface == @"Main"){
        n= n+1;
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:imageToDisplay];
        CurrentPoint = [touch locationInView:imageToDisplay];
        NSData *pointObject = [NSData dataWithBytes:&CurrentPoint length:sizeof(CGPoint)];
        [pointList addObject:pointObject];

        UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineWidth(ctx, 5.0);
        CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, PreviousPoint.x, PreviousPoint.y);
        CGContextAddLineToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        
        CGContextMoveToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        CGContextAddLineToPoint(ctx, InitialPoint.x, InitialPoint.y);
        CGContextStrokePath(ctx);
        imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
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
    NSArray *values = ( pickerView1 == Picker ? array : array2 );
    if (component == 1)
        return [values count];
    else {
        return [Object count];
    }
    
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSArray *values = ( pickerView == Picker ? array : array2  );
    
    pickerView1 = pickerView;
    
    if (component ==1)
        return [values objectAtIndex:row];
    else {
        return [Object objectAtIndex:row];
    }
    

    
}


- (IBAction)Cancel:(id)sender {
    imageToDisplay.image = originalImage;
    UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
    [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
    
    imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
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
    imageToDisplay.hidden = NO;
    interface = @"Main";
    
}

-(void)DataExchangeConnection {
    int clientSocket;
	void *buffer = malloc(1000000);
    void *msgbuffer = NULL;
    int bufoffset = 0;
    int msgLength = -1;
	int serverSocket = CreateTCPServerSocket(10002);
	if (serverSocket < 0) {
		printf("Socket creation failed\n");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"TCP connection failed."
                              message:nil 
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];

        return;
	}
    
	bool isRunning = true;
    int errors = 0;
	while (isRunning && errors < 10) {
		printf("Waiting for new client.\n");
		clientSocket = AcceptTCPConnection(serverSocket);
		if (clientSocket < 0) {
			printf("Client failed\n");
            errors++;
		}
		while (isRunning && clientSocket >= 0) {
			//printf("Waiting for message.\n");
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
                //printf("Data receive complete. Bytes=%i\n", bytesReceived);
                int bytesLeft = 0;
                
                if (msgLength == -1){
                    msgLength = ((uint8_t*)buffer)[0];
                    msgLength <<= 8;
                    msgLength += ((uint8_t*)buffer)[1];
                    msgLength <<= 8;
                    msgLength += ((uint8_t*)buffer)[2];
                    msgLength <<= 8;
                    msgLength += ((uint8_t*)buffer)[3];
                    //msgLength = ntohl(msgLength);
                    
                    msgbuffer = malloc(msgLength);
                    if (bytesReceived > 4){
                        void *datastart = buffer + 4;
                        memcpy(msgbuffer, datastart, bytesReceived-4);
                        bufoffset = bytesReceived - 4;
                    }
                }
                
                else {
                    void *datastart = msgbuffer +bufoffset;
                    int bytestowrite = MIN(bufoffset + bytesReceived, msgLength) - bufoffset;
                    memcpy(datastart, buffer, bytestowrite);
                    bufoffset = bufoffset + bytestowrite;
                    bytesLeft = bytesReceived - bytestowrite;
                }
                //void *msgData = malloc(msgLength);
                //memcpy(msgData, buffer, bytesReceived);
                
				if (bufoffset == msgLength){
                    msg = [SmartPhoneDataMessage parseFromData:[NSData dataWithBytes:msgbuffer length:msgLength]];
                    free(msgbuffer);
                    printf("ID: %i, Res: %ix%i\n", msg.id, msg.width, msg.height);
                    
                    [self ImageConvert];
                                       
                    
                    if (bytesLeft != 0){
                        int nextMsgOffset = bytesReceived - bytesLeft;
                        msgLength = ((uint8_t*)buffer)[nextMsgOffset];
                        msgLength <<= 8;
                        msgLength += ((uint8_t*)buffer)[nextMsgOffset+1];
                        msgLength <<= 8;
                        msgLength += ((uint8_t*)buffer)[nextMsgOffset+2];
                        msgLength <<= 8;
                        msgLength += ((uint8_t*)buffer)[nextMsgOffset+3];
                        //msgLength = ntohl(msgLength);
                        
                        bufoffset =0;
                        msgbuffer = malloc(msgLength);
                        if (bytesLeft > 4){
                            void *datastart = buffer + nextMsgOffset + 4;
                            memcpy(msgbuffer, datastart, bytesLeft-4);
                            bufoffset = bytesLeft - 4;
                        }
                    } else {
                    
                        bufoffset =0;
                        msgLength = -1;
                        msgbuffer = NULL;
                    }
                    
                }
                
                
               				
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

- (void) ImageConvert{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t dataLength = [msg data].length;
    void *dataCopy = malloc(dataLength);
    memcpy(dataCopy, [msg data].bytes, dataLength);
    CGContextRef gtx = CGBitmapContextCreate(dataCopy, msg.width, msg.height, 8, msg.width*4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGImageRef toCGImage = CGBitmapContextCreateImage(gtx);
    UIImage *imageReceived = [[UIImage alloc]initWithCGImage:toCGImage];
    CGImageRelease(toCGImage);
    imgToDisplay = imageReceived;
    free(dataCopy);
                                  
}


- (IBAction)refresh:(id)sender {
    
    if (imgToDisplay == nil){
        imageToDisplay.image = originalImage;
        UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
        [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
        
        imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();

        
    }
    else{    
    imageToDisplay.image = imgToDisplay;
    UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
    [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
    
    imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    }

       
    
}
@end


