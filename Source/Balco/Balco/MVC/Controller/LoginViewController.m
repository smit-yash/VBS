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
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
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
    [[WebServices new] loginWithPhoneNumber:@"1111111111" success:^(NSDictionary *responseDict) {
        NSLog(@"%@",responseDict);
        if ([[[responseDict objectForKey:@"response"] objectForKey:@"status"] isEqualToString:kLoginSuccessMessage]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1111111111" forKey:@"registeredMobileNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"OTPSegue" sender:self];
        } else {
            //Alert for error
            NSString *errorMessage = [[responseDict objectForKey:@"response"] objectForKey:@"status"];
            NSLog(@"%@",errorMessage);
        }
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
