#import "PoliciesTableViewCell.h"
#import "VSAPTableViewCell.h"
#import "VSAPViewController.h"

#define kSmallTableViewCellHeight 60.0f
#define kLargeTableViewCellHeight 80.0f

@implementation VSAPViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return kSmallTableViewCellHeight;
	} else {
		return kLargeTableViewCellHeight;
	}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		PoliciesTableViewCell *cell = [tableView
		    dequeueReusableCellWithIdentifier:@"PoliciesCell"];
		cell.containerView.layer.cornerRadius = 5.0f;
		cell.titleLabel.text = @"An Event";
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
	} else {

		VSAPTableViewCell *cell =
		    [tableView dequeueReusableCellWithIdentifier:@"VSAPCell"];
		cell.detailLabel.text = @"1200 MW PP";
		cell.scoreValueLabel.text = @"7.57";
		cell.smileyImageView.image =
		    [UIImage imageNamed:@"satisfactory.jpg"];
		cell.containerView.layer.cornerRadius = 5.0f;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
