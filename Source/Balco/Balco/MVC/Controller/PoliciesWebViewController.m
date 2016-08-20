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
    } else {
//        [[WebServices new] fetchPDFsForCategoryId:self.categoryId success:^(NSDictionary *responseDict) {
//            
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
    }
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
