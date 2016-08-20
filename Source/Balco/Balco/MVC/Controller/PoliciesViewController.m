#import "PoliciesTableViewCell.h"
#import "PoliciesViewController.h"

#define kTableViewCellHeight 60.0f

@implementation PoliciesViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	PoliciesTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"PoliciesCell"];
	cell.containerView.layer.cornerRadius = 5.0f;
	cell.titleLabel.text = @"An Event";
	return cell;
}

@end
