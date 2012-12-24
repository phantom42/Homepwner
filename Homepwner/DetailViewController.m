//
//  DetailViewController.m
//  Homepwner
//
//  Created by Joe Coleman on 11/28/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize item ;
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    UIColor *clr = nil ;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        clr = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1] ;
    } else {
        clr = [UIColor groupTableViewBackgroundColor] ;
    }
    [[self view] setBackgroundColor:clr] ;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
    [nameField setText:[item itemName]] ;
    [serialNumberField setText:[item serialNumber]] ;
    [valueField setText:[NSString stringWithFormat:@"%d",[item valueInDollars]]] ;
    
    // create a nsdateformatter that will turn a date into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle] ;
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle] ;
    
    // use filtered NSdate object to set datelabel contents
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]] ;
    
    NSString *imageKey = [item imageKey] ;
    if (imageKey) {
        // get image for image key from image store
        UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey] ;
        
        // use that image to put on the screen in imageView
        [imageView setImage:imageToDisplay] ;
    } else {
        // clear the imageView
        [imageView setImage:nil] ;
    }
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

- (IBAction)takePicture:(id)sender
{
    if ([imagePickerPopover isPopoverVisible]) {
        // if the popover is already up, get rid of it
        [imagePickerPopover dismissPopoverAnimated:YES] ;
        imagePickerPopover = nil ;
        return ;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init] ;
    
    // if the device has a camera, we want to take a photo. otherwise just pick from the photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera] ;
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary] ;
    }

    [imagePicker setDelegate:self] ;
    
    // place image picker on the screen
    // check for ipad device before instantiating the popover controller
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // create a new popover controller that will display the imagePicker
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker] ;
        
        [imagePickerPopover setDelegate:self] ;
        
        // display the popover controller; sender
        // is the cmaera bar button item
        [imagePickerPopover presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                                   animated:YES] ;
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil] ;
    }
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES] ;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = [item imageKey] ;
    
    // dig the item already have an image?
    if (oldKey) {
        // delete the old image
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey] ;
    }
    
    // get picked image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage] ;
    
    // create a cfuuid object - it knows how to create unique identifier strings
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault) ;
    
    // create a string from unique identifier
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID) ;
    
    //use that unique id to set our item's imageKey
    NSString *key = (__bridge NSString *)newUniqueIDString ;
    [item setImageKey:key] ;
    
    //store image in the BNRImageStore with this key
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:[item imageKey]] ;
    
    CFRelease(newUniqueIDString) ;
    CFRelease(newUniqueID) ;
    
    // put that image onto the screen in our image view
    [imageView setImage:image] ;
    
    
    // take the image picker off the screen
    // you must call this dismiss method
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // if on the phone, the image picker is presented modally. dismiss it
        [self dismissViewControllerAnimated:YES completion:nil] ;
    } else {
        // if on the ipad, the image picker is popover. dismiss the popover
        [imagePickerPopover dismissPopoverAnimated:YES] ;
        imagePickerPopover = nil ;
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder] ;
    return YES ;
}
// shouldAutorotateToInterfaceOrientation is deprecated with iOS 6. use this instead
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll ;
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover") ;
    imagePickerPopover = nil ;
}
@end
