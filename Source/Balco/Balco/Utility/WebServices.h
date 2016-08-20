#import <Foundation/Foundation.h>

@interface WebServices : NSObject

- (void)loginWithPhoneNumber:(NSString *)phoneNumber success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (void)verifyOTP:(NSString *)otp forMobileNumber:(NSString *)mobileNumber success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (void)fetchHomeMessageSuccess:(void (^)(NSArray *responseArray))success failure:(void (^)(NSError *error))failure;
- (void)fetchLeadersVoiceSuccess:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (void)fetchCategoriesSuccess:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (void)fetchPDFsForCategoryId:(NSString *)categoryId success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (void)fetchScoresSuccess:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (void)fetchQuizSuccess:(void (^)(NSString *htmlString))success failure:(void (^)(NSError *error))failure;

@end
