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


// confidence for point input

static NSString *interface = @"Main";//Interface label. Main,

/**SketchView is the interface where an interior map shown with point and sketch implementation*/
@implementation SketchView
@synthesize refreshRemindLabel;
@synthesize mapUpdatedLabel;


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
//@synthesize freshButton;
@synthesize scrollView;
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
        
        array = [[NSArray alloc]initWithObjects: /**@"to the right", @"to the left", @"in front", @"behind", @"near around", */@"inside", @"outside", nil];
        
        Object = [[NSArray alloc]initWithObjects:@"It is", @"It is not", nil];
        
        [self addSubview:imageToDisplay];
        originalImage = [UIImage imageNamed:@"Rhodes.png"];
        
        confidence = 50;
        //default: do Point
        self.pickerData = array;
        buttonNumber = @"3";
        pointList = [[NSMutableArray alloc]init];
        clientSocket = -1;
        metersPixel = 1;
        bottomY = 0;
        leftX = 0;
        
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
    //[freshButton release];
    [scrollView release];
    [refreshRemindLabel release];
    [mapUpdatedLabel release];
    [super dealloc];
}




- (IBAction)Selected:(id)sender {
    
    if ([sender selectedSegmentIndex]==0){
        buttonNumber = @"1";
        //self.pickerData = array;
        //[self refreshMap];
        
        
        if (imgToDisplay == nil){
            imageToDisplay.image = originalImage;

            CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
            imageToDisplay.frame = imgFrame;
            scrollView.contentSize = imgFrame.size;
            UIGraphicsBeginImageContext(imgFrame.size);
            [imageToDisplay.image drawInRect:imgFrame];

            //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
            //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
            imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
        }
        else{    
            [imageToDisplay setImage:imgToDisplay];
            //imageToDisplay = [imgToDisplay copy];
            //imageToDisplay.image = [UIImage imageNamed:@"GoldenGate.png"];
            originalImage = [imgToDisplay copy];
            CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
            imageToDisplay.frame = imgFrame;
            scrollView.contentSize = imgFrame.size;
            UIGraphicsBeginImageContext(imgFrame.size);
            //CGContextRef ctx = UIGraphicsGetCurrentContext(); 
            [imageToDisplay.image drawInRect:imgFrame];

            //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
            //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
            
            [imageToDisplay setImage: UIGraphicsGetImageFromCurrentImageContext()];
            
            UIGraphicsEndImageContext();
            
            
        }
        
        if (clientSocket == -1){
            refreshRemindLabel.hidden = NO;
            
            [self performSelector:@selector(MoveRefreshLabelAway) withObject:nil afterDelay:1.00];
            [self performSelector:@selector(moveRefreshLabelBack) withObject:nil afterDelay:3.00];    
            
        }
        
        else {
            mapUpdatedLabel.hidden = NO;
            
            [self performSelector:@selector(MoveMapUpdatedLabelAway) withObject:nil afterDelay:1.00];
            [self performSelector:@selector(moveMapUpdatedlBack) withObject:nil afterDelay:3.00];                
            printf("Map updated.\n");
            
        }
        
        [self performSelector:@selector(changeSegmentSelected:) withObject:sender afterDelay:0.30];
        
        
        
        
    }
    else {
        
        if ([sender selectedSegmentIndex] == 1) {
            buttonNumber = @"2";
            //self.pickerData = array2;
            self.pickerData = array;
            
            
            
            
        }
        else {
            buttonNumber = @"3";
            
            
            
        }
    }
}

-(void) changeSegmentSelected:(UISegmentedControl *) segControl{
    [segControl setSelectedSegmentIndex:2];
}

