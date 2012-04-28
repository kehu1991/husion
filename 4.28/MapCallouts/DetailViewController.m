
#import "DetailViewController.h"
#import "NodeHeartbeatMessage.pb.h"
#import "SketchView.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>



@implementation DetailViewController
@synthesize RefreshRemindLabel;
@synthesize MapUpdatedLabel;
@synthesize Picker2;
@synthesize background;
@synthesize scrollView;
@synthesize segmentControl;
@synthesize image;
@synthesize CancelButton;
@synthesize Picker;
@synthesize ConfidenceLabel;
@synthesize greyBack;
@synthesize label1;
@synthesize label2;
@synthesize Slider;
@synthesize Button;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    //set items in input interface invisible to user when initialized
    //imgBefore = FALSE;
    //imgLater = FALSE;
    label1.hidden = YES;
    label2.hidden = YES;
    Slider.hidden = YES;
    Button.hidden = YES;
    Picker.hidden = YES;
    ConfidenceLabel.hidden = YES;
    greyBack.hidden = YES;
    CancelButton.hidden = YES;
    Picker2.hidden = YES;
    RefreshRemindLabel.hidden = YES;
    MapUpdatedLabel.hidden = YES;
    
    [segmentControl setSelectedSegmentIndex:2];
     
    [Picker2 reloadAllComponents];
    [Picker2 selectRow:1 inComponent:0 animated:NO];
    [Picker2 selectRow:1 inComponent:1 animated:NO];
    [Picker reloadAllComponents];
    [Picker selectRow:1 inComponent:0 animated:NO];
    [Picker selectRow:1 inComponent:1 animated:NO];
    self.scrollView.delegate=self;

    
    scrollView.contentSize=CGSizeMake(755, 410);
    scrollView.contentInset=UIEdgeInsetsMake(0,0,0,0);
    
    [scrollView addSubview:background];
    self.scrollView.minimumZoomScale=0.8;
    self.scrollView.maximumZoomScale=30.0;
    [self.scrollView setContentOffset:CGPointMake(background.frame.size.width/2 - scrollView.frame.size.width/2, background.frame.size.height/2 - scrollView.frame.size.height/2)];

    [NSThread detachNewThreadSelector: @selector(Runloop) toTarget:self
                           withObject:nil];
    
      
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)ScrollView
{
    return ScrollView.scrollEnabled == YES? self.background : nil;
}


- (void)viewDidUnload
{
    [self setMapUpdatedLabel:nil];
    [self setRefreshRemindLabel:nil];
    [self setSegmentControl:nil];
    [self setScrollView:nil];
    [self setBackground:nil];
    [self setPicker2:nil];
    [self setCancelButton:nil];
    [self setImage:nil];
    [self setGreyBack:nil];
    [self setConfidenceLabel:nil];
    [self setPicker:nil];
    [self setButton:nil];
    [self setSlider:nil];
    [self setLabel2:nil];
    [self setLabel1:nil];
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc

{
    [label1 release];
    [label2 release];
    [Slider release];
    [Button release];
    [Picker release];
    [ConfidenceLabel release];
    [greyBack release];
    [image release];
    [CancelButton release];
    [Picker2 release];
    [background release];
    [scrollView release];
    [segmentControl release];
    [RefreshRemindLabel release];
    [MapUpdatedLabel release];
    [super dealloc];
}

- (IBAction)SegmentValueChanged:(id)sender {
    if ([sender selectedSegmentIndex]==0){

        [scrollView setZoomScale:1 animated:YES];
        scrollView.scrollEnabled = NO;

    }
    else {
        
        if ([sender selectedSegmentIndex] == 1) {

            [scrollView setZoomScale:1 animated:YES];
            scrollView.scrollEnabled = NO;

        }
        else {
            scrollView.scrollEnabled = YES;
        }
    }
}



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
    
    
    message = [[[[[NodeHeartbeatMessage builder] setId:(int32_t)5]
                 setIpaddress:address]
                setType:NodeHeartbeatMessage_NodeTypeSmartphone] build];
    
    int slen=sizeof(si_broadcast);
    //EBADF
    while (true) {
        NSData *msgData = [message data];
        error = sendto(s, [msgData bytes], [msgData length], 0, (struct sockaddr *) &si_broadcast, slen);
        if (error > 0) {
            //printf("Packet sent\n");
        } else {
            printf("error on send\n");
                        
        }
        
        sleep(1);
    }

    
}





@end
