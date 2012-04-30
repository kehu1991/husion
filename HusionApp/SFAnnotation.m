
#import "SFAnnotation.h"

@implementation SFAnnotation 

/**@synthesize image;
@synthesize latitude;
@synthesize longitude;

*/
- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 42.444547;
    theCoordinate.longitude = -76.48341;
    return theCoordinate; 
}

- (void)dealloc
{
    //[image release];
    [super dealloc];
}

- (NSString *)title
{
    return @"Engineering Quad";
}

// optional
- (NSString *)subtitle
{
    return @"Cornell University";
}

@end
