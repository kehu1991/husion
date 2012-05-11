//
//  SketchView.m
//  MapCallouts
//
//  Created by Ke Hu on 12-3-12.
//  Copyright (c) 2012 Cornell University. All rights reserved.
//

#import "SketchView.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include "TCPConnectionMethods.h"
#import "NodeHeartbeatMessage.pb.h"
#import "SmartPhoneMessages.pb.h"





static NSString *interface = @"Main";//Interface label. Main,

/**SketchView is the interface where an interior map shown with point and sketch implementation*/

@implementation SketchView

//Main view settings
@synthesize IDLabel;
@synthesize Console;
@synthesize textField;
@synthesize imageToDisplay;//interior map
@synthesize scrollView;


//Option Menu Settings
@synthesize Picker; //picker for doing point
@synthesize CancelButton;//cancel button after drew sth on the map
@synthesize label2;//label on the input interface
@synthesize label1;//label on the input interface
@synthesize Slider;//slider for confidence
@synthesize Button;//button for sending
@synthesize segmentControl;//point or sketch
@synthesize confidenceLabel;//label for confidence
@synthesize greyBack;//grey background of input interface
@synthesize array;//array for Picker's data
@synthesize pickerData;//picker's data setting


//points for drawing out the sketch
@synthesize InitialPoint;//for sketching. internal computing
@synthesize CurrentPoint;//for sketching. internal computing
@synthesize PreviousPoint;//for sketching. internal computing





