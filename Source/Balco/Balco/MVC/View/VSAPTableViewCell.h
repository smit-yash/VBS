#import <UIKit/UIKit.h>

@interface VSAPTableViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *deptLabel;
@property(weak, nonatomic) IBOutlet UILabel *detailLabel;
@property(weak, nonatomic) IBOutlet UILabel *scoreValueLabel;
@property(weak, nonatomic) IBOutlet UILabel *scoreTextLabel;
@property(weak, nonatomic) IBOutlet UIImageView *smileyImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
