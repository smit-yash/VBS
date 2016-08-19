#import "WebServices.h"
#import <AFNetworking/AFNetworking.h>

#define kBaseURL @"http://bsapp.app6.in"
#define kLoginEndpoint @""
#define kVerifyOTPEndpoint @""
#define kHomeMessageEndpoint @""
#define kLeadersVoiceEndpoint @""
#define kCategoriesEndpoint @""
#define kPDFsEndpoint @""
#define kScoresEndpoint @""
#define kQuizEndpoint @""

@implementation WebServices {
    AFHTTPSessionManager *manager;
}

- (void)loginWithPhoneNumber:(NSInteger)phoneNumber {
    
}

- (void)verifyOTP:(NSInteger)otp {
    
}

- (void)fetchHomeMessageWithId:(NSInteger)id {
    
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
