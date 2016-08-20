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
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

    [self initializeTextFieldsBackGround];
	self.navigationItem.hidesBackButton = NO;
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
    NSString *registeredMobileNumber = [[NSUserDefaults standardUserDefaults] stringForKey:@"registeredMobileNumber"];

    [[WebServices new] verifyOTP:@"1111" forMobileNumber:registeredMobileNumber success:^(NSDictionary *responseDict) {
        if ([[[responseDict objectForKey:@"response"] objectForKey:@"status"] isEqualToString:kVerifyOTPSuccessMessage]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1111" forKey:@"registeredOTP"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"AfterLoginSegue" sender:self];
        } else {
            NSString *errorMessage = [[responseDict objectForKey:@"response"] objectForKey:@"status"];
            NSLog(@"error %@",errorMessage);
        }
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"AfterLoginSegue"]) {
		homeViewController = [segue destinationViewController];
	}
}
@end
