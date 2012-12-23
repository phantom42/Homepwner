//
//  Crosshairs.m
//  Homepwner
//
//  Created by Joe Coleman on 12/23/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "Crosshairs.h"

@implementation Crosshairs

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO ;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext() ;
    CGRect bounds = [self bounds] ;
    
    // figure out the center of the bounds rectangle
    CGPoint center ;
    center.x = bounds.origin.x + bounds.size.width/2.0 ;
    center.y = bounds.origin.y + bounds.size.height/2.0 ;
    
    // draw the crosshairs
    int crossHairLength = 40 ;
    CGContextSetLineWidth(ctx, 2) ;
    [[UIColor redColor] setStroke] ;
    CGContextMoveToPoint(ctx, center.x, center.y - crossHairLength) ;
    CGContextAddLineToPoint(ctx, center.x, center.y + crossHairLength) ;
    CGContextMoveToPoint(ctx, center.x, center.y) ;
    CGContextAddLineToPoint(ctx, center.x - crossHairLength, center.y ) ;
    CGContextAddLineToPoint(ctx, center.x + crossHairLength, center.y ) ;
    CGContextStrokePath(ctx) ;
}
// this makes it so that touches within the view are not captured. necessary for editing mode.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}


@end
