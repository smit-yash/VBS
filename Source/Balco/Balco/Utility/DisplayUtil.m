#import "DisplayUtil.h"

@implementation DisplayUtil

static const NSInteger SPINNER_ANIMATION_TAG = 100;

/**
 * Round the value provided to a maximum of 3 significant figures, using K, M and B for numbers larger than 999
 */
+ (NSString *) getCountString:(long) toConvert {
    NSString *result;
    
    if (toConvert < 1000) {
        result = [[NSNumber numberWithLong:toConvert] stringValue];
    } else {
        double sig = toConvert;
        
        NSString *unit = @"";
        
        if (toConvert >= 1e9) {
            sig = toConvert / 1e9;
            unit = @"B";
        } else if (toConvert >= 1e6) {
            sig = toConvert / 1e6;
            unit = @"M";
        } else if (toConvert >= 1e3) {
            sig = toConvert / 1e3;
            unit = @"K";
        }
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
        
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.usesSignificantDigits = YES;
        numberFormatter.maximumSignificantDigits = 3;
        numberFormatter.roundingMode = NSNumberFormatterRoundHalfUp;
        
        result = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:sig]];
        result = [result stringByAppendingString:unit];
    }
    
    return result;
}

+ (void)showSpinnerOn: (UIViewController *)viewController above:(UIView *)above{
    if ([self spinnerExistsOn:viewController]) {
        [self removeSpinnerFrom:viewController];
    }
    
    UIActivityIndicatorView *mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    
    mySpinner.center = CGPointMake(viewController.view.bounds.size.width/2, viewController.view.bounds.size.height/2);
    mySpinner.color = [UIColor darkGrayColor];
    
    [mySpinner startAnimating];
    [mySpinner setTag:SPINNER_ANIMATION_TAG];
    [viewController.view insertSubview:mySpinner aboveSubview:above];
}

+ (void)showSpinnerOn: (UIViewController *)viewController OnView:(UIView *)view {
	if ([self spinnerExistsOn:viewController]) {
		[self removeSpinnerFrom:viewController];
	}
	
	UIActivityIndicatorView *mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
	mySpinner.center = CGPointMake(view.bounds.size.width/2,view.bounds.size.height/2);
	mySpinner.color = [UIColor darkGrayColor];
	[view addSubview:mySpinner];

	[mySpinner startAnimating];
	[mySpinner bringSubviewToFront:view];
	[mySpinner setTag:SPINNER_ANIMATION_TAG];
}

+ (void)removeSpinnerFrom: (UIViewController *)from {
    UIView *mySpinner = [from.view viewWithTag:SPINNER_ANIMATION_TAG];
    [mySpinner removeFromSuperview];
}

+ (BOOL)spinnerExistsOn: (UIViewController *) on {
    UIView *mySpinner = [on.view viewWithTag:SPINNER_ANIMATION_TAG];
    return !mySpinner ? NO : YES;
}

+ (void)removeInsetsAndMarginsOnTableView:(UITableView *)tableView cell:(UITableViewCell *)cell {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
