//
//  LoginViewController.m
//  Balco
//
//  Created by optimusmac4 on 8/20/16.
//  Copyright © 2016 sy. All rights reserved.
//

#import "LoginViewController.h"
#import "OTPViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController {
	OTPViewController *otpViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self initializeBorderForTextField];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)initializeBorderForTextField {
	self.mobileNumberTextField.layer.borderColor =
	    [[UIColor lightGrayColor] CGColor];
	self.mobileNumberTextField.layer.borderWidth = 1.0;
}

- (IBAction)loginButtonAction:(id)sender {
	[self performSegueWithIdentifier:@"OTPSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"LoginViewSegue"]) {
		otpViewController = [segue destinationViewController];
	}
}

@end
