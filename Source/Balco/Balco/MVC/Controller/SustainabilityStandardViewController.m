#import "PoliciesTableViewCell.h"
#import "SustainabilityStandardViewController.h"
#import "WebServices.h"

#define kTableViewCellHeight 60.0f
#define kAPISuccessMessage @"success"

@implementation SustainabilityStandardViewController {
    NSArray *categoryArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[WebServices new] fetchCategoriesSuccess:^(NSDictionary *responseDict) {
        if ([responseDict objectForKey:@"data"]) {
            categoryArray = [NSArray arrayWithArray:(NSArray *)[responseDict objectForKey:@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
    
    self.navigationItem.backBarButtonItem.title = @"Back";
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	PoliciesTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"PoliciesCell"];
	cell.containerView.layer.cornerRadius = 5.0f;
    
    NSDictionary *dict = [categoryArray objectAtIndex:indexPath.row];
    
	cell.titleLabel.text = [dict objectForKey:@"CatagoryName"];
    
	return cell;
}

@end
