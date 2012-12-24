//
//  DetailViewController.h
//  Homepwner
//
//  Created by Joe Coleman on 11/28/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem ;

@interface DetailViewController : UIViewController
    <UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    UITextFieldDelegate, UIPopoverControllerDelegate>
{
    __weak IBOutlet UITextField *nameField;    
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView ;
    
    UIPopoverController *imagePickerPopover ;
}
@property (nonatomic, strong) BNRItem *item ;
- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
@end
