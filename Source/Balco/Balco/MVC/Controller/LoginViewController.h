#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;

- (IBAction)loginButtonAction:(id)sender;

@end
