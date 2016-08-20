#import "LaunchScreenViewController.h"
#import "LoginViewController.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController {
	LoginViewController *loginViewController;
    __weak IBOutlet UIImageView *launchImage;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    launchImage.image = [UIImage imageNamed:@"launchImage"];
	sleep(1);
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    NSString *registeredMobileNumber = [[NSUserDefaults standardUserDefaults] stringForKey:@"registeredMobileNumber"];
    NSString *registeredOTP = [[NSUserDefaults standardUserDefaults] stringForKey:@"registeredOTP"];

	if (registeredMobileNumber.length && registeredOTP.length) {
		[self performSegueWithIdentifier:@"MainViewSegue" sender:self];
	} else {
		[self performSegueWithIdentifier:@"LoginViewSegue" sender:self];
	}
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"LoginViewSegue"]) {
		loginViewController = [segue destinationViewController];
	} else if ([segue.identifier isEqualToString:@"MainViewSegue"]) {
		loginViewController = [segue destinationViewController];
	}
}

@end
