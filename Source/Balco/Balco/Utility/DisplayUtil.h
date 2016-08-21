#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DisplayUtil : NSObject
+ (NSString *) getCountString:(long) toConvert;

+ (void)showSpinnerOn: (UIViewController *)on above:(UIView *)above;
+ (void)showSpinnerOn: (UIViewController *)on OnView:(UIView *)view;
+ (void)removeSpinnerFrom: (UIViewController *)from;
+ (BOOL)spinnerExistsOn: (UIViewController *) on;

+ (void)removeInsetsAndMarginsOnTableView:(UITableView *)tableView cell:(UITableViewCell *)cell;

@end
