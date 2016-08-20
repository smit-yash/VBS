//
//  LoginViewController.h
//  Balco
//
//  Created by optimusmac4 on 8/20/16.
//  Copyright © 2016 sy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;

- (IBAction)loginButtonAction:(id)sender;

@end
