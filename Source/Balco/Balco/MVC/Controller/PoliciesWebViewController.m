#import "PoliciesWebViewController.h"
#import "WebServices.h"
#define kQuizAPISuccessMessage @"success"

@interface PoliciesWebViewController () <UIWebViewDelegate>

@end

@implementation PoliciesWebViewController {

	__weak IBOutlet UIWebView *webView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    if (self.selectedDict) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.selectedDict objectForKey:@"Filename"]]]];
        self.title = [self.selectedDict objectForKey:@"Title"];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DisplayUtil removeSpinnerFrom:self];
}

#pragma mark - Web View Delegate

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
		navigationType:(UIWebViewNavigationType)navigationType {
    [DisplayUtil showSpinnerOn:self above:self.view];
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"finished");
    [DisplayUtil removeSpinnerFrom:self];
}

- (void)webView:(UIWebView *)webView
    didFailLoadWithError:(nullable NSError *)error {
	NSLog(@"%@", error);
    [[AppAlerts new] handleAlertForError:error withTitle:@"Error" message:error.description];

    [DisplayUtil removeSpinnerFrom:self];
}

@end