- (IBAction)SendButton:(id)sender {
    
    
    /**NSInteger row = [pickerView1 selectedRowInComponent:0];
     object = [Object objectAtIndex:row];
     NSInteger row2 = [pickerView1 selectedRowInComponent:1];
     NSArray *values = ( pickerView1 == Picker ? array : array2 );
     direction = [values objectAtIndex:row2];*/
    
    NSInteger row = [Picker selectedRowInComponent:0];
    object = [Object objectAtIndex:row];
    NSInteger row2 = [Picker selectedRowInComponent:1];
    direction = [array objectAtIndex:row2];
    confidence = (int)roundf(Slider.value);
    
    
    NSLog(@"Direction is :%@ \n",direction);
    NSLog(@"Ojbect is :%@ \n", object);
    NSLog(@"Confidence is : %d \n", confidence);
    NSLog(@"The number of points in pointList is :%d",n);
    
    
    
    //TCP sending method...
    
    SmartPhoneNodeMessage_Builder *nodeMsgBuilder = [SmartPhoneNodeMessage builder];
    [nodeMsgBuilder setId:(int32_t)5];
    [nodeMsgBuilder setPreposition:direction];
    [nodeMsgBuilder setObject:object];
    [nodeMsgBuilder setConfidence:confidence];
    [nodeMsgBuilder addAllCoordinates:pointList];
    SmartPhoneNodeMessage *nodeMsgToSend = [nodeMsgBuilder build];
    if (clientSocket != -1) {
        NSData *msgData = [nodeMsgToSend data];
        uint8_t lengthBytes[4];
        lengthBytes[0] = ([msgData length] >> 24) &0xFF;
        lengthBytes[1] = ([msgData length] >> 16) &0xFF;
        lengthBytes[2] = ([msgData length] >> 8) &0xFF;
        lengthBytes[3] = ([msgData length]) &0xFF;
        
        int result = send(clientSocket, (void*)lengthBytes, 4, 0);
        result = send(clientSocket, [msgData bytes], msgData.length, 0);
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Data was sent!"
                              message:nil 
                              delegate:self
                              cancelButtonTitle:@"Cool"
                              otherButtonTitles:nil];
        [alert show];
        
        
    } else {
        
        refreshRemindLabel.hidden = NO;
        
        [self performSelector:@selector(MoveRefreshLabelAway) withObject:nil afterDelay:1.00];
        [self performSelector:@selector(moveRefreshLabelBack) withObject:nil afterDelay:3.00];                
        printf("Client socket does not exist.\n");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Data sending failed. Please check wifi connection and try again."
                              message:nil 
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    
    
    imageToDisplay.image = [originalImage copy];
    
    CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
    UIGraphicsBeginImageContext(imgFrame.size);
    //CGContextRef ctx = UIGraphicsGetCurrentContext(); 
    [imageToDisplay.image drawInRect:imgFrame];

    //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
    //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
    
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
    
    
    
    
    
    n= 0;
    [pointList removeAllObjects];
    
    
    //re-initialize Slider's properties
    Slider.value = 50; 
    confidenceLabel.text = @"50";
    confidence = 50;
    
    
}


- (void) MoveRefreshLabelAway {
    CGRect frame = refreshRemindLabel.frame;
    originalx = refreshRemindLabel.frame.origin.x;
    originaly = refreshRemindLabel.frame.origin.y;
    frame.origin.x = 0;
    frame.origin.y = -150;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 3.00];
    refreshRemindLabel.frame = frame;
    [UIView commitAnimations];
    
    
}

- (void) moveRefreshLabelBack{
    CGRect frame = refreshRemindLabel.frame;
    refreshRemindLabel.hidden = YES;
    frame.origin.x = originalx;
    frame.origin.y = originaly;
    refreshRemindLabel.frame = frame;
    
}

- (void) MoveMapUpdatedLabelAway {
    CGRect frame = mapUpdatedLabel.frame;
    originalx = mapUpdatedLabel.frame.origin.x;
    originaly = mapUpdatedLabel.frame.origin.y;
    frame.origin.x = 0;
    frame.origin.y = -150;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 3.00];
    mapUpdatedLabel.frame = frame;
    [UIView commitAnimations];
    
    
}

