#import "HomeListDetailViewController.h"
#import "LeaderTableViewCell.h"
#import "WebServices.h"

#define kTableViewCellHeight 75.0f

@implementation HomeListDetailViewController {
    NSString *dataSourceString;
    NSString *titleString;
    NSString *imageURL;
    NSString *dateString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Back";
        
    self.homeListImageView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 250);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataSourceString = [self.dict objectForKey:@"Msg"];
    titleString = [self.dict objectForKey:@"Title"];
    dateString = [self.dict objectForKey:@"IssueDate"];
    imageURL = [self.dict objectForKey:@"ImageURL"];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat calculatedHeight = [self calculateHeightFromPropertyData:dataSourceString];
    if (calculatedHeight < kTableViewCellHeight) {
        return kTableViewCellHeight + 120;
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
    cell.leaderTextView.text = dataSourceString;
    cell.leaderTextView.contentInset =
    UIEdgeInsetsMake(-10.f, 0.f, 0.f, 0.f);
    cell.leaderTextView.textContainerInset =
    UIEdgeInsetsMake(10.f, 0.f, 0.f, 0.f);
    [cell.leaderTextView setFont:[UIFont systemFontOfSize:16.0f]];
    cell.dateLabel.text = dateString;
    cell.leaderTitleLabel.text = titleString;
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data) {
        UIImage *img = [[UIImage alloc] initWithData:data];
        self.homeListImageView.image = img;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)calculateHeightFromPropertyData:(NSString *)dataFromProperty {
    CGRect textRect = [dataFromProperty boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 80 , self.tableView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]} context:nil];
    return textRect.size.height;
}


@end
