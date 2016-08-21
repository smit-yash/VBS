#import "QuizViewController.h"
#import "WebServices.h"

#define kQuizAPISuccessMessage @"success"
#define kBaseURL @"http://bsapp.app6.in"

@interface QuizViewController ()<UIWebViewDelegate>

@end

@implementation QuizViewController {

    __weak IBOutlet UIWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [DisplayUtil showSpinnerOn:self above:self.view];
    [[WebServices new] fetchQuizSuccess:^(NSString *htmlString) {
        [DisplayUtil removeSpinnerFrom:self];
        if (htmlString.length) {
            [webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [DisplayUtil removeSpinnerFrom:self];
    }];
    
    self.title = @"Quiz";
    self.navigationItem.backBarButtonItem.title = @"Back";

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DisplayUtil removeSpinnerFrom:self];
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
