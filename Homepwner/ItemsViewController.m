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
        for (int i = 0 ; i < 5 ; i++) {
            [[BNRItemStore sharedStore] createItem] ;
        }
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
    return [[[BNRItemStore sharedStore] allItems] count] ;
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
    
    // set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[p description]] ;
    
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
@end
