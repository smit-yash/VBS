#import <UIKit/UIKit.h>

@interface VSAPViewController
    : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *headerViewTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;

@end