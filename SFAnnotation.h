/*
     File: SFAnnotation.h 
 Abstract: The custom MKAnnotation object representing the city of San Francisco. 
  Version: 1.2 
  
   
 */

#import <MapKit/MapKit.h>

@interface SFAnnotation : NSObject <MKAnnotation>
{
    UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

@end


