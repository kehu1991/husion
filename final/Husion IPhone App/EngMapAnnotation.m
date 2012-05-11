
//
//  EngMapAnnotation.m
//  This is the setting for map Annotation. MapKit.
//  Husion
//
//  Created by Ke Hu on 12-4-23.
//  Copyright (c) 2012 Cornell University. All rights reserved.
//


#import "EngMapAnnotation.h"

@implementation EngMapAnnotation


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
