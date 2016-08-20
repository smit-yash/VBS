#import <UIKit/UIKit.h>

@interface HomeListDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *homeListImageView;
@property (strong, nonatomic) NSDictionary *dict;

@end
