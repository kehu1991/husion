
#import "MapViewController.h"
#import "DetailViewController.h"
#import "EngMapAnnotation.h"
#import "LabMapAnnotation.h"

enum
{
    kQuadAnnotationIndex = 0,
    kRhodesAnnotationIndex
};

@implementation MapViewController


@synthesize mapView, detailViewController, mapAnnotations;


#pragma mark -

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}
+ (CGFloat)calloutHeight;
{
    return 40.0f;
}

#pragma mark -
#pragma mark ButtonActions


//When button on the bottom is pressed
- (IBAction)QuadAction:(id)sender {
    
    [self gotoEngQuad];
    
    [self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist
    
    [self.mapView addAnnotation:[self.mapAnnotations objectAtIndex:kQuadAnnotationIndex]];

}

- (IBAction)LabAction:(id)sender {
    
    [self gotoRhodes];
    [self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist
    
    [self.mapView addAnnotation:[self.mapAnnotations objectAtIndex:kRhodesAnnotationIndex]];

}


//move the center of the map to corresponding locations
- (void)gotoRhodes
{
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 42.443348;
    newRegion.center.longitude = -76.481795;
    newRegion.span.latitudeDelta = 0.005872;
    newRegion.span.longitudeDelta = 0.004863;
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)gotoEngQuad
{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 42.444547;
    newRegion.center.longitude = -76.48341;
    newRegion.span.latitudeDelta = 0.005872;
    newRegion.span.longitudeDelta = 0.004863;
    [self.mapView setRegion:newRegion animated:YES];

}


- (void)viewDidAppear:(BOOL)animated
{
    // bring back the toolbar
    [self.navigationController setToolbarHidden:NO animated:NO];
}


- (void)viewDidLoad
{
    self.mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid

    // create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
    
    // create out annotations array (in this example only 2)
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
    
    // annotation for the Engineering Quad
    EngMapAnnotation *sfAnnotation = [[EngMapAnnotation alloc] init];
    [self.mapAnnotations insertObject:sfAnnotation atIndex:kQuadAnnotationIndex];
    [sfAnnotation release];
    
    // annotation for Lab Map
    LabMapAnnotation *bridgeAnnotation = [[LabMapAnnotation alloc] init];
    [self.mapAnnotations insertObject:bridgeAnnotation atIndex:kRhodesAnnotationIndex];
    [bridgeAnnotation release];
    
    [self gotoRhodes];    //go to Rhodes initially
}

- (void)viewDidUnload
{
    
    self.mapAnnotations = nil;
    self.detailViewController = nil;
    self.mapView = nil;
}

- (void)dealloc 
{
    [mapView release];
    [detailViewController release];
    [mapAnnotations release];
        
    [super dealloc];
}




#pragma mark -
#pragma mark MKMapViewDelegate


//push the view to next view - detail view controller
- (void)showDetails:(id)sender  //show detail view controller when button "Rhodes" pressed
{
    [self showDetailView];
    
}

- (void)showEngView:(id)sender
{
    [self showDetailView];


}

-(void) showDetailView{
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    UIImage *backgroundImage = [UIImage imageNamed:@"NoMapImage.png"]; //set default image
    self.detailViewController.background.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
    
    self.detailViewController.background.image = backgroundImage;
    self.detailViewController.scrollView.contentSize = CGSizeMake(backgroundImage.size.width, backgroundImage.size.height);
    self.detailViewController.scrollView.contentOffset = CGPointMake(backgroundImage.size.width/2 -self.detailViewController.scrollView.frame.size.width/2, backgroundImage.size.height/2 -  self.detailViewController.scrollView.frame.size.height/2);

}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[LabMapAnnotation class]]) // for Lab map
    {
        // try to dequeue an existing pin view first
        static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
                                        [mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                             initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;

            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    else if ([annotation isKindOfClass:[EngMapAnnotation class]])   // for Eng Quad
    {
        static NSString* SFAnnotationIdentifier = @"SFAnnotationIdentifier";
        MKPinAnnotationView* pinView =
            (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
        if (!pinView)
        {
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:SFAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showEngView:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;

            
        }
            
            
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

@end
