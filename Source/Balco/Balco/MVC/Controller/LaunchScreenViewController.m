#import "LaunchScreenViewController.h"
#import "LoginViewController.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController {
	LoginViewController *loginViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	sleep(2);
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (0) {
		[self performSegueWithIdentifier:@"LoginViewSegue" sender:self];
	} else {
		[self performSegueWithIdentifier:@"MainViewSegue" sender:self];
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
