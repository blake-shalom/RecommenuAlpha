//
//  RMUButton.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/30/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUButton.h"

@implementation RMUButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted)
        [self setBackgroundColor:[UIColor RMUDarkGoodBlue]];
    else
        [self setBackgroundColor:[UIColor RMUGoodBlueColor]];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end
