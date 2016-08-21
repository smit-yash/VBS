#import "LoginViewController.h"
#import "OTPViewController.h"
#import "WebServices.h"

#define kLoginSuccessMessage @"otp_sent"

@implementation LoginViewController {
	OTPViewController *otpViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[self initializeBorderForTextField];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
	    initWithTarget:self
		    action:@selector(dismissKeyboard)];
	[self.view addGestureRecognizer:tap];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[[NSNotificationCenter defaultCenter]
	    removeObserver:self
		      name:UIKeyboardWillShowNotification
		    object:nil];
	[[NSNotificationCenter defaultCenter]
	    removeObserver:self
		      name:UIKeyboardWillHideNotification
		    object:nil];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DisplayUtil removeSpinnerFrom:self];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[NSNotificationCenter defaultCenter]
	    addObserver:self
	       selector:@selector(keyboardDidShow:)
		   name:UIKeyboardWillShowNotification
		 object:nil];
	[[NSNotificationCenter defaultCenter]
	    addObserver:self
	       selector:@selector(keyboardDidHide:)
		   name:UIKeyboardWillHideNotification
		 object:nil];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	self.navigationItem.hidesBackButton = YES;
}

- (void)initializeBorderForTextField {
	self.mobileNumberTextField.layer.borderColor =
	    [[UIColor lightGrayColor] CGColor];
	self.mobileNumberTextField.layer.borderWidth = 1.0;
	self.mobileNumberTextField.delegate = self;
}

- (IBAction)loginButtonAction:(id)sender {
    [DisplayUtil showSpinnerOn:self above:self.view];
	[[WebServices new] loginWithPhoneNumber:self.mobileNumberTextField.text
	    success:^(NSDictionary *responseDict) {
	      [DisplayUtil removeSpinnerFrom:self];
	      if ([[[responseDict objectForKey:@"response"]
		      objectForKey:@"status"]
		      isEqualToString:kLoginSuccessMessage]) {
		      [[NSUserDefaults standardUserDefaults]
			  setObject:self.mobileNumberTextField.text
			     forKey:@"registeredMobileNumber"];
		      [[NSUserDefaults standardUserDefaults] synchronize];
		      [self performSegueWithIdentifier:@"OTPSegue" sender:self];
	      } else {
		      // Alert for error
		      NSString *errorMessage = [[responseDict
			  objectForKey:@"response"] objectForKey:@"status"];
		      NSLog(@"%@", errorMessage);
              [[AppAlerts new] handleAlertForError:nil withTitle:@"Error" message:errorMessage];
	      }
	    }
	    failure:^(NSError *error) {
            NSLog(@"error %@", error);
            [DisplayUtil removeSpinnerFrom:self];
            [[AppAlerts new] handleAlertForError:error withTitle:@"Error" message:error.description];
	    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"LoginViewSegue"]) {
		otpViewController = [segue destinationViewController];
	}
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
		replacementString:(NSString *)string {
	if (([string rangeOfCharacterFromSet:[[NSCharacterSet
						 decimalDigitCharacterSet]
						 invertedSet]]
		 .location != NSNotFound) &&
	    !(range.length == 1 && string.length == 0)) {
		return NO;
	}
	if (([textField.text stringByReplacingCharactersInRange:range
						     withString:string]
		 .length > 10)) {
		return NO;
	}
	return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification {
	[self.view setFrame:CGRectMake(0, -60, self.view.frame.size.width,
				       self.view.frame.size.height)];
}

- (void)keyboardDidHide:(NSNotification *)notification {
	[self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width,
				       self.view.frame.size.height)];
}

- (void)dismissKeyboard {
	[self.mobileNumberTextField resignFirstResponder];
}

@end
