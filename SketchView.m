//
//  SketchView.m
//  MapCallouts
//
//  Created by Ke Hu on 12-3-10.
//  Copyright (c) 2012年 Cornell University. All rights reserved.
//

#import "SketchView.h"

@implementation SketchView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;

}


/**- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
            }
    return self;
}

*/


/**- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGContextSetLineWidth(context, 2.0); 
    UIColor *color= [UIColor blueColor];
    CGContextSetStrokeColorWithColor(context, color.CGColor); 
    
    CGContextMoveToPoint(context, 10.0,10.0 ); 
    CGContextAddLineToPoint(context, 100.0,100.0); 
    CGContextStrokePath(context);


}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
