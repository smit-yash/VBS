#import "PoliciesTableViewCell.h"
#import "PoliciesViewController.h"
#import "WebServices.h"
#import "PoliciesWebViewController.h"

#define kTableViewCellHeight 60.0f

@implementation PoliciesViewController {
    NSArray *policiesArray;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Back";
    
    [DisplayUtil showSpinnerOn:self above:self.view];
    [[WebServices new] fetchPDFsForCategoryId:@"10001" success:^(NSDictionary *responseDict) {
        [DisplayUtil removeSpinnerFrom:self];
        if ([responseDict objectForKey:@"data"]) {
            policiesArray = [NSArray arrayWithArray:(NSArray *)[responseDict objectForKey:@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [DisplayUtil removeSpinnerFrom:self];
    }];
    
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
	return policiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	PoliciesTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"PoliciesCell"];
	cell.containerView.layer.cornerRadius = 5.0f;
    
    NSDictionary *dict = [policiesArray objectAtIndex:indexPath.row];
	cell.titleLabel.text = [dict objectForKey:@"Title"];
	return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PoliciesWebViewSegue" sender:self];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PoliciesWebViewController *vc = segue.destinationViewController;
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *dict = [policiesArray objectAtIndex:selectedIndexPath.row];
    
    vc.selectedDict = dict;
}


@end
