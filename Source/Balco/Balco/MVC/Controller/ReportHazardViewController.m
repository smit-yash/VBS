#import "ReportHazardViewController.h"
#import "WebServices.h"
#import "SimpleTableViewCell.h"

@interface ReportHazardViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ReportHazardViewController {
    UIAlertView *alert;
    __weak IBOutlet UILabel *typeLabel;
    __weak IBOutlet UILabel *locationLabel;
    __weak IBOutlet UITextView *descriptionTextView;
    __weak IBOutlet UITableView *typeTableView;
    __weak IBOutlet UITableView *locationTableView;
    __weak IBOutlet UIButton *cameraIconOutlet;
    
    NSArray *typeArray;
    NSArray *locationsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    typeTableView.layer.shadowOffset = CGSizeMake(1, 1);
    typeTableView.layer.shadowColor = [UIColor grayColor].CGColor;
    typeTableView.layer.masksToBounds = NO;
    typeTableView.layer.shadowOpacity = 0.8f;
    typeTableView.layer.shadowRadius = 2;
    
    locationTableView.layer.shadowOffset = CGSizeMake(1, 1);
    locationTableView.layer.shadowColor = [UIColor grayColor].CGColor;
    locationTableView.layer.masksToBounds = NO;
    locationTableView.layer.shadowOpacity = 0.8f;
    locationTableView.layer.shadowRadius = 2;
    
    typeArray = [[NSArray alloc] initWithObjects:@"Type",@"Unsafe Act",@"Unsafe Condition",@"Environmental Incident",@"Positive Act",@"Positive Condition", nil];
    locationsArray = [[NSArray alloc] initWithObjects:@"Location",@"1200 MW PP",@"Bake Oven 1",@"Bake Oven 2",@"BOP FLA",@"BOP HMA",@"CH 2",@"CH 3",@"CPP 540 MW",@"CPP1",@"Foundry",@"GAP 1",@"GAP 2",@"Potline 1",@"Potline 2",@"Rodding 1",@"Rodding 2",@"SRS", nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]
	    removeObserver:self
     name:UIKeyboardWillShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
	    removeObserver:self
     name:UIKeyboardWillHideNotification
     object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]
	    addObserver:self
     selector:@selector(keyboardDidShow:)
		   name:UIKeyboardWillShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
	    addObserver:self
     selector:@selector(keyboardDidHide:)
		   name:UIKeyboardWillHideNotification
     object:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"Report Hazard";
}

#pragma mark - Button Actions

- (IBAction)cameraButtonAction:(id)sender {
    [self showAlertForPhotos];
}
- (IBAction)typeButtonAction:(id)sender {
    [typeTableView reloadData];
    typeTableView.hidden = NO;
    locationTableView.hidden = YES;
    [self dismissKeyboard];

}
- (IBAction)locationButonAction:(id)sender {
    [locationTableView reloadData];
    locationTableView.hidden = NO;
    typeTableView.hidden = YES;
    [self dismissKeyboard];

}

- (IBAction)submit:(id)sender {
    [self dismissKeyboard];
    
    if (![typeLabel.text isEqualToString:@"Type"] && ![locationLabel.text isEqualToString:@"Location"]) {
        //API Call
    } else {
        //alert
    }
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (tableView == typeTableView) {
        return typeArray.count;
    } else {
        return locationsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == typeTableView) {
        SimpleTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"TypeCell"];
        cell.titleLabel.text = typeArray[indexPath.row];
        if (indexPath.row) {
            cell.titleLabel.textColor = [UIColor blackColor];
        } else {
            cell.titleLabel.textColor = [UIColor colorWithRed:0.458824 green:0.74902 blue:0.266667 alpha:1];;
        }
        return cell;
    } else {
        SimpleTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
        cell.titleLabel.text = locationsArray[indexPath.row];
        
        if (indexPath.row) {
            cell.titleLabel.textColor = [UIColor blackColor];
        } else {
            cell.titleLabel.textColor = [UIColor colorWithRed:0.458824 green:0.74902 blue:0.266667 alpha:1];;
        }
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self dismissKeyboard];

    if (tableView == typeTableView) {
        typeLabel.text = typeArray[indexPath.row];
        typeTableView.hidden = YES;
        if (indexPath.row) {
            typeLabel.textColor = [UIColor blackColor];
        } else {
            typeLabel.textColor = [UIColor colorWithRed:0.458824 green:0.74902 blue:0.266667 alpha:1];
        }
    } else {
        locationLabel.text = locationsArray[indexPath.row];
        locationTableView.hidden = YES;
        if (indexPath.row) {
            locationLabel.textColor = [UIColor blackColor];
        } else {
            locationLabel.textColor = [UIColor colorWithRed:0.458824 green:0.74902 blue:0.266667 alpha:1];
        }
    }

}

#pragma mark - TextView

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Enter short description about the unsafe situations with your details."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self.view setFrame:CGRectMake(0, -kbSize.height, self.view.frame.size.width,
                                   self.view.frame.size.height)];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                   self.view.frame.size.height)];
}

- (void)dismissKeyboard {
    [descriptionTextView resignFirstResponder];
}

- (void)showAlertForPhotos {
    alert = [[UIAlertView alloc] initWithTitle: @"Add Photo!"
                                                    message: nil
                                                   delegate: self
                                          cancelButtonTitle: NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles: NSLocalizedString(@"Camera", nil),NSLocalizedString(@"Gallery", nil), nil];
    
    [alert setTag:101];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Camera" message:@"Unable to start Camera" delegate:nil                                                                                                                                                                                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [myAlertView show];
            } else {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:NULL];
            }
        } else if (buttonIndex == 2){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [cameraIconOutlet setImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
