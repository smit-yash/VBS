#import "AppAlerts.h"
#import "AppDelegate.h"


@implementation AppAlerts
{
    Boolean instanceIsShowingAlert;
    id <AppAlertsDelegate> delegateObj;
    NSMutableArray *alertQueue;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"Continue", @"Title for button")
                                          otherButtonTitles: nil];
    
    [alert show];
}

+ (void)showAlertWithDelegate:(id)delegate title:(NSString *)title message:(NSString *)message tag:(NSInteger)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: delegate
                                          cancelButtonTitle: NSLocalizedString(@"Continue", @"Title for button")
                                          otherButtonTitles: nil];
    [alert setTag:tag];
    [alert show];
}

+ (void)showOkCancelAlertWithDelegate:(id)delegate
                                title:(NSString *)title
                              message:(NSString *)message
                                  tag:(NSInteger)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: delegate
                                          cancelButtonTitle: NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles: NSLocalizedString(@"OK", nil), nil];
    [alert setTag:tag];
    [alert show];
}

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                  delegate:(id)delegate
                       tag:(NSInteger)tag
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                     message:message
                                                    delegate:delegate
                                           cancelButtonTitle:cancelButtonTitle
                                           otherButtonTitles:nil];
    if (otherButtonTitles != nil) {
        [alert addButtonWithTitle:otherButtonTitles];
        va_list args;
        va_start(args, otherButtonTitles);
        NSString * title = nil;
        for ( ; title; title = va_arg(args,NSString*) ) {
            [alert addButtonWithTitle:title];
        }
        va_end(args);
    }
    
    [alert setTag:tag];
    [alert show];
}

#pragma mark - Alert Queue


/*
  ViewControllers can use the instance method handleAlertForError:withTitle:Message 
  to handle errors arising from a request to XmService.
 
  A single instance of this class will show at most one alert. If the View Controller invokes
  handleAlertForError:... when there is already an alert being shown, the request is ignored.
 
  In the event of an HTTP 410 (Gone) response, the user is invited to upgrade the app, and
  can click on a button to go to the App Store.
 */
- (void)handleAlertForError:(NSError *)error
                  withTitle:(NSString *)title
                    message:(NSString *)message {
    
    [self handleAlertWithDelegate:nil forErrorCode:error withTitle:title message:message];
}

- (void)handleAlertWithDelegate:(id <AppAlertsDelegate>)delegate
                       forErrorCode:(NSError *)error
                      withTitle:(NSString *)title
                        message:(NSString *)message {
    
    delegateObj = delegate;
    
    if (!instanceIsShowingAlert) {
        UIAlertView *alert;
        if (error.code == 410) {
            alert = [[UIAlertView alloc] initWithTitle: title
                                               message: message
                                              delegate: self
                                     cancelButtonTitle: NSLocalizedString(@"Cancel", @"Title for button")
                                     otherButtonTitles: NSLocalizedString(@"Upgrade", @"Upgrade app"), nil];
        }
        else {
            alert = [[UIAlertView alloc] initWithTitle: title
                                               message: message
                                              delegate: self
                                     cancelButtonTitle: NSLocalizedString(@"Continue", @"Title for button")
                                     otherButtonTitles: nil];
        }
        
        instanceIsShowingAlert = YES;
        alert.tag = error.code;
        
        // Delegate references are usually weak, so we need to arrange for
        // some object to have a strong reference to this object or ARC will cause it to be cleaned up
        // and when alertView:clickedButtonAtIndex: is invoked, the app will crash.
        ((AppDelegate *)[UIApplication sharedApplication].delegate).appAlert = self;
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertQueue) {
        if (alertQueue.count) {
            [alertQueue removeObjectAtIndex:0];
            
            if (alertQueue.count) {
                UIAlertView *alert = [alertQueue firstObject];
                [alert show];
            }
        }
    } else {
        instanceIsShowingAlert = NO;
        
        switch (alertView.tag) {
            case 410:
                // only register and segue when OK was clicked
                if (buttonIndex == 1) {
                    NSURL *url = [NSURL URLWithString:NSLocalizedString(@"Upgrade_App_URL", @"URL of the app in the App Store")];
                    
                    [[UIApplication sharedApplication] openURL:url];
                }
                break;
                
            default:
                if (delegateObj) {
                    [delegateObj appAlert:self forError: alertView.tag clickedButtonAtIndex:buttonIndex];
                }
                break;
        }
    }
    
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).appAlert = nil;
}

@end
