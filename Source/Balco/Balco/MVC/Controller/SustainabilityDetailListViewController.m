#import "PoliciesTableViewCell.h"
#import "PoliciesWebViewController.h"
#import "SustainabilityDetailListViewController.h"
#import "WebServices.h"

#define kTableViewCellHeight 60.0f
#define kAPISuccessMessage @"success"
@interface SustainabilityDetailListViewController () <UITableViewDataSource,
						      UITableViewDelegate>

@end

@implementation SustainabilityDetailListViewController {
	NSArray *standardSubListArray;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.title = self.catagoryName;
    
    [DisplayUtil showSpinnerOn:self above:self.view];
	[[WebServices new] fetchPDFsForCategoryId:self.categoryId
	    success:^(NSDictionary *responseDict) {
            [DisplayUtil removeSpinnerFrom:self];
	      if ([responseDict objectForKey:@"data"]) {
		      standardSubListArray =
			  [NSArray arrayWithArray:(NSArray *)[responseDict
						      objectForKey:@"data"]];
		      [self.tableView reloadData];
	      }
	    }
	    failure:^(NSError *error) {
	      NSLog(@"%@", error);
            [DisplayUtil removeSpinnerFrom:self];
	    }];

	self.navigationItem.backBarButtonItem.title = @"Back";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DisplayUtil removeSpinnerFrom:self];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return standardSubListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	PoliciesTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"SubListCell"];
	cell.containerView.layer.cornerRadius = 5.0f;

	NSDictionary *dict = [standardSubListArray objectAtIndex:indexPath.row];

	cell.titleLabel.text = [dict objectForKey:@"Title"];

	return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"standardToWebSegue" sender:self];
	[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	PoliciesWebViewController *vc = segue.destinationViewController;
	NSIndexPath *selectedIndexPath =
	    [self.tableView indexPathForSelectedRow];

	NSDictionary *dict =
	    [standardSubListArray objectAtIndex:selectedIndexPath.row];

	vc.selectedDict = dict;
}

@end
