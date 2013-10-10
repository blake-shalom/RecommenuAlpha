//
//  RMUHomeScreen.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 8/28/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUHomeScreen.h"

@interface RMUHomeScreen ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) RMUMenu *currentMenu;
@property (strong,nonatomic) NSString *restName;
@end

@implementation RMUHomeScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 150;
    self.location = [[CLLocation alloc]init];
    [self.locationManager startUpdatingLocation];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations[0];
}


#pragma mark - Interactivity

/*
 *  Locates nearby restaurants
 */

- (IBAction)findRestaurants:(id)sender
{
    
    NSLog(@"LOCATING.....");
    CGFloat lat = self.location.coordinate.latitude;
    CGFloat longi = self.location.coordinate.longitude;
    
    [self.locationManager stopUpdatingLocation];
    NSString *latLongString = [NSString stringWithFormat:(@"%f,%f"), lat, longi];
    NSString *idString = @"YZVWMVDV1AFEHQ5N5DX4KFLCSVPXEC1L0KUQI45NQTF3IPXT";
    NSString *secretString = @"2GA3BI5S4Z10ONRUJRWA40OTYDED3LAGCUAXJDBBEUNR4JJN";
    NSURL *foursquareURL = [[NSURL alloc]initWithString:[NSString
                                                         stringWithFormat: (@"https://api.foursquare.com/v2/venues/search?ll=%@&limit=10&intent=browse&radius=2000&categoryId=4d4b7105d754a06374d81259&client_id=%@&client_secret=%@&v=20130918"), latLongString, idString, secretString]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:foursquareURL];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSDictionary *newDictionary = [JSON objectForKey:@"response"];
                                             NSArray *newArray = [newDictionary objectForKey:@"venues"];
                                             self.restName = [newArray[0] objectForKey:@"name"];
                                             UIAlertView *restaurantCheckAlert = [[UIAlertView alloc] initWithTitle:@"Restaurant Found!"
                                                                                                            message:[NSString stringWithFormat:(@"Are you at %@?"), self.restName]
                                                                                                           delegate:self
                                                                                                  cancelButtonTitle:@"NO"
                                                                                                  otherButtonTitles:@"YES", nil];
                                             [restaurantCheckAlert show];
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                         }];
    [operation start];
    
    
}

/*
 *  Pulls a menu from a given restaurant
 */

- (void)pullMenuFromRestaurant:(NSString*)restaurantName
{
    NSURL *restaurantURL = [NSURL URLWithString:[NSString
                                                 stringWithFormat:(@"http://caisbalderas.webfactional.com/api/dishlist.json")]];
    NSURLRequest *restRequest = [[NSURLRequest alloc]initWithURL:restaurantURL];
    AFJSONRequestOperation *restOperation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:restRequest
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 NSArray *mealArray = [JSON objectForKey:@"dishes"];
                                                 RMUMenu *currentMenu = [self parseJSONIntoMenu:mealArray
                                                                            withRestaurantName:restaurantName];
                                                 self.currentMenu = currentMenu;
                                                 [self performSegueWithIdentifier:@"homeToMenu" sender:self];
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 NSLog(@"ERROR: %@", error);
                                             }];
    [restOperation start];
}

/*
 *  Processes a given JSON item into a menu object
 */

- (RMUMenu*)parseJSONIntoMenu:(NSArray*)JSONArray withRestaurantName:(NSString*)restaurantName {
    
    NSMutableArray *currentCourses = [[NSMutableArray alloc]init];
    for (NSDictionary *meal in JSONArray) {
        NSString *mealName = [meal objectForKey:@"name"];
        NSString *mealDesc = [meal objectForKey:@"description"];
        NSString *mealLikes = [meal objectForKey:@"likes"];
        NSInteger numLikes = [mealLikes integerValue];
        NSString *mealDislikes = [meal objectForKey:@"dislikes"];
        NSInteger numDislikes = [mealDislikes integerValue];
        NSString *mealID = [meal objectForKey:@"dsh_key"];
        RMUMeal *currentMeal = [[RMUMeal alloc]initWithName:mealName
                                            withDescription:mealDesc
                                                  withLikes:numLikes
                                               withDislikes:numDislikes
                                             withIdentifier:mealID];
        [currentCourses addObject:currentMeal];
        
    }
    RMUMenu *currentMenu = [[RMUMenu alloc]initWithString:restaurantName withCourseArray:currentCourses];
    return currentMenu;
}

#pragma mark - segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"homeToMenu"]){
        RMUMenuTableScreen *newMenu = (RMUMenuTableScreen *) segue.destinationViewController;
        [newMenu setMenu:self.currentMenu];
    }
    else {
        NSLog(@"Unknown segue");
    }
}

#pragma mark - UIAlertView methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self pullMenuFromRestaurant:self.restName];
    }
    else if (buttonIndex == 0) {
        NSLog(@"It's in No??");
    }
}

@end





