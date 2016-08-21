#import "HomeViewController.h"
#import "OTPViewController.h"
#import "WebServices.h"

#define kVerifyOTPSuccessMessage @"otp_verified"

@implementation OTPViewController {
	HomeViewController *homeViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self initializeTextFieldsBackGround];
	self.navigationItem.hidesBackButton = NO;
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self initializeTextFieldsBackGround];
	self.navigationItem.hidesBackButton = NO;

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
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DisplayUtil removeSpinnerFrom:self];
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
	textField.delegate = self;
}

- (IBAction)submitButtonAction:(id)sender {
	NSString *registeredMobileNumber =
	    [[NSUserDefaults standardUserDefaults]
		stringForKey:@"registeredMobileNumber"];

    [DisplayUtil showSpinnerOn:self above:self.view];
    [[WebServices new] verifyOTP:[NSString stringWithFormat:@"%@%@%@%@",_textField1.text, _textField2.text, _textField3.text, _textField4.text]
	    forMobileNumber:registeredMobileNumber
	    success:^(NSDictionary *responseDict) {
            [DisplayUtil removeSpinnerFrom:self];
	      if ([[[responseDict objectForKey:@"response"]
		      objectForKey:@"status"]
		      isEqualToString:kVerifyOTPSuccessMessage]) {
		      [[NSUserDefaults standardUserDefaults]
			  setObject:[NSString stringWithFormat:@"%@%@%@%@",_textField1.text, _textField2.text, _textField3.text, _textField4.text]
			     forKey:@"registeredOTP"];
		      [[NSUserDefaults standardUserDefaults] synchronize];
		      [self performSegueWithIdentifier:@"AfterLoginSegue"
						sender:self];
	      } else {
		      NSString *errorMessage = [[responseDict
			  objectForKey:@"response"] objectForKey:@"status"];
		      NSLog(@"error %@", errorMessage);
	      }
	    }
	    failure:^(NSError *error) {
	      NSLog(@"error %@", error);
            [DisplayUtil removeSpinnerFrom:self];
	    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"AfterLoginSegue"]) {
		homeViewController = [segue destinationViewController];
	}
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
		replacementString:(NSString *)string {
	BOOL shouldProcess = NO; // default to reject
	BOOL shouldMoveToNextField =
	    NO; // default to remaining on the current field

	NSUInteger insertStringLength = [string length];
	if (insertStringLength == 0) { // backspace
		shouldProcess =
		    YES; // Process if the backspace character was pressed
	} else {
		if ([[textField text] length] == 0) {
			shouldProcess = YES; // Process if there is only 1
			// character right now
		}
	}

	// here we deal with the UITextField on our own
	if (shouldProcess) {
		// grab a mutable copy of what's currently in the UITextField
		NSMutableString *mstring = [[textField text] mutableCopy];
		if ([mstring length] == 0) {
			// nothing in the field yet so append the replacement
			// string
			[mstring appendString:string];

			shouldMoveToNextField = YES;
		} else {
			// adding a char or deleting?
			if (insertStringLength > 0) {
				[mstring insertString:string
					      atIndex:range.location];
			} else {
				// delete case - the length of replacement
				// string is zero for a delete
				[mstring deleteCharactersInRange:range];
			}
		}

		// set the text now
		[textField setText:mstring];
		if (shouldMoveToNextField) {
			if (textField == self.textField1) {
				[self.textField2 becomeFirstResponder];
			} else if (textField == self.textField2) {
				[self.textField3 becomeFirstResponder];
			} else if (textField == self.textField3) {
				[self.textField4 becomeFirstResponder];
			} else if (textField == self.textField4) {
				[self.textField4 resignFirstResponder];
				[self submitButtonAction:nil];
			}
		}
	}

	// always return no since we are manually changing the text field
	return NO;
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
	[self.view endEditing:YES];
}

@end
