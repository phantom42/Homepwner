//
//  DetailViewController.m
//  Homepwner
//
//  Created by Joe Coleman on 11/28/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize item ;
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]] ;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
    [nameField setText:[item itemName]] ;
    [serialNumberField setText:[item serialNumber]] ;
    [valueField setText:[NSString stringWithFormat:@"%d",[item valueInDollars]]] ;
    [valueField setKeyboardType:UIKeyboardTypeNumberPad] ;
    
    // create a nsdateformatter that will turn a date into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle] ;
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle] ;
    
    // use filtered NSdate object to set datelabel contents
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]] ;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
    
    //clear first responder
    [[self view] endEditing:YES] ;
    
    // "save" changes to item
    [item setItemName:[nameField text]] ;
    [item setSerialNumber:[serialNumberField text]] ;
    [item setValueInDollars:[[valueField text] intValue]] ;
}
- (void)setItem:(BNRItem *)i
{
    item = i ;
    [[self navigationItem] setTitle:[item itemName]] ;
}

@end
