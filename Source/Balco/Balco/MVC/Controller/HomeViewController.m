#import "HomeTableViewCell.h"
#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "WebServices.h"

#define kTableViewCellHeight 80.0f

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeViewController {

	__weak IBOutlet UITableView *homeTableView;
}

#pragma mark - Utility

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[WebServices new] loginWithPhoneNumber:@"1111111111"];
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

- (IBAction)leadersVoiceButtonAction:(id)sender {
}

- (IBAction)policiesButtonAction:(id)sender {
}

- (IBAction)quizButtonAction:(id)sender {
}

- (IBAction)standardButtonAction:(id)sender {
}

- (IBAction)scoreButtonAction:(id)sender {
}

- (IBAction)reportButtonAction:(id)sender {
}

#pragma mark - Web API Calls

@end
