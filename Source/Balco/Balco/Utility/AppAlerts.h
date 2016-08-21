#import <UIKit/UIKit.h>
@protocol AppAlertsDelegate;

@interface AppAlerts : NSObject <UIAlertViewDelegate>

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

+ (void)showAlertWithDelegate:(id)delegate title:(NSString *)title message:(NSString *)message tag:(NSInteger)tag;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                  delegate:(id)delegate
                       tag:(NSInteger)tag
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSString *)otherButtonTitles, ...;

+ (void)showOkCancelAlertWithDelegate:(id)delegate
                                title:(NSString *)title
                              message:(NSString *)message
                                  tag:(NSInteger)tag;

- (void)handleAlertWithDelegate:(id <AppAlertsDelegate>)delegate
                       forErrorCode:(NSError *)error
                      withTitle:(NSString *)title
                        message:(NSString *)message;

- (void)handleAlertForError: (NSError *) error withTitle:(NSString *)title message:(NSString *)message;

- (void)enqueueAlertWithTitle:(NSString *)title
                      message:(NSString *)message;

@end

@protocol AppAlertsDelegate <NSObject>
@optional
- (void)appAlert:(AppAlerts *)appAlert forError:(NSInteger)error clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
