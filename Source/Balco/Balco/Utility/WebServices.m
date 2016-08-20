#import "WebServices.h"
#import <AFNetworking/AFNetworking.h>

#define kBaseURL @"http://bsapp.app6.in"
#define kLoginEndpoint @"/API/App/LoginAPI.aspx"
#define kVerifyOTPEndpoint @"/API/App/OTPVerficationAPI.aspx"
#define kHomeMessageEndpoint @"/api/app/msg.aspx?id=0"
#define kLeadersVoiceEndpoint @"/API/App/LeadersVoice.aspx"
#define kCategoriesEndpoint @"/API/App/CatagoryAPI.aspx"
#define kPDFsEndpoint @"/API/App/PDFAPI.aspx"
#define kScoresEndpoint @"/API/App/ScoreAPI.aspx"
#define kQuizEndpoint @"/api/app/QuizAPI_advnjsdnfv_ksdnfgn.aspx"

#define kMessageAPISuccessMessage @"success"

@implementation WebServices {
    AFHTTPSessionManager *manager;
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

- (void)loginWithPhoneNumber:(NSString *)mobileNumber success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];

    NSString *urlString = [self urlStringForEndpoint:kLoginEndpoint];
    urlString = [NSString stringWithFormat:@"%@?Mobile=%@",urlString,mobileNumber];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
        failure(error);
    }];
}

- (void)verifyOTP:(NSString *)otp forMobileNumber:(NSString *)mobileNumber success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];
    
     NSString *urlString = [self urlStringForEndpoint:kVerifyOTPEndpoint];
    urlString = [NSString stringWithFormat:@"%@?Mobile=%@&OTP=%@",urlString,mobileNumber,otp];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(responseDict);
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

- (void)fetchLeadersVoiceSuccess:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];
    
    NSString *urlString = [self urlStringForEndpoint:kLeadersVoiceEndpoint];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(responseDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error %@",error);
    }];
}

- (void)fetchCategoriesSuccess:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];
    
    NSString *urlString = [self urlStringForEndpoint:kCategoriesEndpoint];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(responseDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error %@",error);
    }];
}

- (void)fetchPDFsForCategoryId:(NSString *)categoryId success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];
    
    NSString *urlString = [self urlStringForEndpoint:kPDFsEndpoint];
    urlString = [NSString stringWithFormat:@"%@?CatagoryID=%@",urlString,categoryId];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(responseDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error %@",error);
    }];
}

- (void)fetchScoresSuccess:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];
    
    NSString *urlString = [self urlStringForEndpoint:kScoresEndpoint];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(responseDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error %@",error);
    }];
}

- (void)fetchQuizSuccess:(void (^)(NSString *htmlString))success failure:(void (^)(NSError *error))failure {
    [self initializeManager];

    NSString *urlString = [self urlStringForEndpoint:kQuizEndpoint];
    NSString *registeredMobileNumber = [[NSUserDefaults standardUserDefaults] stringForKey:@"registeredMobileNumber"];

    urlString = [NSString stringWithFormat:@"%@?mobile=%@",urlString,registeredMobileNumber];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding];// [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(htmlString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error %@",error);
    }];
}

@end
