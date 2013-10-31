//
//  RMUFallbackScreen.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/9/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUFallbackScreen.h"

@interface RMUFallbackScreen ()
@property (weak, nonatomic) IBOutlet UITableView *fallbackTable;
@property RMUMenu *currentMenu;

@end

@implementation RMUFallbackScreen

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.restaurants.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RMUMenu *menu = self.restaurants[indexPath.row];
    [cell.textLabel setText:menu.restaurantName];
    [cell.detailTextLabel setText:menu.restaurantAddress];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenu *restaurant = self.restaurants[indexPath.row];
    NSString *restaurantName = restaurant.restaurantName;
    NSURL *restaurantURL = [NSURL URLWithString:[NSString
                                                 stringWithFormat:(@"http://recommenu.caisbalderas.com/api/v1/restaurant/999111")]];
    NSURLRequest *restRequest = [[NSURLRequest alloc]initWithURL:restaurantURL];
    AFJSONRequestOperation *restOperation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:restRequest
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 NSArray *mealArray = [JSON objectForKey:@"dishes"];
                                                 RMUMenu *currentMenu = [RMUHomeScreen parseJSONIntoMenu:mealArray
                                                                             withRestaurantName:restaurantName];
                                                 self.currentMenu = currentMenu;
                                                 [self performSegueWithIdentifier:@"fallbackToMenu" sender:self];
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 NSLog(@"ERROR: %@", error);
                                             }];
    [restOperation start];
}

#pragma mark - Interactivity

- (IBAction)cancelActions:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"fallbackToMenu"]) {
        RMUMenuTableScreen *nextMenu = segue.destinationViewController;
        [nextMenu setMenu:self.currentMenu];
    }
    else {
        NSLog(@"ERRRM UNDEFINED SEGUE");
    }
}

@end
