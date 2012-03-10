/*
     File: DetailViewController.m 
 Abstract: The detail view controller used for displaying the Golden Gate Bridge. 
  Version: 1.2 
  
 
 */

#import "DetailViewController.h"

static NSString *buttonNumber = @"1";

//static NSArray *array [[NSArray alloc] initWithObjects: 

@implementation DetailViewController
@synthesize SegmentControl;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
       [self setSegmentControl:nil];
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [SegmentControl release];
    
    [super dealloc];
}
/**
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
*/

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
        
        /**UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle: warning 
                                      delegate:self 
                                      cancelButtonTitle:@"No Way!" 
                                      destructiveButtonTitle:@"Yes, I'm Sure!" 
                                      otherButtonTitles:nil];
        [actionSheet showInView:self.view];*/
        
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle: warning 
                              message: @"Are you sure?" 
                              delegate: self 
                              cancelButtonTitle: @"No way!" 
                              otherButtonTitles: @"Yes, I'm Sure!",nil];
        [alert show];

        

        }
    
    else {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        
    }
}



/**- (void) actionSheet :(UIActionSheet *)actionSheet 
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex])
    {
                    
    }
 
}*/


- (IBAction)Selected:(id)sender {
    
    if ([sender selectedSegmentIndex] == 0){
        buttonNumber = @"1";
        //slider.hidden = NO;
    }
    if ([sender selectedSegmentIndex] ==1){
        buttonNumber = @"2";
        //slider.hidden = YES;

    }

}
    


@end
