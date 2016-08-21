#import <UIKit/UIKit.h>

@interface LeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leaderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *leaderTextView;

@end
