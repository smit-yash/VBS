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
	  homeMessageArray = responseArray;
	  [homeTableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

	return homeMessageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	HomeTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];

	NSDictionary *currentMessage = homeMessageArray[indexPath.row];

	cell.containerView.layer.cornerRadius = 10.0f;
	cell.dateLabel.text = [currentMessage objectForKey:@"IssueDate"];
	cell.titleLabel.text = [currentMessage objectForKey:@"Title"];
	cell.descriptionLabel.text = [currentMessage objectForKey:@"Msg"];

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
    [self performSegueWithIdentifier:@"quizSegue" sender:self];
}

- (IBAction)scoreButtonAction:(id)sender {
	[self performSegueWithIdentifier:@"VSAPSegue" sender:self];
}

- (IBAction)reportButtonAction:(id)sender {
}

@end
