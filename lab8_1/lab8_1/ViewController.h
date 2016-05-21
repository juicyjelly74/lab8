//
//  ViewController.h
//  lab8_1
//
//  Created by Admin on 14.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *cityFrom;
@property (strong, nonatomic) IBOutlet UITextField *cityTo;
- (IBAction)showFlights:(id)sender;


@end