- (void) moveMapUpdatedlBack{
    CGRect frame = mapUpdatedLabel.frame;
    mapUpdatedLabel.hidden = YES;
    frame.origin.x = originalx;
    frame.origin.y = originaly;
    mapUpdatedLabel.frame = frame;
    
}




- (IBAction)SliderChanged:(id)sender {
    int progressAsInt = (int)roundf(Slider.value);
    confidenceLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (interface == @"Main"){
        if (buttonNumber == @"2"){
            
            originalImage = [imageToDisplay.image copy];
            // point data interface
            n=1;
            UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:imageToDisplay];           
            
            
            InitialPoint = point;
            
            
            //add point coordinate to pointlist for sending
            CGFloat X = point.x * metersPixel;
            CGFloat Y = point.y * metersPixel;
            float h = 410 * metersPixel;
            X = X + leftX;
            Y = h - Y + bottomY;
            //NSLog(@"x: %f, y: %f", X,Y);
            
            
            SmartPhoneNodeMessage_Point_Builder *pointBuilder = [SmartPhoneNodeMessage_Point builder];
            [pointBuilder setX: (Float64) X];
            [pointBuilder setY: (Float64) Y];
            SmartPhoneNodeMessage_Point *pointToSend = [pointBuilder build];
            [pointList addObject: pointToSend];
            
            
            
            CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
            UIGraphicsBeginImageContext(imgFrame.size);
            //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
            NSLog(@"ImageView Size width:%f, height:%f", imageToDisplay.frame.size.width, imageToDisplay.frame.size.height);
            NSLog(@"Image Size width: %f, height: %f", imageToDisplay.image.size.width, imageToDisplay.image.size.height);
            CGContextRef ctx = UIGraphicsGetCurrentContext();   
            //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
            [imageToDisplay.image drawInRect:imgFrame];
            //[imageToDisplay drawRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineWidth(ctx, 5.0);
            CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, point.x, point.y);
            CGContextAddLineToPoint(ctx, point.x-0.1, point.y-0.1);
            CGContextStrokePath(ctx);
            imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            /**interface = @"SecondView";
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
             
             //add point coordinate to pointlist for sending
             CGFloat X = point.x;
             CGFloat Y = point.y;
             SmartPhoneNodeMessage_Point_Builder *pointBuilder = [SmartPhoneNodeMessage_Point builder];
             [pointBuilder setX: (Float64) X];
             [pointBuilder setY: (Float64) Y];
             SmartPhoneNodeMessage_Point *pointToSend = [pointBuilder build];
             [pointList addObject: pointToSend];
             */
            
            
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (interface == @"Main" && buttonNumber == @"2"){
        
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:imageToDisplay];
        CurrentPoint = [touch locationInView:imageToDisplay];
        
        
        CGFloat X = CurrentPoint.x;
        CGFloat Y = CurrentPoint.y;
        X = X * metersPixel;
        Y = Y * metersPixel;
        float h = 410 * metersPixel;
        X = X + leftX;
        Y= h - Y + bottomY;
        //NSLog(@"x: %f, y: %f", X,Y);


        SmartPhoneNodeMessage_Point_Builder *pointBuilder = [SmartPhoneNodeMessage_Point builder];
        [pointBuilder setX: (Float64) X];
        [pointBuilder setY: (Float64) Y];
        SmartPhoneNodeMessage_Point *pointToSend = [pointBuilder build];
        [pointList addObject: pointToSend];
        n = n+1;
        
        
        CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
        UIGraphicsBeginImageContext(imgFrame.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext(); 
        [imageToDisplay.image drawInRect:imgFrame];


        //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
       
        //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
        //[imageToDisplay drawRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
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
    if(interface == @"Main" && buttonNumber == @"2"){
        n= n+1;
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:imageToDisplay];
        CurrentPoint = [touch locationInView:imageToDisplay];
        
        //add current point coordinate values to pointList (for sending)
        CGFloat X = CurrentPoint.x * metersPixel;
        CGFloat Y = CurrentPoint.y * metersPixel;
        float h = 410 * metersPixel;
        X = X + leftX;
        Y= h - Y + bottomY;
        //NSLog(@"leftX: %f, bottomY: %f", leftX, bottomY);
        //NSLog(@"leftX:%f, topY: %f", leftX, bottomY + h);

        SmartPhoneNodeMessage_Point_Builder *pointBuilder = [SmartPhoneNodeMessage_Point builder];
        [pointBuilder setX: (Float64) X];
        [pointBuilder setY: (Float64) Y];
        SmartPhoneNodeMessage_Point *pointToSend = [pointBuilder build];
        [pointList addObject: pointToSend];
        n = n+1;
        
        CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
        UIGraphicsBeginImageContext(imgFrame.size);
        
        //draw out a line to the point where user moved to
        //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
        //[imageToDisplay drawRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
        [imageToDisplay.image drawInRect:imgFrame];
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
        Picker.hidden = NO;
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
    
    NSArray *values = array;
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
    
    NSArray *values = array;
    if (component ==1)
        return [values objectAtIndex:row];
    else {
        return [Object objectAtIndex:row];
    }
    
    
    
}


- (IBAction)Cancel:(id)sender {
    imageToDisplay.image = originalImage;
    
    CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
    UIGraphicsBeginImageContext(imgFrame.size);
    //CGContextRef ctx = UIGraphicsGetCurrentContext(); 
    [imageToDisplay.image drawInRect:imgFrame];

    //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
    //[imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
    
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
    
    int serverSocket = CreateTCPServerSocket(10002);
	if (serverSocket < 0) {
		printf("Socket creation failed\n");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Server Socket Creation Failed. Please restart the app."
                              message:nil 
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        
        return;
	}
    
	bool isRunning = true;
    int errors = 0;
    
    
    void *msgLengthBuffer = malloc(4);
	void *buffer;
    int msgLength = -1;

	while (isRunning && errors < 10) {
		printf("Waiting for new client.\n");
		clientSocket = AcceptTCPConnection(serverSocket);
		if (clientSocket < 0) {
			printf("Client failed\n");
            errors++;
		}
		while (isRunning && clientSocket >= 0) {
			//printf("Waiting for message.\n")
            
			int bytesReceived = recv(clientSocket, msgLengthBuffer, 4, 0);
            while (bytesReceived < 4){
                int newBytesReceived = recv(clientSocket, msgLengthBuffer +bytesReceived, 4 - bytesReceived, 0);
                bytesReceived = bytesReceived +newBytesReceived;
            }
            
            if (msgLength == -1){
                msgLength = ((uint8_t*)msgLengthBuffer)[0];
                msgLength <<= 8;
                msgLength += ((uint8_t*)msgLengthBuffer)[1];
                msgLength <<= 8;
                msgLength += ((uint8_t*)msgLengthBuffer)[2];
                msgLength <<= 8;
                msgLength += ((uint8_t*)msgLengthBuffer)[3];
                //msgLength = ntohl(msgLength);
                
                buffer = malloc(msgLength);
            }
            
            bytesReceived = recv (clientSocket, buffer, msgLength, 0);
            while (bytesReceived < msgLength){
                int newBytesReceived = recv(clientSocket, buffer + bytesReceived, msgLength - bytesReceived, 0);
                bytesReceived = bytesReceived + newBytesReceived;
            }
            
            msg = [SmartPhoneDataMessage parseFromData:[NSData dataWithBytes:buffer length:msgLength]];
            free(buffer);
            printf("ID: %i, Res: %ix%i\n", msg.id, msg.width, msg.height);
            metersPixel = msg.metersPerPixel;
            bottomY = msg.bottomY;
            leftX = msg.leftX;
            
            imgToDisplay = [UIImage imageWithData: msg.mapData];

            
            msgLength = -1;
            buffer = NULL;
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

    
    
    
    
    
    /**
     if (bytesReceived = recv(clientSocket, buffer + bytesReceived, length - bytesReceived, 
     recv(<#int#>, <#void *#>, <#size_t#>, <#int#>)
     
     
     
     if (bytesReceived <= 0) {
     if (bytesReceived == 0) {
     printf("Remote client closed.\n");
     } else if (bytesReceived < 0) {
     printf("Error occured while receiving message.i\n");
     }
     close(clientSocket);
     clientSocket = -1;
     }
     if (bytesReceived == 4)
     {
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
     readingLength = msgLength;
     }
     }
     else {
     //printf("Data receive complete. Bytes=%i\n", bytesReceived);
     void *datastart = msgbuffer +bufoffset;
     int bytestowrite = MIN(bufoffset + bytesReceived, msgLength) - bufoffset;
     if (bytestowrite > 0)
     memcpy(datastart, buffer, bytestowrite);
     else {
     printf("your bytestowrite is negative!!\n");
     bufoffset =0;
     msgLength = -1;
     msgbuffer = NULL;
     readingLength = 4;
     continue;
     }
     bufoffset = bufoffset + bytestowrite;
     }
     
     if (bufoffset == msgLength){
     msg = [SmartPhoneDataMessage parseFromData:[NSData dataWithBytes:msgbuffer length:msgLength]];
     free(msgbuffer);
     printf("ID: %i, Res: %ix%i\n", msg.id, msg.width, msg.height);
     metersPixel = msg.metersPerPixel;
     
     [self ImageConvert];
     
     bufoffset =0;
     msgLength = -1;
     msgbuffer = NULL;
     
     
     }
     
     
     
     
     
     }*/
    
    
   
//- (void) ImageConvert{
    /**CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     
     size_t dataLength = [msg mapData].length;
     
     void *dataCopy = malloc(dataLength);
     memcpy(dataCopy,[msg mapData].bytes, dataLength);
     CGContextRef gtx = CGBitmapContextCreate(dataCopy, msg.width, msg.height, 8, msg.width*4, colorSpace, kCGImageAlphaPremultipliedLast);
     CGImageRef toCGImage = CGBitmapContextCreateImage(gtx);
     imgToDisplay = [[UIImage alloc]initWithCGImage:toCGImage];
     free(dataCopy);
     CGImageRelease(toCGImage);
     CGColorSpaceRelease(colorSpace);*/
    
    
    //size_t dataLength = [msg mapData].length;
    
    //void *dataCopy = malloc(dataLength);
    //memcpy(dataCopy,[msg mapData].bytes, dataLength);
    
    
    
    //imgToDisplay= [UIImage alloc];
    
    
    //NSData *copy = [NSData dataWithData:msg.mapData];
    //[imgToDisplay initWithData:copy];
    //NSData *copy = [NSData dataWithBytes:msg.mapData length:dataLength];
    //NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"GoldenGate.png"]);
    
    
    //imgToDisplay = [UIImage imageWithData: msg.mapData];
    
    
    //free (dataCopy);
    
//}


/**- (IBAction)refresh:(id)sender {
 
 if (imgToDisplay == nil){
 imageToDisplay.image = originalImage;
 UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
 [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
 
 imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 
 
 }
 else{    
 imageToDisplay.image = imgToDisplay;
 originalImage = [imgToDisplay copy];
 UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
 [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
 
 imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 }
 
 
 
 }*/

/**- (void) refreshMap{
 if (imgToDisplay == nil){
 imageToDisplay.image = originalImage;
 UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
 [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
 
 imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 
 }
 else{    
 imageToDisplay.image = imgToDisplay;
 originalImage = [imgToDisplay copy];
 UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
 [imageToDisplay.image drawInRect:CGRectMake(0, 0, imageToDisplay.frame.size.width, imageToDisplay.frame.size.height)];
 
 imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 
 
 }
 
 
 }
 */


@end


