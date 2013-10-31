//
//  RMUMenuTableScreen.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/30/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuTableScreen.h"

@interface RMUMenuTableScreen ()
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) RMUMenu *menu;
@end

@implementation RMUMenuTableScreen

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
    [self.doneButton setBackgroundColor:[UIColor RMUGoodBlueColor]];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource methods

/*
 *  Returns number of cells that are in the table
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menu.meals.count;
}

/*
 *  The big kahuna of tableview datasource methods, displays each individual cell
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if (cell == nil)
        cell = [[RMUMenuCell alloc]initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:@"menuCell"];
    
    RMUMeal *cellMeal = [self.menu.meals objectAtIndex:indexPath.row];
    
    [cell loadCurrentMeal:cellMeal];
    return cell;
}

#pragma mark - Interactivity

- (IBAction)popBackFromButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Segues

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"menuToRatings"]) {
        RMUOrderRatingScreen *nextOrderScreen = segue.destinationViewController;
        NSMutableArray *orderedMeals = [[NSMutableArray alloc]init];
        for (RMUMeal *meal in self.menu.meals) {
            if (meal.selected) {
                [orderedMeals addObject:meal];
            }
        }
        nextOrderScreen.orderedMeals = orderedMeals;
    }
}

@end
