//
//  RMUOrderRatingScreen.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/7/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUOrderRatingScreen.h"

@interface RMUOrderRatingScreen ()
@property (weak, nonatomic) IBOutlet UITableView *orderTable;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation RMUOrderRatingScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.doneButton setBackgroundColor:[UIColor RMUGoodBlueColor]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popBackToMenu:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.orderedMeals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rCell";
    RMURatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[RMURatingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    RMUMeal *cellMeal = self.orderedMeals[indexPath.row];
    
    cell.delegate = self;
    cell.index = indexPath.row;
    
    [cell loadCurrentMeal:cellMeal];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
#pragma mark - Rating Cell Delegate

- (void)deleteVideoAtIndex:(NSInteger)index
{
    [self.orderedMeals removeObjectAtIndex:index];
    [self.orderTable beginUpdates];
    [self.orderTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]]
                           withRowAnimation:UITableViewRowAnimationFade];
    [self.orderTable endUpdates];
    [self performSelector:@selector(reloadData) withObject:self.orderTable afterDelay:0.3f];
}

- (void)reloadData
{
    [self.orderTable reloadData];
}
@end
