//
//  ScrollView.m
//  MapCallouts
//
//  Created by Ke Hu on 12-4-23.
//  Copyright (c) 2012 Cornell University. All rights reserved.
//

#import "ScrollView.h"
#import "SketchView.h"

@implementation ScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.scrollEnabled == NO){
        [self.superview touchesBegan:touches withEvent:event];
    }
   
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.scrollEnabled == NO){
        [self.superview touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.scrollEnabled == NO){
        [self.superview touchesEnded:touches withEvent:event];
    }
}
 


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
