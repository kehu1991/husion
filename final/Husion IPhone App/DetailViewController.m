
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

@synthesize Console;
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
    
    //hide option menu items
    label1.hidden = YES;
    label2.hidden = YES;
    Slider.hidden = YES;
    Button.hidden = YES;
    Picker.hidden = YES;
    [Picker reloadAllComponents];
    [Picker selectRow:1 inComponent:0 animated:NO]; //set picker selected component at row 1
    ConfidenceLabel.hidden = YES;
    greyBack.hidden = YES;
    CancelButton.hidden = YES;
    
    //set segmentControll default mode : ZOOM
    [segmentControl setSelectedSegmentIndex:2];
    

    //set scrollView
    self.scrollView.delegate=self;    
    scrollView.contentSize=CGSizeMake(background.frame.size.width, background.frame.size.height);  //content size the same as background image
    scrollView.contentInset=UIEdgeInsetsMake(0,0,0,0);
    [scrollView addSubview:background]; //add background image as subview to enable touching event on it in SketchView
    self.scrollView.minimumZoomScale=0.3; //set zoom scale. minimum and maximum
    self.scrollView.maximumZoomScale=15.0;
    
      
}

//check if scrollEnabled. If so set view to zoom as background image (if not set will be the whole screen including segmented control. Otherwise nil.
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)ScrollView
{
    return ScrollView.scrollEnabled == YES? self.background : nil;
}


- (void)viewDidUnload
{
    [self setConsole:nil];
    [self setSegmentControl:nil];
    [self setScrollView:nil];
    [self setBackground:nil];
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
    [Picker release];
    [background release];
    [scrollView release];
    [segmentControl release];
    [Console release];
    [super dealloc];
}


//check scrollEnabled - if ZOOM, set YES. If Refresh, set YES and zoomScale to 1. If Sketch set NO.
//set here because only works in viewController
- (IBAction)SegmentValueChanged:(id)sender {
    if ([sender selectedSegmentIndex]==0){
        scrollView.scrollEnabled = YES;
        [scrollView setZoomScale:1 animated:YES];

    }
    else {
        
        if ([sender selectedSegmentIndex] == 1) {
            scrollView.scrollEnabled = NO;

        }
        else {
            scrollView.scrollEnabled = YES;
        }
    }
}



@end