-(id)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]){
        
        [self addSubview:imageToDisplay];
        
        //initialize the data input in option menu which is hidden
        confidence = 50;
        self.pickerData = array;
        buttonNumber = @"3";
        array = [[NSArray alloc]initWithObjects: @"inside", @"outside", nil];
        
        
        //set client socket to -1
        clientSocket = -1;
        
        //initialize map data
        pointList = [[NSMutableArray alloc]init];
        metersPixel = 1;
        bottomY = 0;
        leftX = 0;
        idNumber = -1;
        newMap = FALSE;
        
        //set text label read "enter your ID"
        [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Please enter your ID number." waitUntilDone:FALSE];
        
        
        //run thread on TCP connection
        [NSThread detachNewThreadSelector: @selector(DataExchangeConnection) toTarget:self withObject:nil];
        
        //run thread on UDP connection
        [NSThread detachNewThreadSelector: @selector(Runloop) toTarget:self withObject:nil];
        
        
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
    [scrollView release];
    [Console release];
    [textField release];
    [IDLabel release];
    [super dealloc];
}



//segmented control. 0 for Refresh, 1 for Sketch and 2 for Zoom
- (IBAction)Selected:(id)sender {
    
    //Refresh. Set the map to updated one. If failed to update, remain the original map.
    //Jump back to zoom after pressed.
    if ([sender selectedSegmentIndex]==0){
        
        buttonNumber = @"1";
        
        if(imgToDisplay != nil)
        {    
            [self setMapImage:imgToDisplay update:TRUE];
        }
        
        //check if the map is updated or the original one is already most updated
        if (newMap == TRUE){
            [self performSelector:@selector(UpdateStateConsole:) withObject:@"Map updated."];
            newMap = FALSE;
        }
        else {
            [self performSelector:@selector(UpdateStateConsole:) withObject:@"No new map."];
        }
        
        //jump to zoom mode
        [self performSelector:@selector(changeSegmentSelected:) withObject:sender afterDelay:0.40];
        
    }
    else {
        
        //Sketch mode
        if ([sender selectedSegmentIndex] == 1) {
            buttonNumber = @"2";
            self.pickerData = array;
        }
        
        //Zoom mode
        else {
            buttonNumber = @"3";
        }
    }
}


//method to change to Zoom mode after Refresh pressed
-(void) changeSegmentSelected:(UISegmentedControl *) segControl{
    [segControl setSelectedSegmentIndex:2];
}


//Method to send SmartPhoneMessages 
- (IBAction)SendButton:(id)sender {
    
    //give an alert if ID number is not set or invalid
    if (idNumber <= 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"ID number is invalid or not initialized. Please set your ID number before sending."
                              message:nil 
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    else {
        
        
        NSInteger row2 = [Picker selectedRowInComponent:0];
        direction = [array objectAtIndex:row2];
        confidence = (int)roundf(Slider.value);
        //Create the SmartPhoneNodeMessage from data input
        SmartPhoneNodeMessage_Builder *nodeMsgBuilder = [SmartPhoneNodeMessage builder];
        [nodeMsgBuilder setId:(int32_t)idNumber];
        [nodeMsgBuilder setPreposition:direction];
        //[nodeMsgBuilder setObject:object];
        [nodeMsgBuilder setConfidence:confidence];
        [nodeMsgBuilder addAllCoordinates:pointList];
        SmartPhoneNodeMessage *nodeMsgToSend = [nodeMsgBuilder build];
        
        //send data if client socket exists
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
            
        } 
        
        //if client socket doesn't exist, give an alert
        else {
            printf("Client socket does not exist.\n");
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Data sending failed. Please check wifi connection and try again."
                                  message:nil 
                                  delegate:self
                                  cancelButtonTitle:@"Okay"
                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
        
    }
    
    //set the map to the one without skecth drawing on it and close input mode
    [self closeInputMode];
    
    
    
}


//show the slider value when slider is changed in confidence label
- (IBAction)SliderChanged:(id)sender {
    int progressAsInt = (int)roundf(Slider.value);
    confidenceLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    
}

//Method to handle skecth
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
            [self addPointToPointList:point];
            
            PreviousPoint = CGPointMake(point.x + 0.01, point.y + 0.01);
            CurrentPoint = point;
            
            [self drawSketchOut: FALSE];
            
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (interface == @"Main" && buttonNumber == @"2"){
        
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:imageToDisplay];
        CurrentPoint = [touch locationInView:imageToDisplay];
        
        
        [self addPointToPointList:CurrentPoint];
        [self drawSketchOut: FALSE];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(interface == @"Main" && buttonNumber == @"2"){
        n= n+1;
        UITouch *touch = [touches anyObject];
        PreviousPoint = [touch previousLocationInView:imageToDisplay];
        CurrentPoint = [touch locationInView:imageToDisplay];
        
        //add current point coordinate values to pointList (for sending)
        [self addPointToPointList:CurrentPoint];
        [self drawSketchOut: TRUE];
        
        
        interface = @"SecondView";
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *values = array;
    return [values count];
    
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    NSArray *values = array;
    return [values objectAtIndex:row];
    
    
}


- (IBAction)Cancel:(id)sender {
    [self closeInputMode];
}


-(void) UpdateStateConsole: (NSString *)content{
    
    [UIView beginAnimations:@"animateText" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0f];
    [Console setAlpha:0];
    [Console setText:content];
    [Console setAlpha:1];
    [UIView commitAnimations];
    [self setNeedsDisplay];
    
    
}

-(void) closeInputMode{
    n= 0;
    [pointList removeAllObjects];
    
    
    //re-initialize Slider's properties
    Slider.value = 50; 
    confidenceLabel.text = @"50";
    confidence = 50;
    
    [self setMapImage:originalImage update:FALSE];
    
    Slider.hidden = YES;
    Picker.hidden = YES;
    Button.hidden = YES;
    label1.hidden = YES;
    label2.hidden = YES;
    CancelButton.hidden = YES;
    confidenceLabel.hidden = YES;
    greyBack.hidden = YES;
    segmentControl.hidden = NO;
    imageToDisplay.hidden = NO;
    interface = @"Main";
    
    
}


//method handling TCP connection (data exchange with base station)
-(void)DataExchangeConnection {
    
    int serverSocket = CreateTCPServerSocket(10002);
	
    //server socket creation failed
    if (serverSocket < 0) {
		printf("Socket creation failed\n");
        [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Socket creation failed" waitUntilDone:FALSE];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Server Socket Creation Failed. Please restart the app."
                              message:nil 
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        
        return;
	}
    
    //else try connect to client socket
	bool isRunning = true;
    //int errors = 0;
    
    
    void *msgLengthBuffer = malloc(4);
	void *buffer;
    int msgLength = -1;
    
	while (isRunning) {
        
        if(idNumber > 0){
            printf("Waiting for new client.\n");
            
            [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Waiting for new client" waitUntilDone:FALSE];
            
            clientSocket = AcceptTCPConnection(serverSocket);
            
            //client socket connection failed
            if (clientSocket < 0) {
                printf("Client failed\n");
                [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Client failed" waitUntilDone:FALSE];
                
            }
            
            //else remind the user it's handling client now
            else {
                [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Handling client" waitUntilDone:FALSE];
                
            }
            
            int set = 1;
            //struct timeval tv;
            setsockopt(clientSocket, SOL_SOCKET, SO_NOSIGPIPE, (void *)&set, sizeof(int));
            /**tv.tv_sec = 30;
            tv.tv_usec = 0;
            
            if (setsockopt(clientSocket, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv,  sizeof tv))
            {
                perror("setsockopt");
                 [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Fail to set timeout" waitUntilDone:FALSE];
                //return -1;
            }*/
            
            //while connected
            while (isRunning && clientSocket >= 0) {
                printf("Waiting for message.\n");
                //[self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Waiting for message" waitUntilDone:FALSE];
                
                //get the first 4 bytes which indiate the message length
                int bytesReceived = recv(clientSocket, msgLengthBuffer, 4, 0);
                
                //if bytesReceived <= 0, connection failed or error occured. Close client socket.
                // and wait for new client
                if (bytesReceived <= 0){
                    if (bytesReceived == 0){
                        printf("Remote client closed.\n");
                        [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Remote client closed" waitUntilDone:FALSE];
                    }
                    else {
                        printf("Error occured while receiving message.\n");
                        [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Error occured while receiving message" waitUntilDone:FALSE];
                    }
                    
                    close(clientSocket);
                    clientSocket = -1;
                }
                //else fill the first 4 bytes to get the message length, then fill the message length
                // bytes to get the full message
                else {
                    while (bytesReceived < 4 && clientSocket >=0 && bytesReceived > 0){
                        
                            int newBytesReceived = recv(clientSocket, msgLengthBuffer +bytesReceived, 4 - bytesReceived, 0);
                        if (newBytesReceived <=0){
                            close(clientSocket);
                            clientSocket =-1;
                            break;
                        }
                            
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
                    
                    
                    while (bytesReceived < msgLength && clientSocket >=0 && bytesReceived > 0){
                        
                            int newBytesReceived = recv(clientSocket, buffer + bytesReceived, msgLength - bytesReceived, 0);
                        if (newBytesReceived <=0){
                            close(clientSocket);
                            clientSocket = -1;
                            break;
                        }
                            bytesReceived = bytesReceived + newBytesReceived;
                        
                    }
                    
                    if (clientSocket >=0 && bytesReceived > 0){
                        //convert the bit message to smartPhoneDataMessage
                        msg = [SmartPhoneDataMessage parseFromData:[NSData dataWithBytes:buffer length:msgLength]];
                        free(buffer);
                        printf("ID: %i, Res: %ix%i\n", msg.id, msg.width, msg.height);
                        //NSString *text = [NSString stringWithFormat:@"New map received from ID: %i", msg.id];
                        [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"New map received from base station" waitUntilDone:FALSE];
                        
                        //decode all the data from msg
                        metersPixel = msg.metersPerPixel;
                        bottomY = msg.bottomY;
                        leftX = msg.leftX;
                        imgToDisplay = [UIImage imageWithData: msg.mapData];
                        newMap = TRUE;
                    }
                    
                    msgLength = -1;
                    buffer = NULL;
                    
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
    [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Server thread closing." waitUntilDone:FALSE];
    
}




//Method to maintain UDP connection - send NodeHeartBeatMessage
- (void) Runloop {
    address = 0;
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = ((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr.s_addr;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    int s =socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    int broadcast = 1;
    int error;
    if ((s)==-1){
        printf("ERROR: Failed to make socket\n");
    }
    error = setsockopt(s,SOL_SOCKET,SO_BROADCAST,
                       &broadcast,sizeof broadcast);
    if(error)
    {
        printf("setsockopt - SO_SOCKET \n");
    }
    
    struct sockaddr_in si_broadcast, si_recv;
    si_recv.sin_family = AF_INET;
    si_recv.sin_port = 10005;
    si_recv.sin_addr.s_addr = INADDR_ANY;
    memset(si_recv.sin_zero,'\0',sizeof si_recv.sin_zero);
    
    error = bind(s, (struct sockaddr*) &si_recv, sizeof si_recv);
    if(error)
    {
        printf("bind\n");
    }
    
    memset((char *) &si_broadcast, 0, sizeof(si_broadcast));
    si_broadcast.sin_family = AF_INET;
    si_broadcast.sin_port = htons(10000);
    si_broadcast.sin_addr.s_addr = htonl(0x0affffff);
    
    
    //int errorCount = 0;
    
    int slen=sizeof(si_broadcast);
    //EBADF
    while (true) {
        if (idNumber > 0){
            
            message = [[[[[NodeHeartbeatMessage builder] setId:(int32_t)idNumber]
                         setIpaddress:address]
                        setType:NodeHeartbeatMessage_NodeTypeSmartphone] build];
            
            NSData *msgData = [message data];
            error = sendto(s, [msgData bytes], [msgData length], 0, (struct sockaddr *) &si_broadcast, slen);
            if (error > 0) {
                //errorCount = 0;
                //printf("Packet sent\n");
            } else {
                printf("error on send\n");
                //errorCount = errorCount + 1;
                [self performSelectorOnMainThread:@selector(UpdateStateConsole:) withObject:@"Wifi connection lost" waitUntilDone:FALSE];
                close(clientSocket);
                clientSocket = -1;
                
                /**if (errorCount >= 10)
                 {
                 close(clientSocket);
                 clientSocket = -1;
                 errorCount = 0;
                 }*/
                
                
                
            }
            
            sleep(1);
        }
    }
    
    
    
    
}




- (IBAction)userDoneEnteringText:(id)sender {
    UITextField *theField = (UITextField*)sender;
    idNumber = [theField.text intValue];
    if (idNumber > 0){
        IDLabel.textColor =  [UIColor redColor];
        IDLabel.text =[NSString stringWithFormat:@"ID: %@",theField.text];
        
        [self performSelector:@selector(hideTextField) withObject:nil afterDelay:2];
    }
    else {
        [self UpdateStateConsole:@"Invalid, please try again."];
        //Console.text = @"Invalid, please try again.";
    }
}



-(void) hideTextField{
    
    [UIView beginAnimations:@"animateText" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0f];
    [textField setAlpha:0];
    [UIView commitAnimations];
    [self setNeedsDisplay];
    
}


-(void) setMapImage: (UIImage *)image update:(BOOL) newImage{
    imageToDisplay.image = image;
    CGRect imgFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    if (newImage == TRUE){
        
        imageToDisplay.frame = imgFrame;
        scrollView.contentSize = imgFrame.size;
    }
    
    UIGraphicsBeginImageContext(imgFrame.size);
    [imageToDisplay.image drawInRect:imgFrame];
    [imageToDisplay setImage: UIGraphicsGetImageFromCurrentImageContext()];
    
    UIGraphicsEndImageContext();
    
    
}


-(void) addPointToPointList: (CGPoint) point{
    CGFloat X = point.x * metersPixel;
    CGFloat Y = point.y * metersPixel;
    float h = imageToDisplay.image.size.height * metersPixel;
    X = X + leftX;
    Y = h - Y + bottomY;
    
    
    SmartPhoneNodeMessage_Point_Builder *pointBuilder = [SmartPhoneNodeMessage_Point builder];
    [pointBuilder setX: (Float64) X];
    [pointBuilder setY: (Float64) Y];
    SmartPhoneNodeMessage_Point *pointToSend = [pointBuilder build];
    [pointList addObject: pointToSend];
    n= n+1;
    
    
}

-(void)drawSketchOut: (BOOL) touchEnd{
    CGRect imgFrame = CGRectMake(0, 0, imageToDisplay.image.size.width, imageToDisplay.image.size.height);
    UIGraphicsBeginImageContext(imgFrame.size);
    
    //draw out a line to the point where user moved to
    //UIGraphicsBeginImageContext(imageToDisplay.frame.size); 
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [imageToDisplay.image drawInRect:imgFrame];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, PreviousPoint.x, PreviousPoint.y);
    CGContextAddLineToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
    
    if (touchEnd == TRUE)
    {
        CGContextMoveToPoint(ctx, CurrentPoint.x, CurrentPoint.y);
        CGContextAddLineToPoint(ctx, InitialPoint.x, InitialPoint.y);
    }
    CGContextStrokePath(ctx);
    imageToDisplay.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
@end


