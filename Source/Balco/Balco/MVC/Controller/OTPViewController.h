#import <UIKit/UIKit.h>

@interface OTPViewController : UIViewController <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITextField *textField1;
@property(weak, nonatomic) IBOutlet UITextField *textField2;
@property(weak, nonatomic) IBOutlet UITextField *textField3;
@property(weak, nonatomic) IBOutlet UITextField *textField4;

- (IBAction)submitButtonAction:(id)sender;

@end
