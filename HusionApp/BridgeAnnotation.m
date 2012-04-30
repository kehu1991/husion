/**/

#import "BridgeAnnotation.h"

@implementation BridgeAnnotation

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 42.443348;
    theCoordinate.longitude = -76.481795;
    return theCoordinate; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return @"Autonomous Systems Lab";
}

// optional
- (NSString *)subtitle
{
    return @"Husion Project Team";
}

- (void)dealloc
{
    [super dealloc];
}

@end