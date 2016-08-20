#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;

- (IBAction)loginButtonAction:(id)sender;

@end
