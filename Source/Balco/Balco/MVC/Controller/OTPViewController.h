//
//  OTPViewController.h
//  Balco
//
//  Created by optimusmac4 on 8/20/16.
//  Copyright © 2016 sy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *textField1;
@property(weak, nonatomic) IBOutlet UITextField *textField2;
@property(weak, nonatomic) IBOutlet UITextField *textField3;
@property(weak, nonatomic) IBOutlet UITextField *textField4;

- (IBAction)submitButtonAction:(id)sender;

@end
