#import "PoliciesTableViewCell.h"
#import "PoliciesViewController.h"
#import "WebServices.h"

#define kTableViewCellHeight 60.0f

@implementation PoliciesViewController {
    NSArray *policiesArray;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Back";
    
    [[WebServices new] fetchPDFsForCategoryId:@"10001" success:^(NSDictionary *responseDict) {
        if ([responseDict objectForKey:@"data"]) {
            policiesArray = [NSArray arrayWithArray:(NSArray *)[responseDict objectForKey:@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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

@end
