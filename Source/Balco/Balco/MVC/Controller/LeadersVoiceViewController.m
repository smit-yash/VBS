#import "LeaderTableViewCell.h"
#import "LeadersVoiceViewController.h"
#import "WebServices.h"

#define kTableViewCellHeight 75.0f

@implementation LeadersVoiceViewController {
    NSString *dataSourceString;
    NSString *titleString;
    NSString *imageURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Back";
    self.title = @"Leader's Voice";
    
    self.leaderImageView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 250);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [DisplayUtil showSpinnerOn:self above:self.view];
    [[WebServices new] fetchLeadersVoiceSuccess:^(NSDictionary *responseDict) {
        [DisplayUtil removeSpinnerFrom:self];
        [self.tableView reloadData];
        if ([responseDict objectForKey:@"data4"]) {
            dataSourceString = [responseDict objectForKey:@"data4"];
        }
        if ([responseDict objectForKey:@"data3"]) {
            titleString = [responseDict objectForKey:@"data3"];
        }
        if ([responseDict objectForKey:@"data2"]) {
            imageURL = [responseDict objectForKey:@"data2"];
        }

    } failure:^(NSError *error) {
        [DisplayUtil removeSpinnerFrom:self];
        NSLog(@"%@",error);
    }];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DisplayUtil removeSpinnerFrom:self];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat calculatedHeight = [self calculateHeightFromPropertyData:dataSourceString];
    if (calculatedHeight < kTableViewCellHeight) {
        return kTableViewCellHeight;
    } else {
        return calculatedHeight + 120;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LeaderTableViewCell *cell =
	    [tableView dequeueReusableCellWithIdentifier:@"LeaderCell"];
	cell.leaderTextView.text = dataSourceString;
    cell.leaderTextView.contentInset = UIEdgeInsetsMake(-10.f, 0.f, 0.f, 0.f);
    cell.leaderTextView.textContainerInset = UIEdgeInsetsMake(10.f, 0.f, 0.f, 0.f);
    [cell.leaderTextView setFont:[UIFont systemFontOfSize:16.0f]];
    cell.leaderTitleLabel.text = titleString;
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data) {
        UIImage *img = [[UIImage alloc] initWithData:data];
        self.leaderImageView.image = img;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (CGFloat)calculateHeightFromPropertyData:(NSString *)dataFromProperty {
    CGRect textRect = [dataFromProperty boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 80 , self.tableView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]} context:nil];
    return textRect.size.height;
}


@end
