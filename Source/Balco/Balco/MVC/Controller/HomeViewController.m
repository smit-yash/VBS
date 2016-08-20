#import "HomeTableViewCell.h"
#import "HomeViewController.h"
#import "WebServices.h"

#define kTableViewCellHeight 80.0f

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeViewController {

	__weak IBOutlet UITableView *homeTableView;
	NSArray *homeMessageArray;
}

#pragma mark - Utility

- (void)viewDidLoad {
	[super viewDidLoad];

	[[WebServices new] fetchHomeMessageSuccess:^(NSArray *responseArray) {
	  NSLog(@"response %@", responseArray);
	}
	    failure:^(NSError *error) {
	      NSLog(@"eoor %@", error);
	    }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	self.navigationItem.hidesBackButton = YES;
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	HomeTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];

	cell.containerView.layer.cornerRadius = 10.0f;
	cell.dateLabel.text = @"13 Aug, 2013";
	cell.titleLabel.text = @"An Event";
	cell.descriptionLabel.text = @"Some Description";

	return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	//    [self performSegueWithIdentifier:showDetailSegueIdentifier
	//    sender:self];
}

#pragma mark - Button Actions

- (IBAction)policiesButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"PoliciesSegue" sender:self];
}

- (IBAction)standardButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"StandardSegue" sender:self];
}

- (IBAction)leadersVoiceButtonAction:(id)sender {
}

- (IBAction)quizButtonAction:(id)sender {
}

- (IBAction)scoreButtonAction:(id)sender {
}

- (IBAction)reportButtonAction:(id)sender {
}

#pragma mark - Web API Calls

@end
