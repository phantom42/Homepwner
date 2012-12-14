//
//  DateViewController.m
//  Homepwner
//
//  Created by Joe Coleman on 12/13/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "DateViewController.h"
#import "BNRItem.h"

@interface DateViewController ()

@end

@implementation DateViewController
@synthesize item ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    // only want to select date, no time
    [datePicker setDatePickerMode:UIDatePickerModeDate] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // make sure to display item's date instead of "today"
    [datePicker setDate:[item dateCreated]
               animated:YES] ;
    
}
- (void)setItem:(BNRItem *)i
{
    item = i ;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
    //transmit the new value back to the parent object
    [item setDateCreated:[datePicker date]] ;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
