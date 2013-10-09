//
//  RMUMeal.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/25/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMeal.h"

@implementation RMUMeal

- (id)initWithName:(NSString*) name withDescription:(NSString*) description withLikes:(NSInteger) likes withDislikes:(NSInteger) dislikes withIdentifier:(NSString*)identifier
{
    self = [super init];
    if (self) {
        self.mealName = name;
        self.mealDescription = description;
        self.mealLikes = likes;
        self.mealDislikes = dislikes;
        self.mealID = identifier;
        self.selected = NO;
    }
    return self;
}

@end
