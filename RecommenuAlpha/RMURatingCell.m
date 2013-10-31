//
//  RMURatingCell.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/7/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMURatingCell.h"

@implementation RMURatingCell


#pragma mark - init methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCurrentMeal:(RMUMeal *)menuMeal
{
    self.currentMeal = menuMeal;
    self.entreeLabel.text = menuMeal.mealName;
    self.numDislikesLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealDislikes];
    self.numLikesLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealLikes];
}

#pragma mark - Interactivity

- (IBAction)rateNegative:(id)sender
{
    self.currentMeal.mealDislikes++;
    [self loadCurrentMeal:self.currentMeal];
    [self postRatingToDatabaseWithRatingStatus:ratingStatusNegative];
    [self.delegate deleteVideoAtIndex:self.index];
}

- (IBAction)ratePositive:(id)sender
{
    self.currentMeal.mealLikes++;
    [self loadCurrentMeal:self.currentMeal];
    [self postRatingToDatabaseWithRatingStatus:ratingStatusPositive];
    [self.delegate deleteVideoAtIndex:self.index];
}

#pragma mark - Networking

- (void)postRatingToDatabaseWithRatingStatus: (NSInteger)ratingStatus
{
    NSString *mealID = self.currentMeal.mealID;
    NSURL *restaurantURL = [NSURL URLWithString:[NSString
                                                 stringWithFormat:(@"http://caisbalderas.webfactional.com/api/rating.json?dsh_key=%@&positive=%i"),mealID, ratingStatus]];
    NSURLRequest *restRequest = [[NSURLRequest alloc]initWithURL:restaurantURL];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:restRequest
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"ERROR IN POST RATING: %@", error);
                                                                                        }];
    [operation start];

    
}

@end
