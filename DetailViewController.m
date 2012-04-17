/*
     File: DetailViewController.m 
 Abstract: The detail view controller used for displaying the Golden Gate Bridge. 
  Version: 1.2 
  
 
 */

#import "DetailViewController.h"
#import "SketchView.h"

static NSString *buttonNumber = @"1"; //"1" stands for Point and "2" stands for "Sketch"
static NSString *directionSelected; //directions selected in Point
static NSString *confidence = @"50";// confidence for point input
static NSString *a;
static NSString *b;

@implementation DetailViewController
@synthesize confidenceLabel;
@synthesize pointValueLabel;
@synthesize sketchView;


@synthesize slider;
@synthesize directionPicker;
@synthesize Button;
@synthesize PickerLabel;
@synthesize SliderLabel;
@synthesize SegmentControl;
@synthesize pickerData;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib
- (void)viewDidLoad
{
    [super viewDidLoad];
    slider.hidden = YES;
    NSArray *array = [[NSArray alloc]initWithObjects: @"To the right", @"To the left", @"In front", @"Behind", @"Near around", nil];
    
    self.pickerData = array;
    

    directionPicker.hidden = YES;
    Button.hidden = YES;
    PickerLabel.hidden = YES;
    SliderLabel.hidden = YES;
    confidenceLabel.hidden = YES;
    pointValueLabel.hidden = YES;
}

- (void)viewDidUnload
{
    
    [self setPointValueLabel:nil];
    [self setConfidenceLabel:nil];
    [self setSliderLabel:nil];
    [self setPickerLabel:nil];
    [self setButton:nil];
    [self setDirectionPicker:nil];
    
    [self setSlider:nil];
    [self setSegmentControl:nil];
    self.sketchView = nil;
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    
    [SegmentControl release];
    
    [slider release];
    [directionPicker release];
    [Button release];
    [PickerLabel release];
    [SliderLabel release];
    [confidenceLabel release];
    [pointValueLabel release];
    [sketchView release];
    
    [super dealloc];
}

//added to give pop out view on whether to send message or not
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if (buttonNumber == @"1"){

        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        CGFloat X = point.x;
        CGFloat Y = point.y;
        a = [NSString stringWithFormat:@"%.2f", X];
        b = [NSString stringWithFormat:@"%.2f", Y];
        pointValueLabel.text = [NSString stringWithFormat:@"(%@,%@)", a, b];
        
        
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
    
        

}

- (void) actionSheet :(UIActionSheet *)actionSheet 
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex])
    {
       
        slider.hidden = NO;
        directionPicker.hidden = NO;
        Button.hidden = NO;
        PickerLabel.hidden = NO;
        SliderLabel.hidden = NO;
        confidenceLabel.hidden = NO;
        pointValueLabel.hidden = NO;
                    
    }
 
}


- (IBAction)Selected:(id)sender {
    slider.hidden = YES;
    directionPicker.hidden = YES;
    Button.hidden = YES;
    PickerLabel.hidden = YES;
    SliderLabel.hidden = YES;
    confidenceLabel.hidden = YES;
    pointValueLabel.hidden = YES;
        
    if ([sender selectedSegmentIndex]==0){
       
        buttonNumber = @"1";
        
    }
    else {
        buttonNumber = @"2";
                    
    }

}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [pickerData count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return [pickerData objectAtIndex:row];
}

- (IBAction)ButtonPressed:(id)sender {
    NSInteger row = [directionPicker selectedRowInComponent:0];
    NSString *selected = [pickerData objectAtIndex:row];
    NSString *title = [[NSString alloc] initWithFormat:
                       @"The direction you selected is %@ and your confidence level is %@", selected, confidence];
    directionSelected = selected;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Point data is sent!"
                                                    message:title
                                                   delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
    slider.hidden = YES;
    directionPicker.hidden = YES;
    Button.hidden = YES;
    PickerLabel.hidden = YES;
    SliderLabel.hidden = YES;
    confidenceLabel.hidden = YES;
    pointValueLabel.hidden = YES;

}
- (IBAction)sliderChanged:(id)sender {
    int progressAsInt = (int)roundf(slider.value);
    confidenceLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    confidence = confidenceLabel.text;
}
@end
