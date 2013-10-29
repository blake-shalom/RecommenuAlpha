//
//  RMUPlainTextField.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/28/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//
#define SIZE_OF_INSET 20.0f
#import "RMUPlainTextField.h"

@implementation RMUPlainTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + SIZE_OF_INSET, bounds.origin.y, bounds.size.width - SIZE_OF_INSET, bounds.size.height);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + SIZE_OF_INSET, bounds.origin.y, bounds.size.width - SIZE_OF_INSET, bounds.size.height);
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
