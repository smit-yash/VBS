#import "WebServices.h"
#import <AFNetworking/AFNetworking.h>

#define kBaseURL @"http://bsapp.app6.in"
#define kLoginEndpoint @"/API/App/LoginAPI.aspx"
#define kVerifyOTPEndpoint @"/API/App/OTPVerficationAPI.aspx"
#define kHomeMessageEndpoint @"/api/app/msg.aspx?id=0"
#define kLeadersVoiceEndpoint @""
#define kCategoriesEndpoint @""
#define kPDFsEndpoint @""
#define kScoresEndpoint @""
#define kQuizEndpoint @""

#define kLoginSuccessMessage @"otp_sent"
#define kVerifyOTPSuccessMessage @"otp_verified"
#define kMessageAPISuccessMessage @"success"

@implementation WebServices {
    AFHTTPSessionManager *manager;
    NSString *registeredMobileNumber;
}

#pragma mark - Utility

- (void)initializeManager {
    manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
}

- (NSString *)urlStringForEndpoint:(NSString *)endPoint {
    NSString *urlString = @"";
    if (endPoint.length && kBaseURL.length) {
        urlString = [NSString stringWithFormat:@"%@%@",kBaseURL,endPoint];
    }
    return urlString;
}

#pragma mark - API calls

- (void)loginWithPhoneNumber:(NSString *)mobileNumber {
    [self initializeManager];

    NSString *urlString = [self urlStringForEndpoint:kLoginEndpoint];
    urlString = [NSString stringWithFormat:@"%@?Mobile=%@",urlString,mobileNumber];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        if ([[[responseDict objectForKey:@"response"] objectForKey:@"status"] isEqualToString:kLoginSuccessMessage]) {
            registeredMobileNumber = mobileNumber;
            
            //For Ankit : Just For Testing This API
            [self verifyOTP:@"1111"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
}

- (void)verifyOTP:(NSString *)otp {
    [self initializeManager];
    
     NSString *urlString = [self urlStringForEndpoint:kVerifyOTPEndpoint];
    urlString = [NSString stringWithFormat:@"%@?Mobile=%@&OTP=%@",urlString,registeredMobileNumber,otp];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"success %@",responseDict);
        if ([[[responseDict objectForKey:@"response"] objectForKey:@"status"] isEqualToString:kVerifyOTPSuccessMessage]) {
            [[NSUserDefaults standardUserDefaults] setObject:registeredMobileNumber forKey:@"registeredMobileNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            registeredMobileNumber = nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
}

- (void)fetchHomeMessageSuccess:(void (^)(NSArray *responseArray))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];
    
    NSString *urlString = [self urlStringForEndpoint:kHomeMessageEndpoint];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        if ([[[responseDict objectForKey:@"response"] objectForKey:@"status"] isEqualToString:kMessageAPISuccessMessage]) {
            NSArray *homeMessageArray = [NSArray arrayWithArray:(NSArray *)[responseDict  objectForKey:@"data"]];
            success(homeMessageArray);
        } else {
            failure(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error %@",error);
    }];
}

- (void)fetchLeadersVoice {
    
}

- (void)fetchCategories {
    
}

- (void)fetchPDFsForCategoryId:(NSInteger)categoryId {
    
}

- (void)fetchScores {
    
}

- (void)fetchQuiz {
    
}

@end
