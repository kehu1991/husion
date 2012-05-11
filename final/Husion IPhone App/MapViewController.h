#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class DetailViewController;

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    MKMapView *mapView;
    DetailViewController *detailViewController;
    NSMutableArray *mapAnnotations;
    
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;



@property (nonatomic, retain) NSMutableArray *mapAnnotations;

+ (CGFloat)annotationPadding;
+ (CGFloat)calloutHeight;

- (IBAction)QuadAction:(id)sender;
- (IBAction)LabAction:(id)sender;



@end
