#import "QuizViewController.h"
#import "WebServices.h"

#define kQuizAPISuccessMessage @"success"

@interface QuizViewController ()<UIWebViewDelegate>

@end

@implementation QuizViewController {

    __weak IBOutlet UIWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[WebServices new] fetchQuizSuccess:^(NSString *htmlString) {
        NSLog(@"%@",htmlString);
        if (htmlString.length) {
            [webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    self.navigationItem.backBarButtonItem.title = @"Back";

}

#pragma mark - Web View Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finished");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@",error);
}

@end
