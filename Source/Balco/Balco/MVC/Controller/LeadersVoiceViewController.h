#import <UIKit/UIKit.h>

@interface LeadersVoiceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UIImageView *leaderImageView;
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSString *dataSourceString;

@end
