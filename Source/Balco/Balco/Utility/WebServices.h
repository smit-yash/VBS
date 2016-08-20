#import <Foundation/Foundation.h>

@interface WebServices : NSObject

- (void)loginWithPhoneNumber:(NSString *)phoneNumber;
- (void)verifyOTP:(NSString *)otp;
- (void)fetchHomeMessageSuccess:(void (^)(NSArray *responseArray))success failure:(void (^)(NSError *error))failure;
- (void)fetchLeadersVoice;
- (void)fetchCategories;
- (void)fetchPDFsForCategoryId:(NSInteger)categoryId;
- (void)fetchScores;
- (void)fetchQuiz;

@end
