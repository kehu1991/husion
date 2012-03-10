/*
     File: DetailViewController.m 
 Abstract: The detail view controller used for displaying the Golden Gate Bridge. 
  Version: 1.2 
  
 
 */

#import "DetailViewController.h"


static NSString *buttonNumber = @"1";
//static NSArray *array [[NSArray alloc] initWithObjects: 

@implementation DetailViewController
@synthesize slider;
@synthesize SegmentControl;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib
- (void)viewDidLoad
{
    [super viewDidLoad];
    slider.hidden = YES;
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [self setSegmentControl:nil];
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    //[TabPoint release];
    [SegmentControl release];
    
    [slider release];
    [super dealloc];
}

//added to give pop out view on whether to send message or not
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (buttonNumber == @"1"){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        CGFloat X = point.x;
        CGFloat Y = point.y;
        NSString *a = [NSString stringWithFormat:@"%.2f", X];
        NSString *b = [NSString stringWithFormat:@"%.2f", Y];
        
        
        NSString *warning = [NSString stringWithFormat:@"The point value is (%@,%@).", a, b];
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle: warning 
                                      delegate:self 
                                      cancelButtonTitle:@"No Way!" 
                                      destructiveButtonTitle:@"Yes, I'm Sure!" 
                                      otherButtonTitles:nil];
        [actionSheet showInView:self.view];
        
        /**UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle: warning 
                              message: @"Are you sure?" 
                              delegate: self 
                              cancelButtonTitle: @"No way!" 
                              otherButtonTitles: @"Yes, I'm Sure!",nil];
        [alert show];
         */


        }
    
    //else if (buttonNumber == @"2"){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        
    //}
}

- (void) actionSheet :(UIActionSheet *)actionSheet 
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex])
    {
       
        slider.hidden = NO;
            
    }
 
}


- (IBAction)Selected:(id)sender {
        
    if ([sender selectedSegmentIndex]==0){
       
        buttonNumber = @"1";
    }
    else {
        buttonNumber = @"2";
    }

}
@end
