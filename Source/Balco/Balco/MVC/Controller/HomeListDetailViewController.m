#import "HomeListDetailViewController.h"
#import "LeaderTableViewCell.h"
#import "WebServices.h"

#define kTableViewCellHeight 75.0f

@implementation HomeListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Back";
    
    self.homeListImageView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 250);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[WebServices new] fetchPDFsForCategoryId:@"10001"
                                      success:^(NSDictionary *responseDict) {
                                          if ([responseDict objectForKey:@"data"]) {
                                              self.dataSourceString = @"So far you’ve been creating AFHTTPRequestOperation and AFHTTPSessionManager directly from the table view controller as you needed them. More often than not, your networking requests will be associated with a single web service or API.  AFHTTPSessionManager has everything you need to talk to a web API. It will decouple your networking communications code from the rest of your code, and make your networking communications code reusable throughout your project.            Here are two guidelines on AFHTTPSessionManager best practices:            Create a subclass for each web service. For example, if you’re writing a social network aggregator, you might want one subclass for Twitter, one for Facebook, another for Instragram and so on.                In each AFHTTPSessionManager subclass, create a class method that returns a shared singleton instance. This saves resources and eliminates the need to allocate and spin up new objects. Your project currently doesn’t have a subclass of AFHTTPSessionManager; it just creates one directly.Let’s fix that. ";
                                              self.homeListImageView.image = [UIImage imageNamed:@"good"];
                                              [self.tableView reloadData];
                                          }
                                      }
                                      failure:^(NSError *error) {
                                          NSLog(@"%@", error);
                                      }];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat calculatedHeight = [self calculateHeightFromPropertyData:self.dataSourceString];
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
    [tableView dequeueReusableCellWithIdentifier:@"HomeListDetailCell"];
    cell.leaderTextView.text = self.dataSourceString;
    cell.leaderTextView.contentInset =
    UIEdgeInsetsMake(-10.f, 0.f, 0.f, 0.f);
    cell.leaderTextView.textContainerInset =
    UIEdgeInsetsMake(10.f, 0.f, 0.f, 0.f);
    [cell.leaderTextView setFont:[UIFont systemFontOfSize:16.0f]];
    cell.leaderTitleLabel.text = @"New Label Title";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)calculateHeightFromPropertyData:(NSString *)dataFromProperty {
    CGRect textRect = [dataFromProperty boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 80 , self.tableView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]} context:nil];
    return textRect.size.height;
}


@end
