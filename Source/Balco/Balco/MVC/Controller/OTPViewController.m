//
//  OTPViewController.m
//  Balco
//
//  Created by optimusmac4 on 8/20/16.
//  Copyright © 2016 sy. All rights reserved.
//

#import "HomeViewController.h"
#import "OTPViewController.h"

@interface OTPViewController ()

@end

@implementation OTPViewController {
	HomeViewController *homeViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self initializeTextFieldsBackGround];
	self.navigationItem.hidesBackButton = NO;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// Do any additional setup after loading the view.
	[self initializeTextFieldsBackGround];
	self.navigationItem.hidesBackButton = NO;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)initializeTextFieldsBackGround {
	[self initializeBorderForTextField:_textField1];
	[self initializeBorderForTextField:_textField2];
	[self initializeBorderForTextField:_textField3];
	[self initializeBorderForTextField:_textField4];
}

- (void)initializeBorderForTextField:(UITextField *)textField {
	textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	textField.layer.borderWidth = 1.0;
}

- (IBAction)submitButtonAction:(id)sender {
	[self performSegueWithIdentifier:@"AfterLoginSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"AfterLoginSegue"]) {
		homeViewController = [segue destinationViewController];
	}
}
@end
