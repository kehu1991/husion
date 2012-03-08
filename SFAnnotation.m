/*
     File: SFAnnotation.m 
 Abstract: The custom MKAnnotation object representing the city of San Francisco. 
  Version: 1.2 
  
   
 */

#import "SFAnnotation.h"

@implementation SFAnnotation 

@synthesize image;
@synthesize latitude;
@synthesize longitude;


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 42.443348;
    theCoordinate.longitude = -76.481795;
    return theCoordinate; 
}

- (void)dealloc
{
    [image release];
    [super dealloc];
}

- (NSString *)title
{
    return @"Autonomous Systems Lab";
}

// optional
//- (NSString *)subtitle
//{
//    return @"Founded: June 29, 1776";
//}

@end
