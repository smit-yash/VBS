#import "PoliciesTableViewCell.h"
#import "VSAPTableViewCell.h"
#import "VSAPViewController.h"
#import "WebServices.h"

#define kSmallTableViewCellHeight 60.0f
#define kLargeTableViewCellHeight 80.0f

@implementation VSAPViewController {
	NSArray *scoreArray;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.headerContainerView.layer.cornerRadius = 5.0f;
	[[WebServices new] fetchScoresSuccess:^(NSDictionary *responseDict) {
	  if ([responseDict objectForKey:@"data"]) {
		  scoreArray =
		      [NSArray arrayWithArray:(NSArray *)[responseDict
						  objectForKey:@"data"]];
          self.headerViewTitleLabel.text = [scoreArray[0] objectForKey:@"Month"];
		  [self.tableView reloadData];
	  }
	}
	    failure:^(NSError *error) {
	      NSLog(@"%@", error);
	    }];
	self.navigationItem.backBarButtonItem.title = @"Back";
    self.title = @"Our VSAP Score Board";
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return kLargeTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return scoreArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	VSAPTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"VSAPCell"];
	NSDictionary *dict = [scoreArray objectAtIndex:indexPath.row];

	cell.detailLabel.text = [dict objectForKey:@"Department"];
	cell.scoreValueLabel.text = [dict objectForKey:@"Score"];
	cell.smileyImageView.image =
	    [UIImage imageNamed:[dict objectForKey:@"Remark"]];
	cell.containerView.layer.cornerRadius = 5.0f;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
