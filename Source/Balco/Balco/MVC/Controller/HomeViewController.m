#import "HomeTableViewCell.h"
#import "HomeViewController.h"
#import "WebServices.h"
#import "HomeListDetailViewController.h"

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

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView.image = [UIImage imageNamed:@"Logo"];
    imageView.tintColor =[UIColor whiteColor];
    
    UIView *iv = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height)];
    [iv setBackgroundColor:[UIColor clearColor]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Balco Sustainability";
    [titleLabel setFont:[UIFont systemFontOfSize:21 weight:0.5]];
    [iv addSubview:titleLabel];
    [iv addSubview:imageView];
    self.navigationItem.titleView = iv;

    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MainListSegue"]) {
        HomeListDetailViewController *vc = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [homeTableView indexPathForSelectedRow];
        
        NSDictionary *dict = [homeMessageArray objectAtIndex:selectedIndexPath.row];
        
        vc.dict = dict;
    }
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
    [self performSegueWithIdentifier:@"MainListSegue" sender:self];
	[tableView deselectRowAtIndexPath:indexPath animated:NO];    
}

#pragma mark - Button Actions

- (IBAction)policiesButtonAction:(id)sender {
	[self performSegueWithIdentifier:@"PoliciesSegue" sender:self];
}

- (IBAction)standardButtonAction:(id)sender {
	[self performSegueWithIdentifier:@"StandardSegue" sender:self];
}

- (IBAction)leadersVoiceButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"LeaderSegue" sender:self];
}

- (IBAction)quizButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"quizSegue" sender:self];
}

- (IBAction)scoreButtonAction:(id)sender {
	[self performSegueWithIdentifier:@"VSAPSegue" sender:self];
}

- (IBAction)reportButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"reportHazardSegue" sender:self];

}

@end
