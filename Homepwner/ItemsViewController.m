//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Joe Coleman on 11/15/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

- (id)init
{
    //call the super class initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self ;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init] ;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count] + 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // check for a reusable cell. use that if one exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    // if no reusable cell of this type, create a new one
    if (!cell){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"UITableViewCell"];
    }
    
    if ([indexPath row] < [[[BNRItemStore sharedStore] allItems] count]) {
        BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[p description]] ;
    } else {
        [[cell textLabel] setText:@"No more items!"] ;
    }
    return cell ;
}
- (UIView *)headerView
{
   // if we haven't loaded the headerview yet...
    if (!headerView){
        //load headerview.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] ;
    }
    return headerView ;
}

// methods for UITableViewDelegate protocol
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sec
{
    return [self headerView] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sec
{
    // height of the header should be determined by height of view in xib file
    return [[self headerView] bounds].size.height ;
}
- (IBAction)toggleEditingMode:(id)sender
{
    // if currently in editing mode...
    if ([self isEditing]) {
        //change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal] ;
        // turn off editing mode
        [self setEditing:NO animated:YES] ;
    } else {
        // change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal] ;
        // enter editing mode
        [self setEditing:YES animated:YES] ;
    }
}
- (IBAction)addNewItem:(id)sender
{
    // create a new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem] ;
    int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem] ;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0] ;
    
    // insert this new row into the table
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationTop] ;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if the table view is asking to commit a delete...
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        BNRItemStore *ps = [BNRItemStore sharedStore] ;
        NSArray *items = [ps allItems] ;
        BNRItem *p = [items objectAtIndex:[indexPath row]] ;
        [ps removeItem:p] ;
        
        // also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade] ;
    }
}
- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
            toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row]
                                        toIndex:[destinationIndexPath row]] ;
   
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return([indexPath row] < [[[BNRItemStore sharedStore] allItems] count]) ? YES : NO ;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE ;
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return ([proposedDestinationIndexPath row] < [[[BNRItemStore sharedStore] allItems] count]) ? proposedDestinationIndexPath : sourceIndexPath ;
}
@end
