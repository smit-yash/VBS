#import <UIKit/UIKit.h>

@interface VSAPViewController
    : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) IBOutlet UITableView *tableView;

@end
