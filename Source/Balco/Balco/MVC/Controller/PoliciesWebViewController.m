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
	[[WebServices new] fetchQuizSuccess:^(NSString *htmlString) {
	  NSLog(@"%@", htmlString);
	  if (htmlString.length) {
		  [webView loadHTMLString:htmlString
				  baseURL:[[NSBundle mainBundle] bundleURL]];
	  }
	}
	    failure:^(NSError *error) {
	      NSLog(@"%@", error);
	    }];
}

#pragma mark - Web View Delegate

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
		navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"finished");
}

- (void)webView:(UIWebView *)webView
    didFailLoadWithError:(nullable NSError *)error {
	NSLog(@"%@", error);
}

@end
