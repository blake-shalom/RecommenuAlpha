//
//  RMUDonutGraph.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/31/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUDonutGraph.h"

#pragma mark - C - drawing functions

CGMutablePathRef createHoopPathFromCenterOfView(CGRect view, CGFloat outerRadius, CGFloat innerRadius, CGFloat theta, bool clockwise)
{
    
    if (theta == - M_PI / 2.0f)
        theta = 3 * M_PI / 2.0f;
    
    CGPoint arcCenter = CGPointMake((view.origin.x + view.size.width / 2), (view.origin.y + view.size.height / 2));
    CGFloat startAngle = -M_PI / 2.0f;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint start = CGPointMake(arcCenter.x , arcCenter.y - outerRadius);
    
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, outerRadius, startAngle, theta, clockwise);
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, innerRadius, theta, startAngle, !clockwise);
    
    if (theta != M_PI *2)
        CGPathAddLineToPoint(path, NULL, start.x, start.y);
    
    
    return path;
}

@implementation RMUDonutGraph


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGPoint arcCenter = CGPointMake((rect.origin.x + rect.size.width / 2), (rect.origin.y + rect.size.height / 2));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGFloat likesToRadians = 2 * M_PI * (self.likes/ (self.likes + self.dislikes));
    CGMutablePathRef likePath = createHoopPathFromCenterOfView(rect, 37.0f, 31.0f, likesToRadians, 1);
    CGContextAddPath(context, likePath);
    CGContextSetFillColorWithColor(context, [UIColor RMUGoodBlueColor].CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    CFRelease(likePath);

}


@end
